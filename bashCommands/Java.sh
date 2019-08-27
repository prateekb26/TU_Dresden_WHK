
echo next
docker pull sconecuratedimages/apps:8-jdk-alpine
echo next
docker run --privileged --device=/dev/isgx -it sconecuratedimages/apps:8-jdk-alpine
echo next
cat > HelloWorld.java << EOF
public class HelloWorld {

    public static void main(String[] args) {
        System.out.println("Hello World");
    }

}
EOF
echo next
javac HelloWorld.java
echo next
java HelloWorld
echo next
SCONE_VERSION=1 SCONE_LOG=7 java HelloWorld
echo next
SCONE_LOG=7 SCONE_HEAP=12G java HelloWorld