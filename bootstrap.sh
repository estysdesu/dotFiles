#!/usr/bin/env sh

USERNAME='estysdesu'

##### ##### ##### ##### ##### ##### ##### #####
##### SETUP                               #####
##### ##### ##### ##### ##### ##### ##### #####
dnf check-update -yq
dnf update -yq
dnf in -yq dnf-plugins-core

# Remove live CD deps
dnf rm -yq anaconda \
	anaconda-live \
	anaconda-install-env-deps

##### ##### ##### ##### ##### ##### ##### #####
##### X APPS                              #####
##### ##### ##### ##### ##### ##### ##### #####
# Alacritty
dnf copr -yq enable pschyska/alacritty

# Brave (Nightly)
dnf config-manager -yq --add-repo https://brave-browser-rpm-nightly.s3.brave.com/x86_64/
rpm --import https://brave-browser-rpm-nightly.s3.brave.com/brave-core-nightly.asc --quiet 

# VS Code (Insiders)
rpm --import https://packages.microsoft.com/keys/microsoft.asc --quiet 
cat > /etc/yum.repos.d/vscode.repo <<EOF 
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

# Telegram
dnf in -yq https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

dnf check-update -yq
dnf in -yq alacritty \
	brave-browser-nightly \
	code-insiders \
	telegram-desktop
dnf rm -yq firefox

##### ##### ##### ##### ##### ##### ##### #####
##### DEV DEPS                            #####
##### ##### ##### ##### ##### ##### ##### #####
dnf in -yq python3 \
	golang 
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s - -yq --no-modify-path --default-toolchain stable 

##### ##### ##### ##### ##### ##### ##### #####
##### VIRTUALIZATION                      #####
##### ##### ##### ##### ##### ##### ##### #####
dnf in -yq libvirt \
	qemu-kvm \
	virt-manager
systemctl start libvirtd
systemctl enable libvirtd
usermod -aG libvirt $USERNAME
