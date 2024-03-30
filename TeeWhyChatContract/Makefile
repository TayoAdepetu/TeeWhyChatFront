-include .env

fork-sepolia:
	@echo "Building broker binary..."
	@anvil --fork-url ${ALCHEMY_SEPOLIA_API_KEY_URL}

deploy-sepolia:
	@echo "Deploying to sepolia..."
	@forge script ./script/Deploy.s.sol --rpc-url ${ALCHEMY_SEPOLIA_API_KEY_URL}  --broadcast --private-key ${ACCOUNT_PRIVATE_KEY} --etherscan-api-key ${ETHERSCAN_API_KEY} --verify -vvvvv

fork-local:
	@echo "Building broker binary..."
	@anvil

deploy-local:
	@echo "Deploying to sepolia..."
	@forge script ./script/Deploy.s.sol --rpc-url ${LOCAL_RPC}  --broadcast --private-key ${LOCAL_PRIVATE_KEY} -vvvvv
