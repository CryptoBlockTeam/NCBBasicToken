var NCBToken = artifacts.require("./NCBBasicToken.sol");
var NCBMintableToken = artifacts.require("./NCBMintableToken.sol");

module.exports = function(deployer) {
  deployer.deploy(NCBToken, 10000000000000000);
  deployer.deploy(NCBMintableToken, 10000000000000000, 50000000000000000);
};
