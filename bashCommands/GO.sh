

docker pull sconecuratedimages/crosscompilers
docker run --device=/dev/isgx -it -p 8080:8080 sconecuratedimages/crosscompilers

cat > web-srv.go << EOF
package main

import (
    "os"
    "fmt"
    "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hi there, I love %s!\n", r.URL.Path[1:])
    if r.URL.Path[1:] == "EXIT" {
        os.Exit(0)
    }
}

func main() {
    http.HandleFunc("/", handler)
    http.ListenAndServe(":8080", nil)
}
EOF

SCONE_HEAP=1G scone-gccgo web-srv.go -O3 -o web-srv-go -g

SCONE_VERSION=1 ./web-srv-go &

curl localhost:8080/SCONE

curl localhost:8080/EXIT

docker run --cap-add SYS_PTRACE -it -p 8080:8080 -v "$PWD"/EXAMPLE:/usr/src/myapp -w /usr/src/myapp  sconecuratedimages/crosscompilers

scone-gdb ./web-srv-go

run

^C
Thread 1 "web-srv-go" received signal SIGINT, Interrupt.
0x00007f17870f69dd in pthread_join (threadid=139739022911232, thread_return=0x7ffe1c807928) at pthread_join.c:90
90	pthread_join.c: No such file or directory.
(gdb) where
#0  0x00007f17870f69dd in pthread_join (threadid=139739022911232, thread_return=0x7ffe1c807928) at pthread_join.c:90
#1  0x0000002000004053 in main (argc=1, argv=0x7ffe1c807c18, envp=0x7ffe1c807c28) at ./tools/starter-exec.c:764
(gdb) cont
Continuing.

scone-gdb ./web-srv-go
...
[SCONE] Initializing...
(gdb) handle SIGILL nostop pass
Signal        Stop      Print   Pass to program Description
SIGILL        No        Yes     Yes             Illegal instruction
(gdb) break main.handler
Function "main.handler" not defined.
Make breakpoint pending on future shared library load? (y or [n]) y
Breakpoint 1 (main.handler) pending.
(gdb) run
Starting program: /usr/src/myapp/web-srv-go 
warning: Error disabling address space randomization: Operation not permitted
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
[SCONE] Enclave base: 1000000000
[SCONE] Loaded debug symbols
[New Thread 0x7fb6cad32700 (LWP 243)]
[New Thread 0x7fb6ca531700 (LWP 244)]
[New Thread 0x7fb6c9d30700 (LWP 245)]
[New Thread 0x7fb6c952f700 (LWP 246)]
[New Thread 0x7fb6cb50e700 (LWP 247)]
[New Thread 0x7fb6cb506700 (LWP 248)]
[New Thread 0x7fb6cb4fe700 (LWP 249)]
[New Thread 0x7fb6cb4f6700 (LWP 250)]

Thread 6 "web-srv-go" received signal SIGILL, Illegal instruction.

Thread 6 "web-srv-go" received signal SIGILL, Illegal instruction.

Thread 6 "web-srv-go" received signal SIGILL, Illegal instruction.

Thread 6 "web-srv-go" received signal SIGILL, Illegal instruction.

Thread 6 "web-srv-go" received signal SIGILL, Illegal instruction.

Thread 6 "web-srv-go" received signal SIGILL, Illegal instruction.

[Switching to Thread 0x7fb6cb506700 (LWP 248)]

Thread 7 "web-srv-go" hit Breakpoint 1, main.handler (w=..., r=0x100909e300) at web-srv.go:8
8       func handler(w http.ResponseWriter, r *http.Request) {
(gdb) n
9           fmt.Fprintf(w, "Hi there, I love %s!", r.URL.Path[1:])
(gdb) n
8       func handler(w http.ResponseWriter, r *http.Request) {
(gdb) c
Continuing.