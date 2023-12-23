
get_moniker () {
echo -e '\e[0;35m' && read -p "Moniker isminizi girin: " MONIKER && echo -e '\e[0m' && echo "export MONIKER=$MONIKER" >> $HOME/.bash_profile
source $HOME/.bash_profile
sleep 1
}

init() {
$BinaryName config chain-id $ChainID
$BinaryName config keyring-backend test
$BinaryName config node tcp://localhost:${CustomPort}57
$BinaryName init $MONIKER --chain-id $ChainID
print_color $Yellow "$BinaryName Başlatıldı."
}

removenode() {
exec > /dev/null 2>&1
sudo systemctl stop $BinaryName && \
sudo systemctl disable $BinaryName && \
rm /etc/systemd/system/$BinaryName.service && \
sudo systemctl daemon-reload && \
cd $HOME && \
rm -rf $DirectName && \
rm -rf $NodeName && \
rm -rf $(which $BinaryName)
exec > /dev/tty 2>&1
}


go_kurulum(){

MIMARI=$(uname -m)

if [ "$MIMARI" = "x86_64" ]; then
    # AMD64 mimarisi için
    rm -rf /usr/local/go
    wget https://golang.org/dl/go1.20.4.linux-amd64.tar.gz
    sudo tar -C /usr/local -xzf go1.20.4.linux-amd64.tar.gz
    rm -rf go1.20.4.linux-amd64.tar.gz
elif [ "$MIMARI" = "aarch64" ]; then
    # ARM64 mimarisi için
    rm -rf /usr/local/go
    wget https://golang.org/dl/go1.20.4.linux-arm64.tar.gz
    sudo tar -C /usr/local -xzf go1.20.4.linux-arm64.tar.gz
    rm -rf go1.20.4.linux-arm64.tar.gz
else
    echo "Bu mimari go kurulumunu desteklenmiyor."
    exit 1
fi
echo 'export GOPATH=$HOME/go' >> $HOME/.bash_profile
echo 'export GO111MODULE=on' >> $HOME/.bash_profile
echo "export PATH=$PATH:/usr/local/go/bin:~/go/bin" >> ~/.bash_profile
echo 'export GOROOT=/usr/local/go' >> $HOME/.bash_profile
source $HOME/.bash_profile
}








prepare_server() {
print_color $Blue "Sunucu Hazırlanıyor..."
sleep 1
sudo apt-get update -y && sudo apt-get upgrade -y
sudo apt install curl tar wget tmux htop net-tools clang pkg-config libssl-dev jq build-essential git screen make ncdu liblz4-tool -y
cd $HOME
go_kurulum
source $HOME/.bash_profile
print_color $Yellow "Güncellendi, Kütüphaneler Kuruldu, $(go version) Kuruldu"
sleep 1
}


logo() {
echo -e '\e[0;32m'
echo " ▄████████  ▄██████▄     ▄████████    ▄████████     ███▄▄▄▄    ▄██████▄  ████████▄     ▄████████ ";
echo "███    ███ ███    ███   ███    ███   ███    ███     ███▀▀▀██▄ ███    ███ ███   ▀███   ███    ███ ";
echo "███    █▀  ███    ███   ███    ███   ███    █▀      ███   ███ ███    ███ ███    ███   ███    █▀  ";
echo "███        ███    ███  ▄███▄▄▄▄██▀  ▄███▄▄▄         ███   ███ ███    ███ ███    ███  ▄███▄▄▄     ";
echo "███        ███    ███ ▀▀███▀▀▀▀▀   ▀▀███▀▀▀         ███   ███ ███    ███ ███    ███ ▀▀███▀▀▀     ";
echo "███    █▄  ███    ███ ▀███████████   ███    █▄      ███   ███ ███    ███ ███    ███   ███    █▄  ";
echo "███    ███ ███    ███   ███    ███   ███    ███     ███   ███ ███    ███ ███   ▄███   ███    ███ ";
echo "████████▀   ▀██████▀    ███    ███   ██████████      ▀█   █▀   ▀██████▀  ████████▀    ██████████ ";
echo "                        ███    ███                                                               ";
echo ""
echo -e '\e[0m' 
echo -e ''
echo -e ''
sleep 4
print_color $Blue "$NodeName Kurulumu Başlatılıyor..."
sleep 2
echo -e ''
}

service() {
exec > /dev/null 2>&1
sudo tee /etc/systemd/system/$BinaryName.service > /dev/null <<EOF
[Unit]
Description=$NodeName Node
After=network-online.target
[Service]
User=$USER
ExecStart=$(which $BinaryName) start --home $HOME/$DirectName
Restart=on-failure
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable $BinaryName
systemctl start $BinaryName
systemctl restart $BinaryName
exec > /dev/tty 2>&1
}


lastinfo() {
print_color $Green "Node Başlatıldı" sleep 1
print_color $Green "Logları Görüntülemek İçin:         sudo journalctl -u $BinaryName -fo cat" sleep 1
}





















