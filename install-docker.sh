exec > /dev/null 2>&1
sudo apt-get update -y && sudo apt install jq -y && sudo apt install apt-transport-https ca-certificates curl software-properties-common -y && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - && sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y && sudo apt-get install docker-compose-plugin -y
exec > /dev/tty 2>&1
sleep 1
