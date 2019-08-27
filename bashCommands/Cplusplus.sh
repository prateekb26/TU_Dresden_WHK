
echo next
docker pull sconecuratedimages/crosscompilers
docker run --device=/dev/isgx -it sconecuratedimages/crosscompilers
echo next
scone g++ --help
echo next
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
echo next
scone g++ sqrt.cc -o sqrt
echo next
SCONE_VERSION=1 ./sqrt