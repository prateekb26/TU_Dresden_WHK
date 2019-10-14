import urllib
import glob
import os
import errno
import re
import docker
import shutil
import time

#Scone Related
#Expected output not found in the file as === export SCONE_KERNEL=0
#Expected output not found in the file as === export SCONE_STACK=81920
#Expected output not found in the file as === export SCONE_SGXBOUNDS=no
#Expected output not found in the file as === export SCONE_VARYS=no
#Expected output not found in the file as === Configure options: --enable-shared --enable-debug --prefix=/mnt/ssd/franz/subtree-scone2/built/cross-compiler/x86_64-linux-musl


mdFilename = "SCONE_CLI"

#This will create Directories
def setup():
    createDirectory("bashCommands")
    createDirectory("shellfilesforDocker")
    createDirectory("dockerfiles")
    createDirectory("dockerexecutionlogs")
    createDirectory("bashOutputtocompare")
    createDirectory("testSummary")

#This will remove Directories
def cleanup():
    removeDirectory("bashCommands")
    removeDirectory("shellfilesforDocker")
    removeDirectory("dockerfiles")
    removeDirectory("dockerexecutionlogs")
    removeDirectory("bashOutputtocompare")
    
#Function to actually create Directory if not existing based on the parameter
def createDirectory(dirName): 
    try:
    # Create target Directory
        os.mkdir(dirName)
        print("Directory " , dirName ,  " Created ") 
    except OSError as e:
        if e.errno == errno.EEXIST:
            print("Directory " , dirName ,  " already exists")
        else:
            raise

#Function to actually remove Directory based on the parameter
def removeDirectory(dirName):
    try:
        shutil.rmtree(dirName)
    except OSError as e:
        print ("Error: %s - %s." % (e.filename, e.strerror))

#Function to get all .md files and create .sh files
def getAllFiles():
    output=""
    for filepath in glob.glob('sconedocs/docs/*.md'):
        #print filepath
        head, filename = os.path.split(filepath)
        filename=filename.replace(".md", "")
        if (filename == "C++") :
            
            filename=filename.replace("++","plusplus")
        #print filename
        #Split lines
        prepareContent=prepareFile(filepath)
        #Give it for extraction
        code=extractCode(prepareContent)
        output=extractOutput(prepareContent)
        if (code):
            #WriteContent to a file
            f = open("bashCommands/"+filename+".sh", "w")
            f.write(code)
            f.close()
            #WriteOutput to a file
            s = open("bashOutputtocompare/"+filename+".out", "w")
            s.write(output)
            s.close()
        else:
            print filename + ".md doesn't not contain any shell code hence no test will be conducted for these file"

#Function to Read content to be read from .Md files
def prepareFile(path):
    f=open(path, "r")
    return f.read().splitlines()

#Function to extract bash code
def extractCode(rawContent):
    code = ""
    count=0
    for i in rawContent:
        if (i.find("```") != -1):
            count=2
        #if count is 2 we need to reset as code part is extracted
        if count == 2:
            count = 0
        #If count is >=1 it means we are in code section '''
        if (count == 1):
            code = code + "\n" + i
        #find the first ''' to start saving the code 
        if (i.find("```bash") != -1):
            count = count + 1
            code = code + "\n"
    return code

#Function to extract output of bash commands
#If bash is not found then only enter the loop and if bash is found set markbash flag =1
#if instead only ''' is found and it is beginning of the block and bash is not marked then we found correct block
#if beginning is marked and bash is not marked then we start copying the output until we find '''
#if bash is marked and we find ''' then it means this is end of bash block hence markbash=0
def extractOutput(rawContent):
    tcode = ""
    markbeginning=0
    code=""
    markbash=0;
    for i in rawContent:
        if(i.find("```bash") == -1):
            if(i.find("```")!=-1 and markbeginning==0 and markbash ==0):
                markbeginning = 1   
            elif(i.find("```")==-1 and markbeginning==1 and markbash==0):
                if(tcode != '\n'):
                    tcode = tcode + i + "\n"   
            elif(i.find("```")!=-1 and markbeginning==1 and markbash==0):
                markbeginning = 0
            elif(i.find("```")!=-1 and markbash==1):
                markbash=0
        elif(i.find("```bash") != -1):
            markbash = 1;
    return tcode

#Function to extract actual shell code from extracted bash code 
def getAllExtractedShellDockerfiles():

    for filepath in glob.glob('bashCommands/*.sh'):
        #print filepath
        head, filename = os.path.split(filepath)
        filename=filename.replace(".sh", "")
        #print filename
        createFiles(filename)
        
