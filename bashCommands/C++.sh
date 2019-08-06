
docker pull sconecuratedimages/crosscompilers
docker run -it sconecuratedimages/crosscompilers scone g++ --help
docker run -it sconecuratedimages/crosscompilers cat > sqrt.cc << EOF
docker run -it sconecuratedimages/crosscompilers #include <iostream>
docker run -it sconecuratedimages/crosscompilers #include <cmath>

docker run -it sconecuratedimages/crosscompilers using namespace std;

docker run -it sconecuratedimages/crosscompilers int main() {
docker run -it sconecuratedimages/crosscompilers    int x = 0;
docker run -it sconecuratedimages/crosscompilers    while(x < 10) {
docker run -it sconecuratedimages/crosscompilers        double y = sqrt((double)x);
docker run -it sconecuratedimages/crosscompilers        cout << "The square root of " << x << " is " << y << endl;
docker run -it sconecuratedimages/crosscompilers        x++;
docker run -it sconecuratedimages/crosscompilers    }
docker run -it sconecuratedimages/crosscompilers    return 0;
docker run -it sconecuratedimages/crosscompilers }
docker run -it sconecuratedimages/crosscompilers EOF
docker run -it sconecuratedimages/crosscompilers scone g++ sqrt.cc -o sqrt
docker run -it sconecuratedimages/crosscompilers SCONE_VERSION=1 ./sqrt
