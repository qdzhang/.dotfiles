#!/bin/sh

# Author:       Ahmed Elhori <dev@elhori.com>
# License:      GNU GPLv3
# Description:  Arch install script
# Link:         https://github.com/ahmedelhori/install-arch

# This script is forked from https://github.com/ahmedelhori/install-arch

# ENV
set -e
NAME="$(basename "$0")"
package_list='base linux linux-firmware sudo vim networkmanager linux-headers'
keyboard_layout=
want_clean_drive=
want_encryption=
drive_name=
timezone_region=
timezone_city=
locale=en_US.UTF-8
locale_full=$(
	cat <<-EOF
		en_US.UTF-8 UTF-8
		zh_CN.UTF-8 UTF-8
		zh_HK.UTF-8 UTF-8
		zh_TW.UTF-8 UTF-8
	EOF
)
hostname=
mirrorlist_url="https://archlinux.org/mirrorlist/?country=CN&protocol=https&ip_version=4"
priority_mirrorlist='Server = https://opentuna.cn/archlinux/$repo/os/$arch'

final_commands() {
	# Place your final commands here.
	# For Example: KDE environment
	#
	#pacman -S xf86-video-intel xorg xorg-xinit plasma lightdm lightdm-gtk-greeter
	#systemctl enable lightdm
	#
	# Don't leave the function empty!
	config_archlinuxcn_mirror
	pacman -Sy && pacman -S archlinuxcn-keyring

	pacman -S base-devel git
	systemctl enable NetworkManager
	set_ntp_server
	echo 'Final commands..'
}

print_error() {
	message="$1"
	echo "${NAME} - Error: ${message}" >&2
}

ask_yes_no() {
	answer="$1"
	question="$2"
	while ! printf '%s' "$answer" | grep -q '^\([Yy]\(es\)\?\|[Nn]\(o\)\?\)$'; do
		printf '%s' "${question} [Y]es/[N]o: "
		read -r answer
	done

	if printf '%s' "$answer" | grep -q '^[Nn]\(o\)\?$'; then
		return 1
	fi
}

check_root() {
	if [ "$(id -u)" -ne '0' ]; then
		print_error 'This script needs root privileges.'
		exit 1
	fi
}

set_keyboard_layout() {
	if [ -z "$keyboard_layout" ]; then
		printf 'Enter the keyboard layout name, or press enter for the default layout (us): '
		read -r keyboard_layout

		if [ -z "$keyboard_layout" ]; then
			keyboard_layout='us'
		fi
	fi

	if ls /usr/share/kbd/keymaps/**/*"$keyboard_layout"*.map.gz >/dev/null 2>&1; then
		loadkeys "$keyboard_layout"
	else
		print_error "Keyboard layout not found"
		keyboard_layout=
		set_keyboard_layout
	fi
}

verify_boot_mode() {
	if [ -d /sys/firmware/efi/efivars ]; then
		boot_mode='uefi'
	else
		boot_mode='bios'
	fi
}

set_ntp_server() {
	if [ -f /etc/systemd/timesyncd.conf ]; then
		mv /etc/systemd/timesyncd.conf /etc/systemd/timesyncd.conf.backup
	fi
	cat <<-EOF >/etc/systemd/timesyncd.conf
		[Time]
		NTP=ntp1.aliyun.com
		FallbackNTP=ntp3.aliyun.com ntp2.aliyun.com 0.arch.pool.ntp.org 1.arch.pool.ntp.org 2.arch.pool.ntp.org 3.arch.pool.ntp.org
		RootDistanceMaxSec=5
		PollIntervalMinSec=32
		PollIntervalMaxSec=2048
	EOF
	systemctl enable systemd-timesyncd.service --now
}

update_system_clock() {
	timedatectl set-ntp true >/dev/null 2>&1
}

get_drive_name() {
	while [ -z "$drive_name" ]; do
		lsblk
		printf 'Enter the name of the desired drive to be affected (e.g., sda): '
		read -r drive_name
	done

	if ! [ -b /dev/"$drive_name" ]; then
		print_error "Drive \"${drive_name}\" not found."
		drive_name=
		get_drive_name
	fi
}

get_partition_path() {
	boot_path="$(blkid | grep "/dev/${drive_name}.*1" | sed -n 's/^\(\/dev\/'"$drive_name"'.*1\):\s\+.*$/\1/p')"
	swap_path="$(blkid | grep "/dev/${drive_name}.*2" | sed -n 's/^\(\/dev\/'"$drive_name"'.*2\):\s\+.*$/\1/p')"
	root_path="$(blkid | grep "/dev/${drive_name}.*3" | sed -n 's/^\(\/dev\/'"$drive_name"'.*3\):\s\+.*$/\1/p')"
}

