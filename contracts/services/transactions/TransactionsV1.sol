pragma solidity ^0.4.0;

import "../../services/Micro.sol";
import "../../services/Transactions.sol";

contract TransactionsV1 is Transactions, Micro {

  function TransactionsV1(address _addr) Micro(_addr) {}

  function _add(uint)
    public
    isGateway(msg.sender)
    returns(bool) {
    return true;
  }

  function _checkout()
    public
    isGateway(msg.sender)
    returns(uint) {
    return 1;
  }

  function _ver()
    public
    isGateway(msg.sender)
    returns(bytes32) {
    return "VER_1";
  }
}
