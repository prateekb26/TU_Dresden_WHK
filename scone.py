import urllib

def getURL():
    link = "https://raw.githubusercontent.com/doflink/sconedocs/master/docs/C%2B%2B.md?token=ALZKBWER44JGY3VPN7CKTMS5ADOPKl"
    f = urllib.urlopen(link)
    rawContent = f.read().splitlines()
    return rawContent

def getPath():
    path = "sconedocs/docs/C++.md"
    f=open(path, "r")
    return f.read().splitlines()

def extractCode():
    code = ""
    rawContent=getPath()
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
    code=extractCode()  
    print code
     
if __name__== "__main__":
  main()