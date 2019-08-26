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
    
def cleanup():
    removeDirectory("bashCommands")
    removeDirectory("shellfiles")
    removeDirectory("dfiles")
    removeDirectory("dlogs")
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
    for filepath in glob.glob('sconedocs/docs/*.md'):
        #print filepath
        head, filename = os.path.split(filepath)
        filename=filename.replace(".md", "")
        #print filename
        #Split lines
        prepareContent=prepareFile(filepath)
        #Give it for extraction
        code=extractCode(prepareContent)
        if (code):
            #WriteContent to a file
            f = open("bashCommands/"+filename+".sh", "w")
            f.write(code)
            f.close()
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
    return code

#To Remove
def executeShell():
    f=open('bashCommands/test.sh', "r")
    for i in f.read().splitlines():
        child = pexpect.spawn("docker pull sconecuratedimages/crosscompilers")
        child = pexpect.spawn("docker run -it sconecuratedimages/crosscompilers")
        child.sendline(i)
        child.expect("ubuntu@ip-172-31-39-63:~")
        # We can print child.before, which will contain everything before the last child.expect.
        print(child.before)
    
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
    print container.logs()
    
    s = open("dlogs/"+nameDfile,"w")
    s.write(container.logs())
    
    print "Removing the container " + dPath
    client.containers.prune()
    s.close()
    
def main():
    setup()
    getAllFiles()
    #executeShell()
    #getAllExtractedShellDockerfiles()
    executeAllDockerfiles()
    #executeDocker("C")

    #cleanup()
     
if __name__== "__main__":
  main()