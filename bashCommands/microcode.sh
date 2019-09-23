

TMPDIR=$(mktemp -d)
cd $TMPDIR
curl -o ucode.tgz https://downloadmirror.intel.com/28039/eng/microcode-20180807.tgz 
tar -xzf ucode.tgz
sudo apt-get update
sudo apt-get install -y intel-microcode
if [ -f /sys/devices/system/cpu/microcode/reload ] ; then
    if [ -d /lib/firmware ] ; then
        mkdir -p OLD
        cp -rf /lib/firmware/intel-ucode OLD
            sudo cp -rf intel-ucode /lib/firmware
        echo "1" | sudo tee /sys/devices/system/cpu/microcode/reload
    else
        echo "Error: microcode directory does not exist"
    fi
else
    echo "Error: is intel-micrcode really installed?"
fi

dmesg | grep microcode

cat > /tmp/load-intel-ucode.sh << EOF
#!/bin/bash
echo "1" | sudo tee /sys/devices/system/cpu/microcode/reload
EOF
sudo mv /tmp/load-intel-ucode.sh /lib/firmware/load-intel-ucode.sh
chmod a+x /lib/firmware/load-intel-ucode.sh
# the following cmd pops up the editor: add the @reboot... via the editor
crontab -e
@reboot /lib/firmware/load-intel-ucode.sh

docker run --rm sconecuratedimages/apps:check_cpuid