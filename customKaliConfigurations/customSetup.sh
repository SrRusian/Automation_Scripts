#!/bin/bash

# -----------------------------------
# 🔥 Kali Linux Full Setup Script 🔥
# Usuario: rusian | GUI: GNOME
# -----------------------------------

# -----------------------------------
# 🔑 ACTUALIZACION FIRMWARE Y SISTEMA
# -----------------------------------
echo "🔄 Actualizando el sistema..."
sudo apt update && sudo apt upgrade -y
sudo apt full-upgrade -y
sudo apt install -y linux-headers-$(uname -r)

sudo apt install kali-linux-large -y
sudo apt install --reinstall kali-desktop-gnome xorg gdm3 -y
sudo apt autoclean -y
sudo apt --fix-broken install -y

echo "🔧 Actualizando firmware..."
sudo fwupdmgr refresh && sudo fwupdmgr update

# -----------------------------------
# 🔍 SELECCIÓN MANUAL DE GPU Y CONFIGURACIÓN DE DRIVERS
# -----------------------------------
echo "🔍 ¿Qué tipo de GPU tienes?"
echo "1) NVIDIA"
echo "2) AMD"
echo "3) Omitir instalación de drivers"
read -p "Selecciona una opción (1/2/3): " GPU_OPTION

case $GPU_OPTION in
    1)
        echo "🖥 Instalando drivers para NVIDIA..."
        sudo apt install -y nvidia-driver
        echo "✅ Drivers de NVIDIA instalados correctamente."
        ;;
    2)
        echo "🔥 Instalando drivers para AMD (APU)..."
        sudo apt install -y firmware-linux-nonfree libdrm-amdgpu1 xserver-xorg-video-amdgpu
        echo "✅ Drivers de AMD instalados correctamente."
        ;;
    3)
        echo "⏭️ Saltando instalación de drivers..."
        ;;
    *)
        echo "❌ Opción no válida. No se instalarán drivers."
        ;;
esac

# -----------------------------------
# 🐳 VERIFICACIÓN E INSTALACIÓN DE DOCKER CE
# -----------------------------------
if ! command -v docker &> /dev/null; then
    echo "🐳 Docker no está instalado. Procediendo con la instalación..."
    sudo apt-get update
    sudo apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    # Agregar la clave GPG oficial de Docker
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

    # Agregar el repositorio de Docker para Debian Bookworm
    echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian bookworm stable" | sudo tee /etc/apt/sources.list.d/docker.list

    # Instalar Docker CE y sus dependencias
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    
    # Agregar usuario al grupo docker
    sudo usermod -aG docker rusian
    
    # Habilitar y arrancar Docker
    sudo systemctl enable --now docker
    echo "✅ Docker instalado correctamente."
else
    echo "✅ Docker ya está instalado."
fi

# -----------------------------------
# 🔑 VERIFICACIÓN E INSTALACIÓN DE SSH
# -----------------------------------
if ! systemctl is-active --quiet ssh; then
    echo "🔑 SSH no está instalado. Procediendo con la instalación..."
    sudo apt install -y openssh-server
    sudo systemctl enable --now ssh
    sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
    sudo sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sudo systemctl restart ssh
    echo "✅ SSH configurado correctamente."
else
    echo "✅ SSH ya está instalado y en ejecución."
fi

echo "🚀 Puedes acceder a esta máquina con:"
echo "  ssh rusian@$(hostname -I | awk '{print $1}')"

# -----------------------------------
# 🔗 VERIFICACIÓN E INSTALACIÓN DE TAILSCALE
# -----------------------------------
if ! command -v tailscale &> /dev/null; then
    echo "🔗 Tailscale no está instalado. Procediendo con la instalación..."
    curl -fsSL https://tailscale.com/install.sh | sh
    sudo systemctl enable --now tailscaled || sudo systemctl restart tailscaled
    echo "⚙️ Para autenticar la máquina en Tailscale, ejecuta: sudo tailscale up"
else
    echo "✅ Tailscale ya está instalado."
fi

# -----------------------------------
# INSTALACION GOOGLE CHROME
# -----------------------------------
echo "🌐 Instalando Google Chrome..."
if ! dpkg -l | grep -q google-chrome; then
    wget -O /tmp/google-chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    sudo dpkg -i /tmp/google-chrome.deb
    sudo apt install -f -y
