var ERC20_mintable_token = artifacts.require("./ERC20_mintable_token.sol");
  module.exports = function(deployer) {
    deployer.deploy(ERC20_mintable_token);
  };
