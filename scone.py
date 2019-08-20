import urllib
import glob
import os
import errno
import re


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

def prepareFile(path):
    f=open(path, "r")
    return f.read().splitlines()

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

def executeShell():
    f=open('bashCommands/test.sh', "r")
    for i in f.read().splitlines():
        child = pexpect.spawn("docker pull sconecuratedimages/crosscompilers")
        child = pexpect.spawn("docker run -it sconecuratedimages/crosscompilers")
        child.sendline(i)
        child.expect("ubuntu@ip-172-31-39-63:~")
        # We can print child.before, which will contain everything before the last child.expect.
        print(child.before)

def createFiles():
    f=open('bashCommands/C++.sh', "r")

    createDirectory("shellfiles")
    n = open("dfiles/DockerFileC++", "w")
    s = open("shellfiles/shellind.sh", "w")
    for i in f.read().splitlines():
        if (i.find("docker pull") != -1):
            m=re.search('docker pull\s+(.*)',i)
            makeDockerFile(m.group(1))
        if(i.find("docker") == -1):
           s.write(i+"\n")
    s.close()
    n.close()

def makeDockerFile(rep):
    createDirectory("dfiles")
    n = open("dfiles/DockerFileC++", "w")
    n.write("FROM "+ rep+"\n")
    n.write("COPY shellfiles/shellind.sh /"+"\n")
    n.write("CMD [\"bash\", \"/shellind.sh\"]"+"\n")
    n.close()
    

def main():
    getAllFiles()
    #executeShell()
    createFiles()
     
if __name__== "__main__":
  main()