else
    echo "✅ Google Chrome ya está instalado."
fi

# -----------------------------------
# INSTALACION FIREFOX
# -----------------------------------
echo "🦊 Instalando Firefox"
if ! dpkg -l | grep -q firefox; then
    sudo apt install -y firefox
fi

# -----------------------------------
# ESCALACION DE PERMISOS
# -----------------------------------
echo "🔓 Configurando permisos root en Kali Linux..."
sudo apt install -y kali-grant-root && sudo dpkg-reconfigure kali-grant-root

# -----------------------------------
# INSTALACION DEPENDENCIAS
# -----------------------------------
echo "🔍 Instalando locate..."
if ! dpkg -l | grep -q locate; then
  sudo apt install -y locate
  sudo updatedb
else
  echo "El paquete locate ya está instalado."
fi

# -----------------------------------
# CONFIGURACIONES EXTRAS
# -----------------------------------
echo "📡 Habilitando Bluetooth en el arranque..."
sudo systemctl enable bluetooth

# -----------------------------------
# INSTALACION GNOME TWEAKS
# -----------------------------------
echo "🖥 Instalando y configurando GNOME Tweaks y extensiones..."
sudo apt install -y gnome-tweaks gnome-shell-extensions
gnome-extensions enable dash-to-dock@micxgx.gmail.com
gnome-extensions enable user-theme@gnome-shell-extensions.gcampax.github.com
gnome-extensions enable appindicatorsupport@rgcjonas.gmail.com

# -----------------------------------
# CREACION DE PLANTILLAS
# -----------------------------------
echo "📂 Configurando Templates para clic derecho en GNOME..."
sudo -u rusian mkdir -p /home/rusian/Templates
echo "This is a new text document" | sudo -u rusian tee /home/rusian/Templates/NewTextDocument.txt
echo "#!/bin/bash" | sudo -u rusian tee /home/rusian/Templates/NewExecutable.sh
echo "echo 'DEFAULT: This is an executable script'" | sudo -u rusian tee -a /home/rusian/Templates/NewExecutable.sh
sudo -u rusian chmod +x /home/rusian/Templates/NewExecutable.sh
sudo -u rusian tee /home/rusian/Templates/NewLauncher.desktop <<EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=NewLauncher
Exec=/path/to/executable
Icon=/path/to/icon.png
Terminal=false
Categories=Utility;
EOL
sudo -u rusian chmod +x /home/rusian/Templates/NewLauncher.desktop

# -----------------------------------
# CONFIGURACION BURPSUITE PROFESSIONAL
# -----------------------------------
echo "📁 Creando acceso directo para BurpSuite Professional..."
if [ ! -d "/mytools/BURPSUITE_PROFESSIONAL/" ]; then
  sudo -u rusian mkdir -p /mytools/BURPSUITE_PROFESSIONAL/
  sudo -u rusian chmod +xwr /mytools/BURPSUITE_PROFESSIONAL/BurpSuite_Professional.sh
else
  echo "La carpeta de BurpSuite ya existe."
fi

sudo tee /usr/share/applications/burpsuite.desktop <<EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=BurpSuite Professional
Exec=bash -c 'nohup "/usr/lib/jvm/java-21-openjdk-amd64/bin/java" "--add-opens=java.desktop/javax.swing=ALL-UNNAMED" "--add-opens=java.base/java.lang=ALL-UNNAMED" "--add-opens=java.base/jdk.internal.org.objectweb.asm=ALL-UNNAMED" "--add-opens=java.base/jdk.internal.org.objectweb.asm.tree=ALL-UNNAMED" "--add-opens=java.base/jdk.internal.org.objectweb.asm.Opcodes=ALL-UNNAMED" "-javaagent:/mytools/BURPSUITE_PROFESSIONAL/burploader.jar" "-noverify" "-jar" "/mytools/BURPSUITE_PROFESSIONAL/burpsuite_pro_v2025.1.3.jar" >/dev/null 2>&1 &'
Icon=/mytools/BURPSUITE_PROFESSIONAL/logo.png
Terminal=false
Categories=Development;Security;Network;
EOL
sudo update-desktop-database

