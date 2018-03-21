var ERC20_interfaces = artifacts.require("./ERC20_interfaces.sol");

module.exports = function(deployer) {
  deployer.deploy(ERC20_interfaces);
};
