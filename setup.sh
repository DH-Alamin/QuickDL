#!/bin/bash

#tool: quick downloder
#by RUR999
#fb: Riyaz Ull Rabby

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
NC='\033[0m'

#banner
function banner() {
    colors=('\033[1;31m' '\033[1;33m' '\033[1;34m' '\033[1;35m' '\033[1;32m')
    num_color=${#colors[@]}
    random=$((RANDOM % num_color))
    color=${colors[$random]}
    echo ""
    echo -e "${color} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⣀⡀"
    echo -e "${color}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿"
    echo -e "${color} ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡏⠉⠉⣿⣿"
    echo -e "${color}⠀⠀⠀⠀ ⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⠀⣿⣿"
    echo -e "${color}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⡇⠀⠀⣿⣿"
    echo -e "${color}⠀⠀⠀⠀⠀⠀⠀⠀⣠⣤⣤⣤⣿⣿⡇⠀ ⣿⣿⣤⣤⣤⣄"
    echo -e "${color} ⠀⠀⠀⠀⠀⠀ ⢿⣿⣿⣿⠿⠿⠇⠀ ⠿⠿⣿⣿⣿⡿"
    echo -e "${color} ⠀⠀⠀⠀⠀⠀⠀⠀⠙⢿⣿⣦⡀    ⣴⣿⡿⠋"
    echo -e "${color}⠀⠀⠀⠀⠀    ⠀ ⠻⣿⣿⣦⣀⣴⣿⣿⠟ ${CYAN}QuickDL"
    echo -e "${color}⠀⠀⠀⠀⠀⠀⠀      ⠻⣿⣿⣿⠟⠁ ${CYAN}By RUR999"
    echo -e "${color}⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀  ⠀⠀ ⠉"
    echo -e "${NC}"
}
# check storage
function check_storage() {
    while true; do
        clear;banner
        if [ ! -d "$HOME/storage/shared" ]; then
           echo -e "\n${RED}Storage permission required...${NC}"
           termux-setup-storage
           echo -en "${GREEN}Press enter after allowed permission.${NC}"
           read -s -n 1 ENTER
           echo ""
           continue
        else
           break
        fi
    done
}
check_storage
clear;banner
# Check and create directories
install_dir="/data/data/com.termux/files/usr/bin"
shortcut_dir="$HOME/bin"
download_dir="/sdcard/DLP"
mkdir -p "$shortcut_dir"
mkdir -p "$download_dir"

# qdl
echo -e "${CYAN}Downloading the main script...${NC}"
curl -sL "https://raw.githubusercontent.com/DH-Alamin/QuickDL/refs/heads/main/qdl.sh" -o "$install_dir/qdl"
chmod +x "$install_dir/qdl"

# termux-url-opener
echo -e "${CYAN}Creating Termux URL Opener shortcut...${NC}"
set --
cat > "$shortcut_dir/termux-url-opener" << 'EOF'
#!/bin/bash
#tool: quick downloder
#by RUR999
#fb: Riyaz Ull Rabby
qdl "$1"
EOF
chmod +x "$shortcut_dir/termux-url-opener"

# check
clear;banner
hash -r
echo -e "\n${CYAN}Check installation...${NC}"
if test -x "$install_dir/qdl"; then
   echo -e "${GREEN}SUCCESS: ${BLUE}The 'qdl' command is installed and ready.${NC}"
   echo -e "*${BLUE}Just type 'qdl' to run the tool.${NC}"
   echo -e "*${BLUE}Or use 'qdl \"<download_link>\"' to download directly.${NC}"
else
   echo -e "${RED}ERROR: ${BLUE}The 'qdl' command could not be found or not executable. Please check your Termux or try again.${NC}"
fi
if grep -q "qdl" "$shortcut_dir/termux-url-opener"; then
  echo -e "${GREEN}SUCCESS: Termux URL opener shortcut is correctly set up.${NC}"
  echo -e "*${BLUE}You can now use the 'Share' option from apps like YouTube and select Termux to download videos.${NC}"
else
  echo -e "${RED}ERROR: ${BLUE}The Termux URL opener shortcut failed to set up. Check and try again.${NC}"
fi
