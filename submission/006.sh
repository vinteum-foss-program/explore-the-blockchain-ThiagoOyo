# Which tx in block 257,343 spends the coinbase output of block 256,128?

coinbase_block_height=256128 
spent_coinbase_block_height=257343

coinbase_block_hash=$(bitcoin-cli getblockhash $coinbase_block_height)

coinbase_txid=$(bitcoin-cli getblock $coinbase_block_hash | jq -r '.tx[0]')

possible_txs=$(bitcoin-cli  getblockhash $spent_coinbase_block_height | xargs bitcoin-cli getblock | jq -r '.tx[]')

for txid in $possible_txs; do
    inputs=$(bitcoin-cli getrawtransaction $txid true | jq -r '.vin[] | .txid')
    for input_txid in $inputs; do
        if [ "$input_txid" == "$coinbase_txid" ]; then
            echo "$txid"
        fi
    done
done