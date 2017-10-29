pragma solidity ^0.4.0;

contract Micro {
  address internal _gateway;

  modifier isGateway(address addr) {
    require(_gateway == addr);
    _;
  }

  function Micro(address gateway) public {
    _gateway = gateway;
  }

  function isMicroContract()
    public
    isGateway(msg.sender)
    returns(bool) {
    return true;
  }

  function _destruct(address payee)
    public
    isGateway(msg.sender) {
    selfdestruct(payee);
  }
}