# -----------------------------------
# CONFIGURACION DE SSH GITHUB
# -----------------------------------
echo "🔑 Configurando SSH para clonar repos privados desde GitHub..."
sudo -u rusian mkdir -p /home/rusian/.ssh
if [ ! -f "/home/rusian/.ssh/github_rsa" ]; then
  sudo -u rusian ssh-keygen -t rsa -b 4096 -C "srremmanuelm@gmail.com" -N ""
  sudo -u rusian eval "$(ssh-agent -s)"
  sudo -u rusian ssh-add /home/rusian/.ssh/github_rsa
  echo -e "Host github.com\n  IdentityFile /home/rusian/.ssh/github_rsa\n  User git" | sudo -u rusian tee -a /home/rusian/.ssh/config
else
  echo "La clave SSH ya existe."
fi

sudo -u rusian cat /home/rusian/.ssh/id_rsa.pub | sudo -u rusian tee /home/rusian/Desktop/SSH_KEY.txt

# -----------------------------------
# INSTALACION DE TOR BROWSER
# -----------------------------------
echo "🌍 Instalando Tor y guardando accesos a la darknet..."
if ! dpkg -l | grep -q tor; then
  sudo apt install -y tor
else
  sudo apt update
  sudo apt upgrade tor -y
fi

echo "🌐 Instalando Tor Browser..."
if ! dpkg -l | grep -q torbrowser-launcher; then
  sudo apt install -y torbrowser-launcher
  torbrowser-launcher
else
  echo "Tor Browser ya está instalado."
fi

sudo -u rusian mkdir -p /home/rusian/Desktop
sudo -u rusian tee /home/rusian/Desktop/Darknet_Bookmarks.txt <<EOL
🔥 DARKNET LINKS 🔥
- Breach Forums: http://breached26tezcofqla4adzyn22notfqwcac7gpbrleg4usehljwkgqd.onion/
- Dread Forums: http://dreadytofatroptsdj6io7l3xptbet6onoyno2yv7jicoxknyazubrad.onion/
- Vortex Market: http://mq7ozbnrqdjc6cof3yakegs44kmo6vl3ajcyzdeya3zjtmi65jtmwqid.onion/
- Darknet Markets: https://dark.contact/#markets
-TorZon Market: http://torzon4kv5swfazrziqvel2imhxcckc4otcvopiv5lnxzpqu4v4m5iyd.onion/
EOL

# -----------------------------------
# CONFIGURAR CONTRASENA EN GRUB
# -----------------------------------

echo "🔒 ¿Deseas configurar una contraseña para GRUB? (s/n)"
read -r CONFIRMAR

if [[ "$CONFIRMAR" =~ ^[sS]$ ]]; then
    echo "🔒 Configurando contraseña en GRUB..."

    # Pedir contraseña al usuario
    while true; do
        read -s -p "🔑 Ingresa la nueva contraseña para GRUB: " GRUB_PASSWORD
        echo
        read -s -p "🔁 Confirma la contraseña: " GRUB_PASSWORD_CONFIRM
        echo

        # Verificar que ambas contraseñas coincidan
        if [ "$GRUB_PASSWORD" == "$GRUB_PASSWORD_CONFIRM" ]; then
            break
        else
            echo "❌ Las contraseñas no coinciden. Inténtalo de nuevo."
        fi
    done

    # Generar el hash de la contraseña
    GRUB_PASSWORD_HASH=$(echo -e "$GRUB_PASSWORD\n$GRUB_PASSWORD" | grub-mkpasswd-pbkdf2 | awk '/PBKDF2/ {print $NF}')

    # Definir el archivo de configuración de GRUB
    GRUB_CONFIG="/etc/grub.d/40_custom"

    # Especificar el usuario para GRUB
    GRUB_USER="rusian"

    # Agregar la configuración de usuario y contraseña en GRUB
    sudo bash -c "cat > $GRUB_CONFIG <<EOF
set superusers=\"$GRUB_USER\"
password_pbkdf2 $GRUB_USER $GRUB_PASSWORD_HASH
EOF"

    # Aplicar los cambios en GRUB
    sudo update-grub

    echo "✅ Contraseña de GRUB configurada correctamente."
else
    echo "❌ Configuración de contraseña de GRUB omitida."
fi

echo "✅ Contraseña de GRUB configurada correctamente con éxito."


echo "✅ Configuración finalizada. ¡Reinicia para aplicar todos los cambios!"

