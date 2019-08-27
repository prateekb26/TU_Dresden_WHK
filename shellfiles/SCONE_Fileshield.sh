
echo next
> mkdir -p volume
> mkdir -p data-original
echo next
cat > data-original/hello.txt << EOF
Hello World
EOF
cat > data-original/world.py << EOF
f = open('/data/hello.txt', 'r')
print str(f.read())
EOF
echo next
> ls volume
> shasum data-original/*
648a6a6ffffdaa0badb23b8baf90b6168dd16b3a  data-original/hello.txt
deda99d44e880ea8f2250f45c5c20c15d568d84c  data-original/world.py
echo next
echo next
$ cd /data
$ scone fspf create fspf.pb
Created empty file system protection file in fspf.pb. AES-GCM tag: 0e3da7ad62f5bc7c7bb08c67b16f2423
echo next
$ scone fspf addr fspf.pb / --kernel / --not-protected
Added region / to file system protection file fspf.pb new AES-GCM tag: dd961af10b5aaa5cb1044c35a3f42c84
echo next
$ scone fspf addr fspf.pb /data --encrypted --kernel /data
Added region /data to file system protection file fspf.pb new AES-GCM tag: 8481369d3ffdd9b6aeb30d044bf5c1c7
echo next
$ scone fspf addf fspf.pb /data /data-original /data
Added files to file system protection file fspf.pb new AES-GCM tag: 39a268166e628cf76e3fca80aa2d4f63
echo next
$ shasum /data/*
87fd97468024e3d2864516ff5840e15d9615340d  /data/fspf.pb
31732914910f4a08b9832c442074b0932915476c  /data/hello.txt
8d07f3f576785c373a5e70e8dbcfa8ee06ca6d0c  /data/world.py
$ shasum /data-original/*
648a6a6ffffdaa0badb23b8baf90b6168dd16b3a  /data-original/hello.txt
deda99d44e880ea8f2250f45c5c20c15d568d84c  /data-original/world.py
echo next
$ scone fspf encrypt fspf.pb > /data-original/keytag
echo next
$ cat > example.c << EOF
#include <stdio.h>
#include <stdlib.h>

void printfile(const char* fn) {
    FILE *fp = fopen(fn, "r");
    char c;
    while((c=fgetc(fp))!=EOF){
        printf("%c",c);
    }
    fclose(fp);
}

int main() {
    printfile("/data/hello.txt");
    printfile("/data/world.py");
}
EOF
echo next
scone gcc example.c -o example
echo next
$./example
R??C?
    q?z??E??|Ю?}ü ?o
$??!rga??·*`?????????Gw?
echo next
$ export SCONE_FSPF_KEY=$(cat /data-original/keytag | awk '{print $11}')
$ export SCONE_FSPF_TAG=$(cat /data-original/keytag | awk '{print $9}')
$ export SCONE_FSPF=/data/fspf.pb
echo next
$ ./example
Hello World
f = open('/data/hello.txt', 'r')
print str(f.read())
echo next
echo next
$ cat /data/world.py
?=??J??0?6+?Q?nKd?*N,??.?G???????R?cO?t?y??>f?
echo next
$ export SCONE_FSPF_KEY=... extract from data-original/keytag ...
$ export SCONE_FSPF_TAG=... extract from data-original/keytag ...
$ export SCONE_FSPF=/data/fspf.pb
echo next
SCONE_HEAP=100000000 SCONE_ALPINE=1 SCONE_VERSION=1 /usr/local/bin/python /data/world.py
export SCONE_QUEUES=1
...
Hello World
echo next
$ scone fspf addr fspf.pb / --kernel / --authenticated
echo next
echo next
echo next
apt-get update
echo next
echo next
$ cd
$ mkdir -p rootvol
echo next
echo next
$ rm -rf rootvol/dev rootvol/proc rootvol/bin rootvol/media rootvol/mnt rootvol/usr/share/X11 rootvol/usr/share/terminfo rootvol/optrootvol/usr/include/c++/ rootvol/usr/lib/tcl8.6 rootvol/usr/lib/gcc rootvol/opt rootvol/sys rootvol/usr/include/c++
echo next
$ scone fspf create fspf.pb
$ scone fspf addr fspf.pb / --kernel / --authenticated
$ scone fspf addf fspf.pb / ./rootvol /
$ scone fspf encrypt fspf.pb > keytag
echo next
$ cat > Dockerfile << EOF
FROM sconecuratedimages/apps:python-2.7-alpine3.6
COPY fspf.pb /
EOF
echo next
echo next
$ export SCONE_FSPF_KEY=... extract from data-original/keytag ...
$ export SCONE_FSPF_TAG=... extract from data-original/keytag ...
$ export SCONE_FSPF=/fspf.pb
echo next
SCONE_HEAP=1000000000 SCONE_ALLOW_DLOPEN=2  SCONE_ALPINE=1 SCONE_VERSION=1 /usr/local/bin/python
echo next
$ cat > helloworld-manual.py << EOF
print "Hello World"
EOF
echo next
$ export SCONE_FSPF_KEY=... extract from data-original/keytag ...
$ export SCONE_FSPF_TAG=... extract from data-original/keytag ...
$ export SCONE_FSPF=/fspf.pb
$ SCONE_HEAP=1000000000 SCONE_ALLOW_DLOPEN=2  SCONE_ALPINE=1 SCONE_VERSION=1 /usr/local/bin/python helloworld-manual.py
(fails)
echo next
$ SCONE_HEAP=1000000000 SCONE_FSPF_MUTABLE=1 SCONE_ALLOW_DLOPEN=2  SCONE_ALPINE=1 SCONE_VERSION=1 /usr/local/bin/python  << PYTHON
f = open('helloworld.py', 'w')
f.write('print "Hello World"\n')
f.close()
echo next
$ export SCONE_FSPF_TAG=$(scone fspf show --tag /fspf.pb)
echo next
$ SCONE_HEAP=1000000000 SCONE_ALLOW_DLOPEN=2  SCONE_ALPINE=1 SCONE_VERSION=1 /usr/local/bin/python helloworld.py
...
Hello World
echo next

$ mkdir -p /example
$ mkdir -p /mnt/authenticated/
$ mkdir -p /mnt/encrypted/
$ cd /example
$ mkdir -p .original

$ scone fspf create fspf.pb
$ scone fspf create authenticated.pb
$ scone fspf create encrypted.pb

# add protection regions
$ scone fspf addr fspf.pb / -e --ephemeral
$ scone fspf addr authenticated.pb /mnt/authenticated -a --kernel /mnt/authenticated
$ scone fspf addr encrypted.pb /mnt/encrypted -e --kernel /mnt/encrypted

# add files

# enclave program should expect the files (directories) found by the client in ./original in /mnt/authenticated
$ scone fspf addf authenticated.pb /mnt/authenticated ./original

# enclave program should expect the files (directories) found by the client in ./original in encrypted form in /mnt/encrypted
# the client will write the encrypted files to ./mnt/encrypted
$ scone fspf addf encrypted.pb /mnt/encrypted ./original ./mnt/encrypted
encrypted_key=`scone fspf encrypt encrypted.pb | awk '{print $11}'`

$ echo "encrypted.pb key: ${encrypted_key}"
$ scone fspf addfspf fspf.pb authenticated.pb
$ scone fspf addfspf fspf.pb encrypted.pb ${encrypted_key}
$ cat > example.c << EOF
#include <stdio.h>

int main() {
    FILE *fp = fopen("/mnt/authenticated/hello", "w");
    fprintf(fp, "hello world\n");
    fclose(fp);

    fp = fopen("/mnt/encrypted/hello", "w");
    fprintf(fp, "hello world\n");
    fclose(fp);
}
EOF

$ scone gcc example.c -o sgxex
$ cat > /etc/sgx-musl.conf << EOF
Q 4
e -1 0 0
s -1 0 0
e -1 1 0
s -1 1 0
e -1 2 0
s -1 2 0
e -1 3 0
s -1 3 0
EOF
$ SCONE_FSPF=fspf.pb ./sgxex
$ cat /mnt/authenticated/hello
$ cat /mnt/encrypted/hello 
$ cat > cat.c << EOF
#include <stdio.h>

int main() {
    char buf[80];
    FILE *fp = fopen("/mnt/authenticated/hello", "r");
    fgets(buf, sizeof(buf), fp);
    fclose(fp);
    printf("read: '%s'\n", buf);

    fp = fopen("/mnt/encrypted/hello", "r");
    fgets(buf, sizeof(buf), fp);
    fclose(fp);
    printf("read: '%s'\n", buf);
}
EOF

$ scone gcc cat.c -o native_cat
$ ./native_cat
$ scone gcc cat.c -o sgxcat
$ SCONE_FSPF=fspf.pb ./sgxcat
