
echo next
docker pull sconecuratedimages/crosscompilers
docker run --device=/dev/isgx -it sconecuratedimages/crosscompilers
echo next
scone gcc --help
echo next
cat > fib.c << EOF
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char** argv) {
   int n=0, first = 0, second = 1, next = 0, c;

   if (argc > 1)
        n=atoi(argv[1]);
   printf("fib(%d)= 1",n);
   for ( c = 1 ; c < n ; c++ ) {
        next = first + second;
        first = second;
        second = next;
        printf(", %d",next);
   }
   printf("\n");
}
EOF
echo next
scone gcc fib.c -o fib
echo next
SCONE_VERSION=1 ./fib 23