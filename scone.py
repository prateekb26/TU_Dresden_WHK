import urllib
import glob
import os

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

def main():
    getAllFiles()
     
if __name__== "__main__":
  main()