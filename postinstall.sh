#!/usr/bin/env bash

# script basead no post install do DioLinux:
# https://github.com/Diolinux/pop-os-postinstall

# ---------------------------------------------------------------------- #

# sair automaticamente se encontrar algum erro
set -e


JETBRAINS_FONT_NAME="JetBrainsMono-2.304"
HACK_FONT_NAME="Hack"

# URLs
URL_GOOGLE_CHROME="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
URL_VISUAL_STUDIO_CODE="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
URL_FONT_JETBRAINS_MONO="https://download.jetbrains.com/fonts/$JETBRAINS_FONT_NAME.zip"
URL_FONT_HACK="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip"

DIR_DOWNLOADS="/home/$USER/Downloads/softwares"
FILE="/home/$USER/.config/gtk-3.0/bookmarks"
DIR_FONTS="$HOME/.local/share/fonts"

# CORES
VERMELHO='\e[1;91m'
VERDE='\e[1;92m'
SEM_COR='\e[0m'

# Atualizando repositório e fazendo atualização do sistema

apt_update(){
  sudo apt update && sudo apt dist-upgrade -y
}

# -------------------------------TESTES E REQUISITOS----------------------------------------- #

testes_internet(){
if ! ping -c 1 8.8.8.8 -q &> /dev/null; then
  echo -e "${VERMELHO}[ERROR] - Seu computador não tem conexão com a Internet. Verifique a rede.${SEM_COR}"
  exit 1
else
  echo -e "${VERDE}[INFO] - Conexão com a Internet funcionando normalmente.${SEM_COR}"
fi
}

## Removendo travas eventuais do apt ##
travas_apt(){
  sudo rm -f /var/lib/dpkg/lock-frontend
  sudo rm -f /var/cache/apt/archives/lock
}

## Adicionando/Confirmando arquitetura de 32 bits ##
add_archi386(){
sudo dpkg --add-architecture i386
}

## Atualizando o repositório ##
just_apt_update(){
  sudo apt update -y
}

PROGRAMAS_PARA_INSTALAR=(
  snapd
  gparted
  gnome-tweaks
  timeshift
  gufw
  solaar
  vlc
  folder-color
  git
  wget
  curl
  ubuntu-restricted-extras
  v4l2loopback-utils
  unzip
  zsh
  libu2f-udev # para funcionar com chrome
)

# ---------------------------------------------------------------------- #

## Download e instalaçao de programas externos ##

install_debs() {

# Instalar programas no apt
echo -e "${VERDE}[INFO] - Instalando pacotes apt do repositório${SEM_COR}"

for nome_do_programa in ${PROGRAMAS_PARA_INSTALAR[@]}; do
  if dpkg -l "$nome_do_programa" | grep -q ^ii; then # Só instala se já não estiver instalado
    echo "[INSTALADO] - $nome_do_programa"
  else
    sudo apt install "$nome_do_programa" -y
  fi
done

echo -e "${VERDE}[INFO] - Baixando pacotes .deb${SEM_COR}"

mkdir "$DIR_DOWNLOADS"
wget -c "$URL_GOOGLE_CHROME"       -P "$DIR_DOWNLOADS"
curl -o "$DIR_DOWNLOADS/code_stable.deb" -L "$URL_VISUAL_STUDIO_CODE"

## Instalando pacotes .deb baixados na sessão anterior ##
echo -e "${VERDE}[INFO] - Instalando pacotes .deb baixados${SEM_COR}"
sudo dpkg -i $DIR_DOWNLOADS/*.deb

}

## Instalando pacotes Flatpak ##
install_flatpaks(){

  echo -e "${VERDE}[INFO] - Instalando pacotes flatpak${SEM_COR}"

flatpak install flathub com.obsproject.Studio -y
flatpak install flathub org.gimp.GIMP -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub com.bitwarden.desktop -y
flatpak install flathub org.telegram.desktop -y
flatpak install flathub org.freedesktop.Piper -y
flatpak install flathub org.chromium.Chromium -y
flatpak install flathub org.qbittorrent.qBittorrent -y
}

## Instalando pacotes Snap ##
install_snaps(){

echo -e "${VERDE}[INFO] - Instalando pacotes snap${SEM_COR}"

sudo snap install authy

}


## Download e instalaçao de fonts externas ##

install_fonts() {
echo -e "${VERDE}[INFO] - Baixando fontes ${SEM_COR}"
wget -c "$URL_FONT_JETBRAINS_MONO" -P "$DIR_FONTS"
wget -c "$URL_FONT_HACK" -P "$DIR_FONTS"

# Unzipping
unzip "$DIR_FONTS/$HACK_FONT_NAME.zip" -d "$DIR_FONTS"
unzip "$DIR_FONTS/$JETBRAINS_FONT_NAME.zip" -d "$DIR_FONTS"

# Excluindo o que foi baixado
rm -r "$DIR_FONTS/$HACK_FONT_NAME.zip" "$DIR_FONTS/$JETBRAINS_FONT_NAME.zip"
}

# ----------------------------- PÓS-INSTALAÇÃO ----------------------------- #


## Finalização, atualização e limpeza##

system_clean(){

apt_update -y
flatpak update -y
sudo apt autoclean -y
sudo apt autoremove -y
nautilus -q
}

# ----------------------------- CONFIGS EXTRAS ----------------------------- #

#Cria pastas para produtividade no nautilus
extra_config(){

mkdir /home/$USER/.ssh/
# Pegando minha config padrao para o zsh config
curl -o /home/$USER/.ssh/config 'https://gist.githubusercontent.com/gustavod5/edc35f72b4bc3d2d29778f34cea7cb7e/raw/ccc3b866d250ce753a45460cd14662ce0a5c377a/config'


mkdir /home/$USER/TEMP
mkdir /home/$USER/AppImage
mkdir /home/$USER/Videos/OBSRec
mkdir /home/$USER/Projects
mkdir /home/$USER/Projects/personal
mkdir /home/$USER/Projects/work
mkdir /home/$USER/Projects/ufla
mkdir /home/$USER/Projects/ufla/compjr

#Adiciona atalhos ao Nautilus

if test -f "$FILE"; then
    echo "$FILE já existe"
else
    echo "$FILE não existe, criando..."
    touch /home/$USER/.config/gkt-3.0/bookmarks
fi

echo "file:///home/$USER/Projects 🗃️ Projects" >> $FILE
echo "file:///home/$USER/Projects/ufla 📚 UFLA" >> $FILE
echo "file:///home/$USER/Projects/ufla/compjr 🔵 CompJr" >> $FILE
echo "file:///home/$USER/Videos/OBSRec 🎥 OBS" >> $FILE
echo "file:///home/$USER/AppImage" >> $FILE
echo "file:///home/$USER/TEMP 🕖 TEMP" >> $FILE
}

# -------------------------------EXECUÇÃO----------------------------------------- #

travas_apt
testes_internet
travas_apt
apt_update
travas_apt
just_apt_update
add_archi386
install_debs
install_flatpaks
install_snaps
install_fonts
extra_config
apt_update
system_clean

## finalização

  echo -e "${VERDE}[INFO] - Script finalizado, instalação concluída! :)${SEM_COR}"
