

docker pull sconecuratedimages/crosscompilers
docker run --device=/dev/isgx -it sconecuratedimages/crosscompilers

cat > mysecret.c << EOF
#include <stdio.h>
#include <unistd.h>

const char *code_is_not_encrypted="THIS_IS_NOT_SECRET";

int main() {
    char secret[7];
    secret[0] ='M';
    secret[1] ='Y';
    secret[2] ='B';
    secret[3] ='I';
    secret[4] ='G';
    secret[5] ='S';
    secret[6] =0;
    printf("'%s' SECRET at %lx\n", secret, secret);
    printf("Kill with Ctrl-C.\n");
    for(;;)
        sleep(1); // loop forever
}
EOF

gcc -g -o mysecret mysecret.c

SCONE_VERSION=1 SCONE_MODE=SIM SCONE_HEAP=128K SCONE_STACK=1K ./mysecret

SPID=$(ps -a | grep -v grep | grep mysecret | awk  '{print $1}')

cat > dumpstack.py << EOF
import sys, os, string, re

pid = sys.argv[1]
maps_file = open("/proc/%s/maps" % pid, 'r')
mem_file = open("/proc/%s/mem" % pid, 'r')
r=0

for line in maps_file.readlines():  # for each mapped region
    w=line.rsplit(None, 1)[-1] # last word
    if w != "/dev/isgx" and  w != "[vvar]" and w != "[vdso]" and w != "[vsyscall]":
        m = re.match(r'([0-9A-Fa-f]+)-([0-9A-Fa-f]+) ([-r])', line)
        r += 1
        p = 0
        if m.group(3) == 'r':  # if this is a readable region
            start = int(m.group(1), 16)
            end = int(m.group(2), 16)
            while start < end:
                try:
                    mem_file.seek(start)  # seek to region start
                    chunk = mem_file.read(4096)  # read region contents
                    sys.stdout.write(chunk)
                    p += 1
                    if p > 1000:
                        sys.stderr.write("region = %02d, index=%x    \r" % (r,start))
                        p = 0
                    start += 4096
                except:
                    pass
sys.stderr.write("\n")
EOF

sudo python dumpstack.py $SPID | strings -n 5 | grep MYBI

SCONE_VERSION=1 SCONE_MODE=HW SCONE_HEAP=128K SCONE_STACK=1K ./mysecret

SPID=$(ps -a | grep -v grep | grep mysecret | awk  '{print $1}')

sudo python dumpstack.py $SPID | strings -n 5 | grep MYBI

sudo python dumpstack.py $SPID | strings -n 5 | grep THIS_IS_NOT_SECRET