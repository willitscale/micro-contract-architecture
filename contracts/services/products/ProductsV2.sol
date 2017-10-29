pragma solidity ^0.4.0;

import "../../services/Micro.sol";
import "../../services/Products.sol";

contract ProductsV2 is Products, Micro {

  function ProductsV2(address _addr) Micro(_addr) {}

  function _list()
    public
    isGateway(msg.sender)
    returns(bytes32) {
    return 0x2;
  }

  function _add(bytes32)
    public
    isGateway(msg.sender)
    returns(uint) {
    return 2;
  }

  function _del(uint)
    public
    isGateway(msg.sender)
    returns(bool) {
    return false;
  }

  function _get(uint)
    public
    isGateway(msg.sender)
    returns(bytes32) {
    return "GET_2";
  }

  function _ver()
    public
    isGateway(msg.sender)
    returns(bytes32) {
    return "VER_2";
  }
}
