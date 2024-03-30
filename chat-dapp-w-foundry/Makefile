-include .env

fork-sepolia:
	@echo "Building broker binary..."
	@anvil --fork-url ${SEPOLIA_RPC_URL}

deploy-sepolia:
	@echo "Deploying to sepolia..."
	@forge script ./script/Deploy.s.sol --rpc-url ${SEPOLIA_RPC_URL}  --broadcast --private-key ${PRIVATE_KEY} --etherscan-api-key ${ETHERSCAN_API_KEY} --verify -vvvvv

fork-local:
	@echo "Building broker binary..."
	@anvil

deploy-local:
	@echo "Deploying to sepolia..."
	@forge script ./script/Deploy.s.sol --rpc-url ${LOCAL_RPC}  --broadcast --private-key ${LOCAL_PRIVATE_KEY} -vvvvv
