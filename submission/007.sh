# Only one single output remains unspent from block 123,321. What address was it sent to?


block_hash=$(bitcoin-cli  getblockhash 123321)

block_txs=$(bitcoin-cli  getblock $block_hash | jq -r '.tx[]')

for txid in $block_txs; do
    vout_index=0  
    while true; do
        unspent_tx=$(bitcoin-cli gettxout "$txid" "$vout_index" 2>/dev/null)

        if [ -z "$unspent_tx" ]; then
            break
        fi

        unspent_tx_address=$(echo "$unspent_tx" | jq -r '.scriptPubKey.address')
        if [ "$unspent_tx_address" != "null" ]; then
            echo "$unspent_tx_address"
        fi

        vout_index=$((vout_index + 1))
    done
done