# How many new outputs were created by block 123,456?

total_outputs=0

block=123456

block_info=$(bitcoin-cli getblock $(bitcoin-cli getblockhash $block))

block_txs=$(echo "$block_info" | jq -r '.tx[]')

for txid in $block_txs; do

tx_details=$(bitcoin-cli getrawtransaction $txid)

decoded_tx=$(bitcoin-cli decoderawtransaction $tx_details)

output_quantity=$(echo "$decoded_tx" | jq '.vout | length')

total_outputs=$((total_outputs + output_quantity))

done

echo "$total_outputs"
