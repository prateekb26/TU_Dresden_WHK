
mkdir -p VAULT-DEMO
cd VAULT-DEMO
cat > docker-compose.yml <<EOF
version: '3.2'
services:
    vault:
        image: sconecuratedimages/apps:scone-vault-latest
        command: sh -c "cd build_dir && ./start_vault.sh"
        environment:
         - VAULT_DEV_ROOT_TOKEN_ID=RootToken
        volumes:
         - ./:/build_dir
        cap_add:
         - IPC_LOCK
    scone-vault-nginx:
        image: sconecuratedimages/apps:nginx-1.13.8-alpine
        environment:
         - URL="http://vault:8200"
         - INDEX=nginx
         - VAULT_ADDR="http://vault:8200"
         - TOKEN=RootToken
        command: sh -c "cd build_dir && ./install-deps.sh && ./bench.sh"
        volumes:
         - ./:/build_dir
        depends_on:
         - vault
EOF
docker-compose up
docker-compose down
docker-compose run scone-vault-nginx sh
 cd /build_dir/
 ./install-deps.sh
./bench.sh