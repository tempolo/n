  
#/bin/bash
mkdir -p /.ssh
cd /.ssh


cat > ed25519.pub <<'eof'
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFkfVDKMlu99XttAcT0BdQg3rsbYUii09bkLzROUIhDO ed25519
eof

cat > hostkey <<'eoooof'
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABFwAAAAdzc2gtcn
NhAAAAAwEAAQAAAQEAxuDBRUII+/MmtjszSKEW6B2m2wO/DXQ0oClYne4UsAXZIx6BlKrK
ge/wwv9dYTJuy01LQyHfJvqEFPLfPhd7+U61LB5aqUpmi3H6hW0iUC2W7D7gCBFtJbrNVP
qFX4oNz4o+ue0OpSTEfzdRRXZRUjZwpcQviE8riuQatHhnIlJ706KGPW2rpW/uXpr8lSMC
jwVcSiE0cnBMeiNXv+Hs+50IevC7jUn0Wfy0nka20JW2/Hu4nkdrItvjls04qa7hLcDgZp
JwfiLlF/zJnvwi0AH+wbH92xF4zuCaIOGXnKrALpDvK3uZtPVBG7t3DweFaV5LNM9YsiIG
ODgIwquKIQAAA8AUQ1nGFENZxgAAAAdzc2gtcnNhAAABAQDG4MFFQgj78ya2OzNIoRboHa
bbA78NdDSgKVid7hSwBdkjHoGUqsqB7/DC/11hMm7LTUtDId8m+oQU8t8+F3v5TrUsHlqp
SmaLcfqFbSJQLZbsPuAIEW0lus1U+oVfig3Pij657Q6lJMR/N1FFdlFSNnClxC+ITyuK5B
q0eGciUnvTooY9baulb+5emvyVIwKPBVxKITRycEx6I1e/4ez7nQh68LuNSfRZ/LSeRrbQ
lbb8e7ieR2si2+OWzTipruEtwOBmknB+IuUX/Mme/CLQAf7Bsf3bEXjO4Jog4ZecqsAukO
8re5m09UEbu3cPB4VpXks0z1iyIgY4OAjCq4ohAAAAAwEAAQAAAQEAtU38pAj5a8dViVga
/qFs4pr1nECkEb3YpBJNaVy8m2QZefy7oS66gw6c7QgktxFlFA4ZCNB+QWistPRdNJvwN2
3bmKbre94J8iIsgyrk1zdYmXMQhgps+LJ9snTY1ipjQMsFODa23TLRuDBT9QFSTaK3u0dJ
Ffkm9u3Qsqn5S71PFrDG52FzjerSt7JY/Ok5gXjNIFZVp2jgCKgMnmzH18mPUdiaUOdnJy
CP5cXt8xwcVpENyf0Aue8lj2Z0JDMX2B75qup6+EcsPBF2ygVvjMSw/Q7gZVDCwlSOw/0v
Qs1M/TLUbnIOcyKIyn9cSRq29Pmfc16yKE3wue+NdC49qQAAAIEAxgvKpKvCAWiM1vBRDb
3HitZ+WPL/fLgAH31Uu3FQFqS6MlugZuHYvPvUX/sU1UId1eF44CTJb2D6yXDxB855rI8H
5vn5EAyP1gppS+00rJAWpr2Q4c9OOtVj3Ao+ra8HeFNBM0LSpEI9pN1OQKmXOCTbmAbMNZ
iMeehDdkmSnhgAAACBAOTg8rn8Kk/stkPx+MBpkwJHvXGpHpcGUvPcT95z+gTA4JDXa8l0
cvRPWwOCRXJcFQFVPlpgLyVju7VhZD9LPaig1CfiPiAMC9AvpLd72dSjV08fRNdX4YVSJe
Mpu7tGimjuF+p2TrBztEMw8Hg9XSdp7syZqYDBv45dV+QZwdSrAAAAgQDecbtVlRBW4ejA
xYwl8Zr1t7rkdmeH3L4mEy/BJpIXBF+GcOYiCZzjrrKyuBNQ8fP7VqUnNm4g2bNbb8t1Qc
nsvQ6C+6bonO3VfLYEDQ7G7ZFSMUhJS7Gx2Q+vr/6fp7KzvdRsZzLNnxHb/FNizqc9L6MZ
U3z0pJYEv51LVerkYwAAAAd4QHgubGFuAQI=
-----END OPENSSH PRIVATE KEY-----
eoooof

cat > sshd.conf <<'eof'
Port 2222
HostKey /.ssh/hostkey
AuthorizedKeysFile /.ssh/ed25519.pub
ClientAliveInterval 30
ClientAliveCountMax 3
eof
$(which sshd) -f sshd.conf

cat > ./cron.sh <<"eof"
#!/bin/bash
while [ true ]
do
whoami
curl -sL https://$YOUR_APP_NAME.herokuapp.com/test
sleep 1200
done
eof
bash cron.sh &

rm -rf /init.sh

curl -OL https://github.com/erebe/wstunnel/releases/download/v3.0/wstunnel-x64-linux.zip
unzip wstunnel-x64-linux.zip
chmod +x wstunnel
./wstunnel --server ws://0.0.0.0:$PORT -r 127.0.0.1:2222 -q 
