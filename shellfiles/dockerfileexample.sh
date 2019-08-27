
echo next
cat > Dockerfile << EOF
FROM sconecuratedimages/crosscompilers

RUN echo  "#include <stdio.h>" > helloworld.c \
   && echo "int main() {" >> helloworld.c \
   && echo "printf(\"Hello World!\n\"); }" >> helloworld.c

RUN gcc -o helloworld helloworld.c

CMD bash -c "SCONE_VERSION=1 /helloworld"
EOF
echo next
echo next
