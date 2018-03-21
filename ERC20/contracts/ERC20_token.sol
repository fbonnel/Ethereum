pragma solidity ^0.4.19;

import "./ERC20_interfaces.sol";
import "./SafeMath.sol";

contract ERC20_token is ERC20, ERC20_interfaces  {

  using SafeMath for uint256;

  address public owner = msg.sender;
  bool public ERC20_token_created = false;
  uint256 constant private max_uint256 = 2**256 - 1;

  mapping (address => uint256) public balances;
  mapping (address => mapping (address => uint256)) public allowed;

  string public name;
  string public symbol;
  uint8 public decimals;
  uint256 public totalSupply;

  modifier OwnerOnly() {
    require(msg.sender == owner);
    _;
  }

  modifier CanCreate() {
    require(!ERC20_token_created);
    _;
  }

  // The owner of the contract can create ERC-20 tokens only once.
  function create_ERC20_token(string _name, string _symbol, uint8 _decimals, uint256 _totalSupply) public OwnerOnly() CanCreate() returns (bool success) {
    name = _name;
    symbol = _symbol;
    decimals = _decimals;
    balances[msg.sender] = _totalSupply; // Give the creator all initial tokens.
    totalSupply = _totalSupply;
    ERC20_token_created = true; // Tokens have been created.
    return (ERC20_token_created);
  }

  function balanceOf(address _owner) external view returns (uint256 balance) {
    return balances[_owner];
  }

  function transfer(address _to, uint256 _value) external returns (bool success) {
      require(_to != address(0));
      require(_value <= balances[msg.sender]);
      balances[msg.sender] = balances[msg.sender].sub(_value);
      balances[_to] = balances[_to].add(_value);
      Transfer(msg.sender, _to, _value);
      return true;
    }

  function transferFrom(address _from, address _to, uint256 _value) external returns (bool success) {
    require(_to != address(0));
    require(_value <= balances[_from]);
    require(_value <= allowed[_from][msg.sender]);
    balances[_from] = balances[_from].sub(_value);
    balances[_to] = balances[_to].add(_value);
    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    Transfer(_from, _to, _value);
    return true;
  }

  function approve(address _spender, uint256 _value) external returns (bool success) {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);
    return true;
  }

  function allowance(address _owner, address _spender) external view returns (uint256 remaining) {
    return allowed[_owner][_spender];
  }

  function name() external view returns (string){
    return name;
  }

  function symbol() external view returns (string){
    return symbol;
  }

  function decimals() external view returns (uint8){
    return decimals;
  }

  function totalSupply() external view returns (uint256){
    return totalSupply;
  }

}
