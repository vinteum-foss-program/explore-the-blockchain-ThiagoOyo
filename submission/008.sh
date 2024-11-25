# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`


txid="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"

raw_tx=$(bitcoin-cli getrawtransaction $txid)

witness_script=$(bitcoin-cli decoderawtransaction $raw_tx | jq -r '.vin[0].txinwitness[2]')

decoded_script=$(bitcoin-cli decodescript $witness_script | jq -r '.asm')

key=$(echo "$decoded_script" | awk '{print $2}')

echo "$key"
    