#Function to create actual docker files and bashFiles
def createFiles(name):
    f=open("bashCommands/"+name+".sh","r")
    s = open("shellfilesforDocker/"+name+".sh","w")
    for i in f.read().splitlines():
        if (i.find("docker pull") != -1):
            m=re.search('docker pull\s+(.*)',i)
            makeDockerFile(name,m.group(1))
        if(i.find("docker") == -1):
           s.write(i+"\n")
        if(i.find("FirstExampleEnds") == 0):
            break
    s.close()
    f.close()
    #executeDocker(name)
    
#Function to actually create Docker file based on Paramters 
def makeDockerFile(dockerFile,rep):
    n = open("dockerfiles/"+dockerFile, "w")
    n.write("FROM "+ rep+"\n")
    n.write("COPY shellfilesforDocker/"+dockerFile+".sh /"+"\n")
    n.write("CMD [\"sh\", \"/"+ dockerFile+".sh\"]"+"\n")
    n.close()

#File Checked
#C.md
#C++.md
#Fortan.me
#

#Function to execute all docker files
def executeAllDockerfiles():

    for filepath in glob.glob('dockerfiles/*'):
        #print filepath
        head, filename = os.path.split(filepath)
        #print filename
        if(filename == mdFilename) :
            executeDocker(filename)

#Function to actual execute docker file based on parameter
def executeDocker(nameDfile):
    
    client = docker.from_env()
    dPath = "dockerfiles/"+nameDfile
    dTag= "dockertagfor"+nameDfile.lower()
    dockerexecutionlogs = "dockerlogs"+nameDfile.lower()
    
    print "\n\nPulling the container for " + dPath +" with tag " + dTag+ " it will take time"
    try:
        image = client.images.build(dockerfile=dPath,tag=dTag,path='.')
    except docker.errors.APIError as Err:
        print "Error Executing Docker "
    
    
    print "Executing the container " + dPath + " and dropping logs at " + dockerexecutionlogs
    try:
        container = client.containers.run(dTag,name=dockerexecutionlogs)
    except docker.errors.APIError as Err:
        print "Error running Docker "
      
    print "Fetching the Execution logs of the container " + dPath
    container = client.containers.get(dockerexecutionlogs)
    
    print "Sleeping for 5 seconds to fetch logs"
    #print container.logs()
    
    s = open("dockerexecutionlogs/"+nameDfile,"w")
    s.write(container.logs())
    
    print "Removing the container " + dPath
    client.containers.prune()
    s.close()

#Function to check actual vs expected output
def checkAllOutput():
    for filepath in glob.glob('dockerexecutionlogs/*'):
        #print filepath
        head, filename = os.path.split(filepath)
        if(filename == mdFilename) :
            checkOutput(filename)
        #print filename
        
#Function to check actual vs expected output based on Parameters
def checkOutput(filename):
    passflag=1
    numberOfTestcases =0
    numberOfTestcasesPassed=0
    numberOfTestcasesFailed=0
    passFile = open("testSummary/"+filename+".pass","w")
    failFile = open("testSummary/"+filename+".fail","w")
    summaryFile = open("testSummary/"+filename+".summary","w")
    DlogFile=open("dockerexecutionlogs/"+filename).read()
    f = open("bashOutputtocompare/"+filename+".out")

    for i in f.read().splitlines():
        i=i.strip()
        if (i!="\n" and i!= ""):
            numberOfTestcases = numberOfTestcases + 1
            if(i in DlogFile):
                numberOfTestcasesPassed = numberOfTestcasesPassed + 1
                temp = "Expected output found as ===" + i + "\n"
                passFile.write(temp)
            else:
                temp = "Expected output not found in the file as === "+ i + "\n"
                passflag=0
                numberOfTestcasesFailed = numberOfTestcasesFailed +1
                failFile.write(temp)
    
    if passflag != 0:
        #print "Test Passed output " + filename
        os.remove("testSummary/"+filename+".fail")
        
    print "=======================Test Summary for " + filename + "======================="
    print "NumberOfTestcases : %d "  %(numberOfTestcases)
    print "NumberOfTestcasesPassed : %d"  %(numberOfTestcasesPassed)
    print "NumberOfTestcasesFailed : %d "  %(numberOfTestcasesFailed)
    print "**********************Test Summary End**********************"
    summaryFile.write("=======================Test Summary======================="+ "\n")
    summaryFile.write("NumberOfTestcases : %d \n"  %(numberOfTestcases))
    summaryFile.write("NumberOfTestcasesPassed : %d \n"  %(numberOfTestcasesPassed))
    summaryFile.write("NumberOfTestcasesFailed : %d \n"  %(numberOfTestcasesFailed))
    summaryFile.write("=======================Test Summary=======================")
    passFile.close()
    failFile.close()
    summaryFile.close()

#Main to call all Functions
def main():
    setup()
    getAllFiles()
    getAllExtractedShellDockerfiles()
    executeAllDockerfiles()
    checkAllOutput()
    
    #executeDocker("C")

#Uncomment the cleanup if you really want cleanup
    #cleanup()
     
if __name__== "__main__":
  main()