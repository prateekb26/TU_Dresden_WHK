
docker pull sconecuratedimages/apps:node-8.9.4-alpine
docker run -it --device=/dev/isgx sconecuratedimages/apps:node-8.9.4-alpine sh
mkdir myapp
cd myapp
cat > package.json << EOF
{
  "name": "myapp",
  "version": "1.0.0",
  "description": "",
  "main": "app.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC"
}
EOF
npm install express --save
cat > app.js << EOF
var express = require('express');
var app = express();
app.get('/', function (req, res) {
  res.send('Hello World!');
});
app.listen(3000, function () {
  console.log('Example app listening on port 3000!');
});
EOF
SCONE_VERSION=1 node app.js
export SCONE_QUEUES=4
export SCONE_SLOTS=256
export SCONE_SIGPIPE=0
export SCONE_MMAP32BIT=0
export SCONE_SSPINS=100
export SCONE_SSLEEP=4000
export SCONE_KERNEL=0
export SCONE_HEAP=4294967296
export SCONE_STACK=4194304
export SCONE_CONFIG=/etc/sgx-musl.conf
export SCONE_MODE=hw
export SCONE_SGXBOUNDS=no
export SCONE_VARYS=no
export SCONE_ALLOW_DLOPEN=yes (unprotected)
export SCONE_MPROTECT=no
Revision: e349ed6e4821f0cbfe895413c616409848216173 (Wed Feb 28 19:28:04 2018 +0100)
Branch: master
Configure options: --enable-shared --enable-debug --prefix=/builds/scone/subtree-scone/built/cross-compiler/x86_64-linux-musl

Enclave hash: 28cf4f0953ba54af02b9d042fa2ec88a832d749ae4e5395cabd50369e72a5dcb
Example app listening on port 3000!
docker exec -it $(docker ps -l -q) sh
apk add --no-cache curl
curl localhost:3000/
Hello World!/ #
FROM sconecuratedimages/apps:node-8.9.4-alpine
ENV SCONE_HEAP=1G
EXPOSE 3000
RUN apk add --no-cache nodejs-npm \
  && mkdir myapp \
  && cd myapp \
  && echo "{" > package.json \
  && echo '"name": "myapp",' >> package.json \
  && echo '"version": "1.0.0",' >> package.json \
  && echo '"description": "",' >> package.json \
  && echo '"main": "app.js",' >> package.json \
  && echo '"scripts":' >> package.json { \
  && echo '  "test": "echo \"Error: no test specified\" && exit 1"' >> package.json \
  && echo '},' >> package.json \
  && echo '"author": "",' >> package.json \
  && echo '"license": "ISC"' >> package.json \
  && echo '}' >> package.json \
  && npm install express --save \
  && echo "var express = require('express');" > app.js \
  && echo "var app = express();" >> app.js \
  && echo "app.get('/', function (req, res) {" >> app.js \
  && echo "  res.send('Hello World!');" >> app.js \
  && echo "});" >> app.js \
  && echo "app.listen(3000, function () {" >> app.js \
  && echo "  console.log('Example app listening on port 3000!');" >> app.js \
  && echo "});" >> app.js 

CMD SCONE_VERSION=1 node /myapp/app.js
docker build -t myapp .
docker run -d -p 3000:3000 myapp
curl localhost:3000
Hello World!