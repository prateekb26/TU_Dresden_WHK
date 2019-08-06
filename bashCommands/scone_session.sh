
scone session create --tenant myself --name www \
--approve ap.com/myself --fingerprint  43:51:43:a1:b5:fc:8b:b7:0a:3a:a9:b1:0f:66:73:a8 \
--approve ap2.com/myboss --fingerprint  55:45:a1:b5:fc:8b:b7:0a:3a:a9:b1:0f:66:73:a8 \
scone session key --name KEYNAME [--replace] —-type TYPE [--access  [session]:MRENCLAVE]]
scone session share --key image/NAME/fspf-key --pubkey signer  --gentoken --duration 366
scone session share --gentoken --all
scone session share --stack FILE  --gentoken
scone session join --token TOKEN
scone session import --token TOKEN [--replace]
scone session checkpoint