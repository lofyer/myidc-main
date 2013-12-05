#!/bin/bash
if [[ $1 != [0-2] ]]
then
	echo -e 'Usage:\n\tstart.sh {0|1|2}'
	exit
fi
KVM_CMD="qemu-system-x86_64 -no-user-config -nodefaults"

#################################
#	 STANDARD OPTIONS	#
#################################
#FLAG_INNER_NET="-net nic -net user"
FLAG_INNER_NET="-net tap,ifname=tap$1,script=no,downscript=no -net nic,model=virtio,macaddr=94:de:80:7a:30:0$((2*$1))"
FLAG_CPU_TYPE="-cpu host"
FLAG_CPU_FEATURE="-smp 4,sockets=1,cores=4"
FLAG_MM="-m 1024M"
#FLAG_CD="-cdrom allinone.iso"
FLAG_KB="-k en-us"
FLAG_BOOTM="-boot menu=on"

#################################
#	FILESYSTEM OPTIONS	#
#################################

#################################
#	DISPLAY OPTIONS		#
#################################
FLAG_SPICE="-spice port=500$1,ipv4,disable-ticketing"
FLAG_VGA="-vga qxl"
FLAG_QXL="-global qxl-vga.vram_size=67108864"

#################################
#	NETWORK OPTIONS		#
#################################

#################################
#	 CHARDEV OPTIONS	#
#################################
FLAG_SPICE_USB_BASE="-device ich9-usb-ehci1,id=usb,bus=pci.0,addr=0x5.0x7 -device ich9-usb-uhci3,masterbus=usb.0,firstport=4,bus=pci.0,addr=0x5.0x2 -device ich9-usb-uhci2,masterbus=usb.0,firstport=2,bus=pci.0,addr=0x5.0x1 -device ich9-usb-uhci1,masterbus=usb.0,firstport=0,bus=pci.0,multifunction=on,addr=0x5"
FLAG_SPICE_USB_EXT="-chardev spicevmc,id=charredir0,name=usbredir -device usb-redir,chardev=charredir0,id=redir0 -chardev spicevmc,id=charredir1,name=usbredir -device usb-redir,chardev=charredir1,id=redir1 -chardev spicevmc,id=charredir2,name=usbredir -device usb-redir,chardev=charredir2,id=redir2 -chardev spicevmc,id=charredir3,name=usbredir -device usb-redir,chardev=charredir3,id=redir3"
FLAG_SOUND="-device intel-hda,id=sound0,bus=pci.0,addr=0x4 -device hda-duplex,id=sound0-codec0,bus=sound0.0,cad=0"
#################################
#   	 KERNEL OPTIONS		#
#################################
#FLAG_KERNEL="-kernel bzImage"
#FLAG_APPEND="-append root=/dev/sda rw"

#################################
#	  DEBUG OPTIONS		#
#################################
FLAG_KVM="-enable-kvm"
FLAG_MONITOR="-monitor stdio"
#FLAG_MONITOR="-chardev socket,id=charmonitor,path=mywin7.monitor,server,nowait -mon chardev=charmonitor,id=monitor,mode=control"
FLAG_VIRTIO_PCI="-device virtio-serial-pci,id=virtio-serial0,bus=pci.0,addr=0x6"
#FLAG_VIRTIO_VDSM="-chardev socket,id=charchannel0,path=mywin7.com.redhat.rhevm.vdsm,server,nowait -device virtserialport,bus=virtio-serial0.0,nr=1,chardev=charchannel0,id=channel0,name=com.redhat.rhevm.vdsm"
#FLAG_VIRTIO_GUESTAGENT="-chardev socket,id=charchannel1,path=mywin7.org.qemu.guest_agent.0,server,nowait -device virtserialport,bus=virtio-serial0.0,nr=2,chardev=charchannel1,id=channel1,name=org.qemu.guest_agent.0"
FLAG_VIRTIO_VDAGENT="-chardev spicevmc,id=charchannel2,name=vdagent -device virtserialport,bus=virtio-serial0.0,nr=3,chardev=charchannel2,id=channel2,name=com.redhat.spice.0"
FLAG_VIRTIO_DRV="-drive file=centos.iso,if=none,id=drive-ide0-1-0,readonly=on,format=raw,serial= -device ide-cd,bus=ide.1,unit=0,drive=drive-ide0-1-0,id=ide0-1-0 -drive file=cluster-1-$1.raw,if=none,id=drive-virtio-disk0,format=raw,serial=8ca429f5-285d-41b6-8ce9-ec74a519e3b9,cache=none,werror=stop,rerror=stop,aio=threads -device virtio-blk-pci,scsi=off,bus=pci.0,addr=0x7,drive=drive-virtio-disk0,id=virtio-disk0,bootindex=1"
#FLAG_VIRTIO_NET="-netdev tap,fd=27,id=hostnet0,vhost=on,vhostfd=28 -device virtio-net-pci,netdev=hostnet0,id=net0,mac=00:1a:4a:a8:01:54,bus=pci.0,addr=0x3"
FLAG_BALLOON="-device virtio-balloon-pci,id=balloon0,bus=pci.0,addr=0x8"
#FLAG_USB="-usbdevice tablet -usbdevice host:0930:6545"


$KVM_CMD $IMG \
$FLAG_BOOTM \
$FLAG_MM $FLAG_CD \
$FLAG_CPU_TYPE \
$FLAG_CPU_FEATURE \
$FLAG_KERNEL $FLAG_APPEND \
$FLAG_INNER_NET \
$FLAG_KVM \
$FLAG_MONITOR \
$FLAG_VGA \
$FLAG_QXL \
$FLAG_SPICE \
$FLAG_SPICE_USB_BASE \
$FLAG_SPICE_USB_EXT \
$FLAG_SOUND \
$FLAG_VIRTIO_DRV \
$FLAG_VIRTIO_PCI \
$FLAG_VIRTIO_VDSM \
$FLAG_VIRTIO_VDAGENT \
$FLAG_VIRTIO_GUESTAGENT \
$FLAG_VIRTIO_NET \
$FLAG_BALLOON \
$FLAG_USB
