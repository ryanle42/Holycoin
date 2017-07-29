var Holycoin = artifacts.require("./HolyCoin.sol");
module.exports = function(deployer) {
  deployer.deploy(Holycoin);
};
