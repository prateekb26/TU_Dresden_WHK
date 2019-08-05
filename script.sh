#!/bin/bash
# declare STRING variable
STRING="Hello World"
#print variable on a screen
echo $STRING



docker pull sconecuratedimages/crosscompilers
docker run --device=/dev/isgx -it sconecuratedimages/crosscompilers
scone g++ --help
#Usage: x86_64-linux-musl-g++ [options] file...
#Options:
#...
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
scone g++ sqrt.cc -o sqrt
SCONE_VERSION=1 ./sqrt
