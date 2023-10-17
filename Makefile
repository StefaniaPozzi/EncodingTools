include .env 

.PHONY: push, interaction

push:
	git add .
	git commit -m "delegatecall"
	git push origin master


# Tool to know exactly !which function! my tx is calling
#
# 0. Check contract address
# 1. Compare the selector returned by this sig 
# with the selector on metamask data tx
# 2. Decode with calldata (below)
#
# NB. the signature name on metamask on AAVE for depositing ETH is different from the actual called
# Deposit E T H (Address, Address, Uint16) >> go trough the code instead!
# depositETH(address,address,uint16)
# source: contract code & 4byte.directory
verify-selector-on-metamask:
	cast sig 'depositETH(address,address,uint16)'

# Shows the real input that the function is using
# @params takes function sig + tx data
# @return calls
# 
decode:
	cast --calldata-decode "depositETH(address,address,uint16)" 0x474cf53d00000000000000000000000087870bca3f3fd6335c3f4ce8392d69350b4fa4e2000000000000000000000000449dabbfeb5aabc3a9477c02f47933b19250d72a0000000000000000000000000000000000000000000000000000000000000000
	


