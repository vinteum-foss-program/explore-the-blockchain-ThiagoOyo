# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`


txid="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"

public_keys=$(bitcoin-cli getrawtransaction $txid true | jq -c '.vin | map(.txinwitness[1])')

address=$(bitcoin-cli createmultisig 1 $public_keys | jq -r '.address')

echo "$address"
