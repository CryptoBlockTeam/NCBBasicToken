# OrangeBlockLab OBL Token

This is implementation of ERC20 OBL tokens.

## Implementations

The OBL tokens are implemented using [Solidity](http://solidity.readthedocs.io "Solidity"), the most widely used high level language targeting the EVM and [Open Zeppelin](https://openzeppelin.org/ "Open Zeppelin") framework. [Truffle Framework](http://truffleframework.com "Truffle Framework") is used for easy compilation, migration and testing.

### OBLToken

Basic ERC implementation supporting following protections:
- Pause and Unpause transfers
- Short address protection
- Peterson's Law Protection

### OBLBasicToken

Inherits OBLToken with following additional support:
- Initial token total supply

#### Test Results

Following is test results that we have

![OBLBasicToken test results](docs/OBLBasicToken-test-results.png)

### OBLMintableToken

Inherits OBLToken with following additional support:
- Initial token supply
- Max cap token amount
- Minting tokens

#### Test Results

Following is test results that we have

![OBLMintableToken test results](docs/OBLMintableToken-test-results.png)
  
### Instructions

To install the OpenZeppelin library, run:
```sh
git submodule update --init --recursive
```

To install Truffle framework, run:
```sh
npm install -g truffle
```

##### Copyright &copy; 2017  OrangeBlockLab.
