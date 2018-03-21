var ERC20_token = artifacts.require("./ERC20_token.sol");
  module.exports = function(deployer) {
    deployer.deploy(ERC20_token);
  };
