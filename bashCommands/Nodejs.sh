

docker pull sconecuratedimages/apps:node-8.9.4-alpine

docker run -it --device=/dev/isgx sconecuratedimages/apps:node-8.9.4-alpine sh

apk add --no-cache nodejs-npm

export SCONE_HEAP=1G

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

docker exec -it $(docker ps -l -q) sh

apk add --no-cache curl
curl localhost:3000/

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