#!/bin/bash
# değişkenler
BinaryName="noded"
DirectName=".noded"
ChainID="chain-id"
Token="utoken"
GasPrice="xxxutoken" # fee miktarını token ismi ile yaz
NodeName="project"
CustomPort="port no" # kurulum scripti ile aynı yap
MinGas='sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"xxx$Token\"/" \$HOME/$DirectName/config/app.toml' # min gas price komutunu yaz

echo "# Useful Commands"
echo -e "##"
echo -e "## Key "
echo " "
echo -e "### Add New Key"
echo -e '```'
echo -e "$BinaryName keys add wallet"
echo -e '```'
echo -e "### Recover Existing Key"
echo -e '```'
echo -e "$BinaryName keys add wallet --recover"
echo -e '```'
echo -e "### List All Keys"
echo -e '```'
echo -e "$BinaryName keys list"
echo -e '```'
echo -e "### Delete Keys"
echo -e '```'
echo -e "$BinaryName keys delete wallet"
echo -e '```'
echo -e "### Query Wallet Balance"
echo -e '```'
echo -e "$BinaryName q bank balances \$($BinaryName keys show wallet -a)"
echo -e '```'
echo -e "##"
echo -e "## Validator"
echo " "
echo -e "### Create New Validator"
echo -e '```'
echo "$BinaryName tx staking create-validator \\"
echo "--amount 1000000$Token \\"
echo "--pubkey \$($BinaryName tendermint show-validator) \\"
echo "--moniker \"MONIKER_NAME\" \\"
echo "--identity \"KEYBASE_ID\" \\"
echo "--details \"DETAILS\" \\"
echo "--website \"WEBSITE_URL\" \\"
echo "--chain-id $ChainID \\"
echo "--commission-rate 0.05 \\"
echo "--commission-max-rate 0.20 \\"
echo "--commission-max-change-rate 0.01 \\"
echo "--min-self-delegation 1 \\"
echo "--from wallet \\"
echo "--gas-adjustment 1.5 \\"
echo "--gas auto \\"
echo "--gas-prices $GasPrice \\"
echo "-y"
echo -e '```'
echo -e "### Edit Existing Validator"
echo -e '```'
echo "$BinaryName tx staking edit-validator \\"
echo "--new-moniker \"MONIKER_NAME\" \\"
echo "--identity \"KEYBASE_ID\" \\"
echo "--details \"DETAILS\" \\"
echo "--website \"WEBSITE_URL\" \\"
echo "--chain-id $ChainID \\"
echo "--commission-rate 0.05 \\"
echo "--from wallet \\"
echo "--gas-adjustment 1.5 \\"
echo "--gas auto \\"
echo "--gas-prices $GasPrice \\"
echo "-y"
echo -e '```'
echo -e "### Validator Details"
echo -e '```'
echo -e "$BinaryName q staking validator \$($BinaryName keys show wallet --bech val -a)"
echo -e '```'
echo -e "### Validator Unjail"
echo -e '```'
echo -e "$BinaryName tx slashing unjail --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --gas-prices $GasPrice -y"
echo -e '```'
echo -e "### Jail Reason"
echo -e '```'
echo -e "$BinaryName query slashing signing-info \$($BinaryName tendermint show-validator)"
echo -e '```'
echo -e "### List All Active Validators"
echo -e '```'
echo -e "$BinaryName q staking validators -oj --limit=3000 | jq '.validators[] | select(.status=="BOND_STATUS_BONDED")' | jq -r '(.tokens|tonumber/pow(10; 6)|floor|tostring) + " \t " + .description.moniker' | sort -gr | nl"
echo -e '```'
echo -e "### List All Inactive Validators"
echo -e '```'
echo -e "$BinaryName q staking validators -oj --limit=3000 | jq '.validators[] | select(.status=="BOND_STATUS_UNBONDED")' | jq -r '(.tokens|tonumber/pow(10; 6)|floor|tostring) + " \t " + .description.moniker' | sort -gr | nl"
echo -e '```'
echo -e "## Token"
echo " "
echo -e "### Send Token"
echo -e '```'
echo -e "$BinaryName tx bank send wallet <TO_WALLET_ADDRESS> 1000000$Token --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --gas-prices $GasPrice -y"
echo -e '```'
echo -e "### Delegate"
echo -e '```'
echo -e "$BinaryName tx staking delegate <TO_VALOPER_ADDRESS> 1000000$Token --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --gas-prices $GasPrice -y"
echo -e '```'
echo -e "### Delegate To Yourself"
echo -e '```'
echo -e "$BinaryName tx staking delegate \$($BinaryName keys show wallet --bech val -a) 1000000$Token --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --gas-prices $GasPrice -y"
echo -e '```'
echo -e "### Redelegate"
echo -e '```'
echo -e "$BinaryName tx staking redelegate <FROM_VALOPER_ADDRESS> <TO_VALOPER_ADDRESS> 1000000$Token --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --gas-prices $GasPrice -y"
echo -e '```'
echo -e "### Redelegate From Your Validator To Another"
echo -e '```'
echo -e "$BinaryName tx staking redelegate \$($BinaryName keys show wallet --bech val -a) <TO_VALOPER_ADDRESS> 1000000$Token --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --gas-prices $GasPrice -y"
echo -e '```'
echo -e "### Unbond Tokens From Your Validator"
echo -e '```'
echo -e "$BinaryName tx staking unbond \$($BinaryName keys show wallet --bech val -a) 1000000$Token --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --gas-prices $GasPrice -y"
echo -e '```'
echo -e "### Withdraw Rewards From All Validators"
echo -e '```'
echo -e "$BinaryName tx distribution withdraw-all-rewards --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --gas-prices $GasPrice -y"
echo -e '```'
echo -e "### Withdraw Commission And Rewards From Your Validator"
echo -e '```'
echo -e "$BinaryName tx distribution withdraw-rewards \$($BinaryName keys show wallet --bech val -a) --commission --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --gas-prices $GasPrice -y"
echo -e '```'
echo -e "## Governance"
echo " "
echo -e "### List All Proposals"
echo -e '```'
echo -e "$BinaryName query gov proposals"
echo -e '```'
echo -e "### View Proposal By ID"
echo -e '```'
echo -e "$BinaryName query gov proposal <ID>"
echo -e '```'
echo -e "### Vote Yes"
echo -e '```'
echo -e "$BinaryName tx gov vote <ID> yes --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --gas-prices $GasPrice -y"
echo -e '```'
echo -e "### Vote No"
echo -e '```'
echo -e "$BinaryName tx gov vote <ID> no --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --gas-prices $GasPrice -y"
echo -e '```'
echo -e "### Vote Abstain"
echo -e '```'
echo -e "$BinaryName tx gov vote <ID> abstain --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --gas-prices $GasPrice -y"
echo -e '```'
echo -e "### Vote No With Veto"
echo -e '```'
echo -e "$BinaryName tx gov vote <ID> no_with_veto --from wallet --chain-id $ChainID --gas-adjustment 1.5 --gas auto --gas-prices $GasPrice -y"
echo -e '```'
echo -e "## Configuration Settings"
echo " "
echo -e "### Pruning"
echo -e '```'
echo "sed -i \\"
echo "  -e 's|^pruning *=.*|pruning = \"custom\"|' \\"
echo "  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = \"100\"|' \\"
echo "  -e 's|^pruning-keep-every *=.*|pruning-keep-every = \"0\"|' \\"
echo "  -e 's|^pruning-interval *=.*|pruning-interval = \"10\"|' \\"
echo "  \$HOME/$DirectName/config/app.toml"
echo -e '```'
echo -e "### Enable Indexer"
echo -e '```'
echo -e "sed -i -e 's|^indexer *=.*|indexer = "kv"|' \$HOME/$DirectName/config/config.toml"
echo -e '```'
echo -e "### Disable İndexer"
echo -e '```'
echo -e "sed -i -e 's|^indexer *=.*|indexer = "null"|' \$HOME/$DirectName/config/config.toml"
echo -e '```'
echo -e "### Change Default Port"
echo -e "> ### CUSTOM_PORT=$CustomPort"
echo -e '```'
echo "sed -i -e \"s%^proxy_app = \\\"tcp://127.0.0.1:26658\\\"%proxy_app = \\\"tcp://127.0.0.1:\${CUSTOM_PORT}58\\\"%; s%^laddr = \\\"tcp://127.0.0.1:26657\\\"%laddr = \\\"tcp://127.0.0.1:\${CUSTOM_PORT}57\\\"%; s%^pprof_laddr = \\\"localhost:6060\\\"%pprof_laddr = \\\"localhost:\${CUSTOM_PORT}60\\\"%; s%^laddr = \\\"tcp://0.0.0.0:26656\\\"%laddr = \\\"tcp://0.0.0.0:\${CUSTOM_PORT}56\\\"%; s%^prometheus_listen_addr = \\\":26660\\\"%prometheus_listen_addr = \\\":\${CUSTOM_PORT}66\\\"%\" \$HOME/$DirectName/config/config.toml"
echo "sed -i -e \"s%^address = \\\"tcp://0.0.0.0:1317\\\"%address = \\\"tcp://0.0.0.0:\${CUSTOM_PORT}17\\\"%; s%^address = \\\":8080\\\"%address = \\\":\${CUSTOM_PORT}80\\\"%; s%^address = \\\"0.0.0.0:9090\\\"%address = \\\"0.0.0.0:\${CUSTOM_PORT}90\\\"%; s%^address = \\\"0.0.0.0:9091\\\"%address = \\\"0.0.0.0:\${CUSTOM_PORT}91\\\"%\" \$HOME/$DirectName/config/app.toml"
echo -e '```'
echo -e "### Set Minimum Gas Price"
echo -e '```'
echo -e "$MinGas"
echo -e '```'
echo -e "### Enable Prometheus"
echo -e '```'
echo -e "sed -i -e "s/prometheus = false/prometheus = true/" \$HOME/$DirectName/config/config.toml"
echo -e '```'
echo -e "### Reset Chain Data"
echo -e '```'
echo -e "$BinaryName tendermint unsafe-reset-all --keep-addr-book --home \$HOME/$DirectName --keep-addr-book"
echo -e '```'
echo -e "## Status And Control"
echo " "
echo -e "### Sync Status"
echo -e '```'
echo -e "$BinaryName status 2>&1 | jq .SyncInfo"
echo -e '```'
echo -e "### Validator Status"
echo -e '```'
echo -e "$BinaryName status 2>&1 | jq .ValidatorInfo"
echo -e '```'
echo -e "### Node Sattus"
echo -e '```'
echo -e "$BinaryName status 2>&1 | jq .NodeInfo"
echo -e '```'
echo -e "### Validator Key Control"
echo -e '```'
echo "[[ \$($BinaryName q staking validator \$($BinaryName keys show wallet --bech val -a) -oj | jq -r .consensus_pubkey.key) = \$($BinaryName status | jq -r .ValidatorInfo.PubKey.value) ]] && echo -e \"\\n\\e[1m\\e[32mTrue\\e[0m\\n\" || echo -e \"\\n\\e[1m\\e[31mFalse\\e[0m\\n\""
echo -e '```'
echo -e "### Query TX"
echo -e '```'
echo -e "$BinaryName query tx <TX_ID>"
echo -e '```'
echo -e "### Get Node Peer"
echo -e '```'
echo -e "echo \$($BinaryName tendermint show-node-id)@\$(curl -s ifconfig.me):\$(cat \$HOME/$DirectName/config/config.toml | sed -n '/Address to listen for incoming connection/{n;p;}' | sed 's/.*://; s/\".*//')"
echo -e '```'
echo -e "### Get Live Peers"
echo -e '```'
echo "curl -sS http://localhost:${CustomPort}57/net_info | jq -r '.result.peers[] | \"\(.node_info.id)@\(.remote_ip):\(.node_info.listen_addr)\"' | awk -F ':' '{print \$1\":\"\$(NF)}'"
echo -e '```'
echo -e "## Service Management"
echo "Reload Service Configuration"
echo -e '```'
echo "sudo systemctl daemon-reload"
echo -e '```'
echo "Enable Service"
echo -e '```'
echo "sudo systemctl enable $BinaryName"
echo -e '```'
echo "Disable Service"
echo -e '```'
echo "sudo systemctl disable $BinaryName"
echo -e '```'
echo "Start Service"
echo -e '```'
echo "sudo systemctl start $BinaryName"
echo -e '```'
echo "Stop Service"
echo -e '```'
echo "sudo systemctl stop $BinaryName"
echo -e '```'
echo "Restart Service"
echo -e '```'
echo "sudo systemctl restart $BinaryName"
echo -e '```'
echo "Check Service Status"
echo -e '```'
echo "sudo systemctl status $BinaryName"
echo -e '```'
echo "Check Service Logs"
echo -e '```'
echo "sudo journalctl -u $BinaryName -f --no-hostname -o cat"
echo -e '```'
echo -e "<h1 align="center"> Remove Node </h1>"
echo " "
echo -e '```'
echo -e "sudo systemctl stop $BinaryName && sudo systemctl disable $BinaryName && sudo rm /etc/systemd/system/$BinaryName.service && sudo systemctl daemon-reload && rm -rf \$HOME/$DirectName && rm -rf \$HOME/$NodeName && sudo rm -rf \$(which $BinaryName)"
echo -e '```'
