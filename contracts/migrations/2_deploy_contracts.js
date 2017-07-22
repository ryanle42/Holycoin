var HolyCoin = artifacts.require("./HolyCoin.sol");

module.exports = function(deployer) {
  deployer.deploy(HolyCoin);
};
