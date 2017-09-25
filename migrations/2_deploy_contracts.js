var OBLToken = artifacts.require("./OBLBasicToken.sol");

module.exports = function(deployer) {
  deployer.deploy(OBLToken, 10000000000000000);
};
