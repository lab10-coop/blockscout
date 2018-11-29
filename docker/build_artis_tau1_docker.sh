#!/bin/sh

#todo: to rebuild image, delete existing: 
#sudo docker image rm blockscout_prod

export ETHEREUM_JSONRPC_VARIANT=parity 
export ETHEREUM_JSONRPC_TRACE_URL=http://rpc-trace.tau1.artis.network
export ETHEREUM_JSONRPC_HTTP_URL=http://rpc-trace.tau1.artis.network
export ETHEREUM_JSONRPC_WS_URL=ws://ws.tau1.artis.network 
export NETWORK=246785 

export COIN=ATS
export SUBNETWORK='ARTIS tau1'
export LOGO='/images/artis-logo-white.svg'



make start