get_partition_uuid() {
	root_uuid="$(blkid | grep "$root_path" | sed -n 's/^.*\s\+UUID="\(\S*\)".*$/\1/p')"
	swap_uuid="$(blkid | grep "$swap_path" | sed -n 's/^.*\s\+UUID="\(\S*\)".*$/\1/p')"
}

clean_drive() {
	set +e
	dd if=/dev/urandom bs=4096 status=progress >/dev/"$drive_name"
	set -e
}

encrypt_drive() {
	set +e
	cryptsetup -y -v -q luksFormat "$root_path"
	if [ "$?" -eq 0 ]; then
		cryptsetup open "$root_path" croot
	else
		encrypt_drive
	fi
	set -e
}

partion_disk() {
	get_drive_name

	if ask_yes_no "$want_clean_drive" 'Do you want to clean the drive? This may take a long time.'; then
		want_clean_drive='yes'
		clean_drive
	else
		want_clean_drive='no'
	fi

	if [ "$boot_mode" = 'uefi' ]; then
		sfdisk -W always /dev/"$drive_name" <<-EOF
			label: gpt
			size=512MiB, type=uefi, bootable
			size=4GiB, type=swap
			type=linux
		EOF
	else
		sfdisk -W always /dev/"$drive_name" <<-EOF
			label: dos
			size=512MiB, type=linux, bootable
			size=4GiB, type=swap
			type=linux
		EOF
	fi

	get_partition_path

	if ask_yes_no "$want_encryption" 'Do you want encryption?'; then
		want_encryption='yes'
		encrypt_drive
	else
		want_encryption='no'
	fi
}

format_partition() {
	if ask_yes_no "$want_encryption"; then
		mkfs.ext4 /dev/mapper/croot
		mkfs.ext2 -L cswap "$swap_path" 1M
	else
		mkfs.ext4 "$root_path"
		mkswap "$swap_path"
	fi

	if [ "$boot_mode" = 'uefi' ]; then
		mkfs.fat -F32 "$boot_path"
	else
		mkfs.ext4 "$boot_path"
	fi
}

mount_file_system() {
	if ask_yes_no "$want_encryption"; then
		mount /dev/mapper/croot /mnt
	else
		mount "$root_path" /mnt
		swapon "$swap_path"
	fi
	mkdir /mnt/boot
	mount "$boot_path" /mnt/boot
}

change_pacman_mirrorlist() {
	if [ -f /etc/pacman.d/mirrorlist ]; then
		mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.old
	fi
	curl -sL "$mirrorlist_url" -o /etc/pacman.d/mirrorlist
	original_mirrorlist=/etc/pacman.d/mirrorlist
	sed -i "s/#Server/Server/g" $original_mirrorlist
	sed -i "0,/^Server.*/!b;//i $priority_mirrorlist" $original_mirrorlist
}

config_pacman() {
	pacman_config_file=/etc/pacman.conf

	# Open some useful options
	sed -i "s/#ParallelDownloads/ParallelDownloads/" $pacman_config_file
	sed -i "s/#Color/Color/" $pacman_config_file
	sed -i "s/#CheckSpace/CheckSpace/" $pacman_config_file
	sed -i "s/#VerbosePkgLists/VerbosePkgLists/" $pacman_config_file
}

config_archlinuxcn_mirror() {
	# Add archlinuxcn unofficial repository to pacman.conf
	archlinuxcn_mirror=$(
		cat <<-EOF

			[archlinuxcn]
			Server = https://opentuna.cn/archlinuxcn/\$arch
		EOF
	)
	echo "$archlinuxcn_mirror" >>/etc/pacman.conf
}

install_essential_packages() {
	pacstrap /mnt $package_list
}

generate_fstab() {
	genfstab -U /mnt >>/mnt/etc/fstab
	if ask_yes_no "$want_encryption"; then
		echo '/dev/mapper/swap        none            swap            defaults   0   0' >>/mnt/etc/fstab
	fi
}

copy_script_to_chroot() {
	cp "$0" /mnt/root/script.sh
	cat <<-EOF >/mnt/root/env.sh
		export keyboard_layout=${keyboard_layout}
		export boot_mode=${boot_mode}
		export drive_name=${drive_name}
		export timezone_region=${timezone_region}
		export timezone_city=${timezone_city}
		export locale=${locale}
		export hostname=${hostname}
		export want_encryption=${want_encryption}
	EOF
	chmod 700 /mnt/root/script.sh
}

run_arch_chroot() {
	arch-chroot /mnt /bin/sh -c '/root/script.sh 'part2''
}

finish_and_reboot() {
	umount -R /mnt
	echo 'Rebooting in 5Sec'
	sleep 5
	reboot
}

source_env() {
	. /root/env.sh
}

