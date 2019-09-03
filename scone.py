import urllib
import glob
import os
import errno
import re
import docker
import shutil
import time

def setup():
    createDirectory("bashCommands")
    createDirectory("shellfiles")
    createDirectory("dfiles")
    createDirectory("dlogs")
    createDirectory("bashOutput")
    
def cleanup():
    removeDirectory("bashCommands")
    removeDirectory("shellfiles")
    removeDirectory("dfiles")
    removeDirectory("dlogs")
    removeDirectory("bashOutput")
#Function to create Directory if not existing
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
            print filename
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
            s = open("bashOutput/"+filename+".out", "w")
            s.write(output)
            s.close()
        else:
            print filename + ".md doesn't not contain any shell code hence no shell file will be generated"

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
            code = code + "\n" + "echo next"
    return code
    
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
    s = open("shellfiles/"+name+".sh","w")
    for i in f.read().splitlines():
        if (i.find("docker pull") != -1):
            m=re.search('docker pull\s+(.*)',i)
            makeDockerFile(name,m.group(1))
        if(i.find("docker") == -1):
           s.write(i+"\n")
    s.close()
    f.close()
    #executeDocker(name)
    
def makeDockerFile(dockerFile,rep):
    n = open("dfiles/"+dockerFile, "w")
    n.write("FROM "+ rep+"\n")
    n.write("COPY shellfiles/"+dockerFile+".sh /"+"\n")
    n.write("CMD [\"bash\", \"/"+ dockerFile+".sh\"]"+"\n")
    n.close()

def executeAllDockerfiles():

    for filepath in glob.glob('dfiles/*'):
        #print filepath
        head, filename = os.path.split(filepath)
        #print filename
        if(filename == "C" or filename == "Cplusplus") :
            executeDocker(filename)

def executeDocker(nameDfile):
    
    client = docker.from_env()
    dPath = "dfiles/"+nameDfile
    dTag= "dockertagfor"+nameDfile.lower()
    dlogs = "dockerlogs"+nameDfile.lower()
    
    print "\n\nPulling the container for " + dPath +" with tag " + dTag+ " it will take time"
    try:
        image = client.images.build(dockerfile=dPath,tag=dTag,path='.')
    except docker.errors.APIError as Err:
        print "Error Executing Docker "
    
    
    print "Executing the container " + dPath + "and dropping logs at " + dlogs
    try:
        container = client.containers.run(dTag,name=dlogs)
    except docker.errors.APIError as Err:
        print "Error running Docker "
                
    print "Fetching the Execution logs of the container " + dPath
    container = client.containers.get(dlogs)
    
    print "Sleeping for 5 seconds to fetch logs"
    #print container.logs()
    
    s = open("dlogs/"+nameDfile,"w")
    s.write(container.logs())
    
    print "Removing the container " + dPath
    client.containers.prune()
    s.close()

def checkAllOutput():
    for filepath in glob.glob('dlogs/*'):
        #print filepath
        head, filename = os.path.split(filepath)
        checkOutput(filename)
        #print filename
        
def checkOutput(filename):
    passflag=1
    DlogFile=open("dlogs/"+filename).read()
    f = open("bashOutput/"+filename+".out")
    print "***********Checking for***********" + filename

    for i in f.read().splitlines():
        i=i.strip()
        if (i!="\n" and i!= ""):
            if(i in DlogFile):
                print "output found = " + i
            else:
                print "output not found = "+ i
                passflag=0
    
    if passflag == 0:
        print "Test failed output is different from actual execution" + filename
    else:
        print "Test Passed output " + filename

def main():
    setup()
    getAllFiles()
    getAllExtractedShellDockerfiles()
    executeAllDockerfiles()
    checkAllOutput()
    
    #executeDocker("C")

    #cleanup()
     
if __name__== "__main__":
  main()