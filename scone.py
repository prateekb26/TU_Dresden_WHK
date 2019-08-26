import urllib
import glob
import os
import errno
import re
import docker

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

#Function to get all .md files and create .sh files
def getAllFiles():
    for filepath in glob.glob('sconedocs/docs/*.md'):
        print filepath
        head, filename = os.path.split(filepath)
        filename=filename.replace(".md", "")
        print filename
        #Split lines
        prepareContent=prepareFile(filepath)
        #Give it for extraction
        code=extractCode(prepareContent)
        
        #WriteContent to a file
        createDirectory("bashCommands")
        f = open("bashCommands/"+filename+".sh", "w")
        f.write(code)
        f.close()

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
    
def getAllExtractedShellDockerfiles():
    createDirectory("shellfiles")
    createDirectory("dfiles")
    createDirectory("dlogs")
    for filepath in glob.glob('bashCommands/*.sh'):
        #print filepath
        head, filename = os.path.split(filepath)
        filename=filename.replace(".sh", "")
        #print filename
        createFiles(filename)

def makeDockerFile(name,rep):
    n = open("dfiles/"+name, "w")
    n.write("FROM "+ rep+"\n")
    n.write("COPY shellfiles/"+name+".sh /"+"\n")
    n.write("CMD [\"bash\", \"/"+ name+".sh\"]"+"\n")
    n.close()
    executeDocker(name)

def executeDocker(nameDfile):
    print nameDfile
    client = docker.from_env()
    dPath = "dfiles/"+nameDfile
    print dPath
    dTag= "dockertagfor"+nameDfile.lower()
    print dTag
    print "Pulling the container it will take time"
    image = client.images.build(dockerfile=dPath,tag=dTag,path='.')
    print "Executing the container"
    container = client.containers.run(dTag,name='testitpython')
    print "Fetching the Execution logs of the container"
    container = client.containers.get('testitpython')
    print dPath
    print container.logs()
    s = open("dlogs/"+nameDfile,"w")
    s.write(container.logs())
    container.remove
    
def main():
    getAllFiles()
    #executeShell()
    #getAllExtractedShellDockerfiles()
    executeDocker("C")
     
if __name__== "__main__":
  main()