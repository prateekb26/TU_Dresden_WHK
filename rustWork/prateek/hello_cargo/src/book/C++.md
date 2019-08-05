# C++ Program Language Support

SCONE supports native compilation of C++ programs when combined with dynamic linking as well as cross-compilation.  Cross-compilation is required  to support, in particular, statically linked binaries.

This page focuses on the SCONE C++ cross compiler **scone g++** (a.k.a. **scone-g++**). This cross compiler is based on g++ and hence, the command line options are the same as those of g++.

## Image

Ensure that you have the newest SCONE cross compiler image:

```bash,ignore
docker pull sconecuratedimages/crosscompilers
docker run --device=/dev/isgx -it sconecuratedimages/crosscompilers
```

Please drop argument *--device=/dev/isgx* in case you do not have an SGX driver installed.

## Help

If you need some help, just execute in the container:

```bash,ignore
$ scone g++ --help
Usage: x86_64-linux-musl-g++ [options] file...
Options:
...
```

## Example
Let's try to compile a simple program:

```bash,ignore
cat > sqrt.cc << EOF
#include <iostream>
#include <cmath>

using namespace std;

int main() {
    int x = 0;
    while(x < 10) {
        double y = sqrt((double)x);
        cout << "The square root of " << x << " is " << y << endl;
        x++;
    }
    return 0;
}
EOF
```

We compile the program with **scone gcc** or **scone-gcc**:

```bash,ignore
scone g++ sqrt.cc -o sqrt
```

Let's execute the binary and switch on debug outputs:

```bash,ignore
SCONE_VERSION=1 ./sqrt
```

The output will look like:

```
xport SCONE_QUEUES=4
export SCONE_SLOTS=256
export SCONE_SIGPIPE=0
export SCONE_MMAP32BIT=0
export SCONE_SSPINS=100
export SCONE_SSLEEP=4000
export SCONE_KERNEL=0
export SCONE_HEAP=67108864
export SCONE_STACK=81920
export SCONE_CONFIG=/etc/sgx-musl.conf
export SCONE_MODE=sim
export SCONE_SGXBOUNDS=no
export SCONE_VARYS=no
export SCONE_ALLOW_DLOPEN=no
export SCONE_MPROTECT=no
Revision: b1e014e64b4d332a51802580ec3252370ffe44bb (Wed May 30 15:17:05 2018 +0200)
Branch: master
Configure options: --enable-shared --enable-debug --prefix=/mnt/ssd/franz/subtree-scone2/built/cross-compiler/x86_64-linux-musl

Enclave hash: ebf98279a2cae1179366f8b5a0fc007decdc5dd3dec2b92ddbf121c2e2bf22f4
The square root of 0 is 0
The square root of 1 is 1
The square root of 2 is 1.41421
The square root of 3 is 1.73205
The square root of 4 is 2
The square root of 5 is 2.23607
The square root of 6 is 2.44949
The square root of 7 is 2.64575
The square root of 8 is 2.82843
The square root of 9 is 3
```

## Debugging

You can use **scone-gdb** to debug your applications when running inside of an enclave. For some more details
on how to use the debugger, please read how to [debug GO](GO/#debugging) programs.

&copy; [scontain.com](http://www.scontain.com), July 2018. [Questions or Suggestions?](mailto:info@scontain.com)
