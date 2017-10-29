pragma solidity ^0.4.0;

contract Products {
  function _list() public returns (bytes32);
  function _add(bytes32) public returns (uint);
  function _del(uint) public returns (bool);
  function _get(uint) public returns (bytes32);
  function _ver() public returns (bytes32);
}
