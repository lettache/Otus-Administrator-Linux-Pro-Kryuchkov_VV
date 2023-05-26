          #install zfs repo
          sudo yum install -y http://download.zfsonlinux.org/epel/zfs-release.el7_8.noarch.rpm
          #import gpg key 
          sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-zfsonlinux
          #install DKMS style packages for correct work ZFS
          sudo yum install -y epel-release kernel-devel zfs
          #change ZFS repo
          sudo yum-config-manager --disable zfs
          sudo yum-config-manager --enable zfs-kmod
          sudo yum install -y zfs
          #Add kernel module zfs
          sudo modprobe zfs
          #install wget
          sudo yum install -y wget