set_time_zone() {
	while [ -z "$timezone_region" ] || [ -z "$timezone_city" ]; do
		printf 'Enter the name of your Region (e.g., Europe): '
		read -r timezone_region
		printf 'Enter the timezone name of your city (e.g., Berlin): '
		read -r timezone_city
	done

	if [ -f /usr/share/zoneinfo/"$timezone_region"/"$timezone_city" ]; then
		ln -sf /usr/share/zoneinfo/"$timezone_region"/"$timezone_city" /etc/localtime
	else
		print_error "The specified Region, and/or city were not found."
		timezone_region=
		timezone_city=
		set_time_zone
	fi
}

set_hardware_clock() {
	hwclock --systohc
}

set_locale() {
	echo "$locale_full" >>/etc/locale.gen
	locale-gen
	echo "LANG=${locale}" >/etc/locale.conf
}

set_vconsole() {
	echo "KEYMAP=${keyboard_layout}" >/etc/vconsole.conf
}

configure_network() {
	while [ -z "$hostname" ]; do
		printf 'Enter hostname: '
		read -r hostname
	done

	echo "$hostname" >/etc/hostname

	cat <<-EOF >/etc/hosts
		127.0.0.1 localhost
		::1                                 localhost
		127.0.1.1 "${hostname}".localdomain "${hostname}"
	EOF
}

install_boot_loader() {
	if [ "$boot_mode" = 'uefi' ]; then
		# grub-install --target=x86_64-efi --efi-directory=/boot/EFI --bootloader-id=GRUB
		bootctl install
		cp /usr/share/systemd/bootctl/arch.conf /boot/loader/entries/
		echo 'default arch.conf' >/boot/loader/loader.conf
		sed -i '$atimeout 3' /boot/loader/loader.conf
		sed -i 's/^\s*options.*$/options root=UUID='"$root_uuid"' rw/' /boot/loader/entries/arch.conf
	else
		grub-install --target=i386-pc /dev/"$drive_name"
		grub-mkconfig -o /boot/grub/grub.cfg
	fi
}

configure_boot_loader() {
	if ask_yes_no "$want_encryption"; then
		echo "swap      UUID=${swap_uuid}    /dev/urandom swap,offset=2048,cipher=aes-xts-plain64,size=512" >>/etc/crypttab
		if [ "$boot_mode" = 'uefi' ]; then
			sed -i 's/^\s*HOOKS=.*$/HOOKS=(base systemd autodetect keyboard sd-vconsole modconf block sd-encrypt filesystems fsck)/' /etc/mkinitcpio.conf
			sed -i 's/^\s*options.*$/options rd\.luks\.name='"$root_uuid"'=croot root=\/dev\/mapper\/croot/' /boot/loader/entries/arch.conf
		else
			sed -i 's/^\s*HOOKS=.*$/HOOKS=(base udev autodetect keyboard keymap consolefont modconf block encrypt filesystems fsck)/' /etc/mkinitcpio.conf
			sed -i 's/^\s*GRUB_CMDLINE_LINUX_DEFAULT="\(.*\)"$/GRUB_CMDLINE_LINUX_DEFAULT="\1 cryptdevice=UUID='"$root_uuid"':croot root=\/dev\/mapper\/croot"/' /etc/default/grub
			grub-mkconfig -o /boot/grub/grub.cfg
		fi
	fi
}

setup_initramfs() {
	mkinitcpio -P
}

change_root_password() {
	set +e
	echo 'Change root password..'
	passwd
	set -e
}

add_normal_user() {
	set +e
	echo 'Add a normal user...'

	printf 'Enter username: '
	read -r user_name
	useradd -mG wheel $user_name
	echo "Set the user\'s password"
	passwd $user_name

	# Make wheel group use sudo
	echo 'Adding wheel group to sudoers...'
	echo '%wheel ALL=(ALL) ALL' | EDITOR='tee -a' visudo

	# Alternative
	# sed -i "s/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/" /etc/sudoers
	echo 'Done.'
	set -e
}

run_part2() {
	source_env
	set_time_zone
	set_hardware_clock
	set_locale
	set_vconsole
	configure_network
	get_partition_path
	get_partition_uuid
	install_boot_loader
	configure_boot_loader
	setup_initramfs
	change_root_password
	add_normal_user
	set +e
	final_commands
	set -e
	exit
}

run_part1() {
	check_root
	update_system_clock
	set_keyboard_layout
	verify_boot_mode
	partion_disk
	format_partition
	mount_file_system
	change_pacman_mirrorlist
	config_pacman
	install_essential_packages
	generate_fstab
	copy_script_to_chroot
	run_arch_chroot
	finish_and_reboot
}

main() {
	if [ "$1" = 'part2' ]; then
		run_part2 "$@"
	else
		run_part1 "$@"
	fi
}

main "$@"
