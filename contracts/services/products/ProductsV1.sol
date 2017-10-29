pragma solidity ^0.4.0;

import "../../services/Micro.sol";
import "../../services/Products.sol";

contract ProductsV1 is Products, Micro {

  function ProductsV1(address _addr) Micro(_addr) {}

  function _list()
    public
    isGateway(msg.sender)
    returns(bytes32) {
    return 0x1;
  }

  function _add(bytes32)
    public
    isGateway(msg.sender)
    returns(uint) {
    return 1;
  }

  function _del(uint)
    public
    isGateway(msg.sender)
    returns(bool) {
    return true;
  }

  function _get(uint)
    public
    isGateway(msg.sender)
    returns(bytes32) {
    return "GET_1";
  }

  function _ver()
    public
    isGateway(msg.sender)
    returns(bytes32) {
    return "VER_1";
  }
}
