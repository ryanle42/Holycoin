var HolyCoin = artifacts.require("./HolyCoin.sol");
var Crowdsale = artifacts.require("./Crowdsale.sol");
module.exports = function(deployer) {
  deployer.deploy(HolyCoin);
  deployer.deploy(Crowdsale);
};

