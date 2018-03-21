pragma solidity ^0.4.19;

import "./ERC20_token.sol";

contract ERC20_mintable_token is ERC20_token  {

  event Mint(address indexed _to, uint256 _amount);

  bool public isMintable = true;

  modifier Mintable() {
    require(ERC20_token_created);
    require(isMintable);
    _;
  }

  // If the token is mintable, the owner of the ERC20_token contract can mint the amount of token and receive them on balance.
  function mint(uint256 _amount) OwnerOnly() Mintable() public returns (bool success) {
    totalSupply = totalSupply.add(_amount);
    balances[msg.sender] = balances[msg.sender].add(_amount);
    Mint(msg.sender, _amount);
    Transfer(address(0), msg.sender, _amount);
    return true;
  }

  // The owner can stop the minting of new tokens.
  function stopMinting() OwnerOnly() Mintable() public returns (bool success) {
    isMintable = false;
    return true;
  }

}
