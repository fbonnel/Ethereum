pragma solidity ^0.4.19;

// ERC-165 standardized interface.
interface ERC165 {
  function supportsInterface(bytes4 interfaceID) external pure returns (bool);
}

// ERC-20 standardized interface.
interface ERC20 {
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);
  function balanceOf(address _owner) external view returns (uint256 balance);
  function transfer(address _to, uint256 _value) external returns (bool success);
  function transferFrom(address _from, address _to, uint256 _value) external returns (bool succes);
  function approve(address _spender, uint256 _value) external returns (bool success);
  function allowance(address _owner, address _spender) external view returns (uint256 remaining);
  function name() external view returns (string name);
  function symbol() external view returns (string symbol);
  function decimals() external view returns (uint8 decimals);
  function totalSupply() external view returns (uint256 totalSupply);
}

contract ERC20_interfaces is ERC165 {

  // ERC-165 standardized interface identifier.
  bytes4 constant InterfaceSignature_ERC165 =
    bytes4(keccak256('supportsInterface(bytes4)'));

  // ERC-20 standardized interface identifier.
  bytes4 constant InterfaceSignature_ERC20 =
    //bytes4(keccak256('Transfer(address,address,uint256)')) ^
    //bytes4(keccak256('Approval(address,address,uint256)')) ^
    bytes4(keccak256('balanceOf(address)')) ^
    bytes4(keccak256('transfer(address,uint256)')) ^
    bytes4(keccak256('transferFrom(address,address,uint256)')) ^
    bytes4(keccak256('approve(address,uint256)')) ^
    bytes4(keccak256('allowance(address,address)')) ^
    bytes4(keccak256('name()')) ^
    bytes4(keccak256('symbol()')) ^
    bytes4(keccak256('decimals()')) ^
    bytes4(keccak256('totalSupply()'));

  /// Returns all standardized interfaces implemented by this contract.
  function print_interfaces() public pure returns (string, bytes4, string, bytes4) {
    return (
      "ERC165", InterfaceSignature_ERC165,
      "ERC20", InterfaceSignature_ERC20
      );
  }

  /// Introspection interface as per ERC-165.
  /// Returns true for any standardized interfaces implemented by this contract.
    function supportsInterface(bytes4 interfaceID) external pure returns (bool) {
      return (
        (interfaceID == InterfaceSignature_ERC165) ||
        (interfaceID == InterfaceSignature_ERC20)
      );
    }

}
