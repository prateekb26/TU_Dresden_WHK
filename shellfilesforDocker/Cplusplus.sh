


scone g++ --help

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
