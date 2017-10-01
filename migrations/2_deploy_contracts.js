var OBLToken = artifacts.require("./OBLBasicToken.sol");
var OBLMintableToken = artifacts.require("./OBLMintableToken.sol");

module.exports = function(deployer) {
  deployer.deploy(OBLToken, 10000000000000000);
  deployer.deploy(OBLMintableToken, 10000000000000000, 50000000000000000);
};
