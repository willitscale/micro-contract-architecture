pragma solidity ^0.4.0;

import "../services/Micro.sol";

contract Gateway {

  mapping(bytes32 => address) internal _services;
  mapping(bytes32 => bool) internal _enabled;
  address private _owner;

  event ServiceChanged(bytes32, address);
  event ServiceAccess(bytes32, bool);

  modifier canModify(address addr) {
    require(_owner == addr);
    _;
  }

  modifier canAccess(bytes32 service) {
    require(_enabled[service]);
    require(address(0) != _services[service]);
    _;
  }

  modifier isMicroContract(address addr) {
    require(Micro(addr).isMicroContract());
    _;
  }

  function Gateway(address addr)
    public {
    _owner = addr;
  }

  function modifyAccess(bytes32 action, bool enabled)
    public
    canModify(msg.sender) {
    _enabled[action] = enabled;
    ServiceAccess(action, enabled);
  }

  function modifyComponent(bytes32 action, address addr)
    public
    canModify(msg.sender)
    isMicroContract(addr) {
    _services[action] = addr;
    ServiceChanged(action, addr);
    modifyAccess(action, true);
  }

  function destruct(bytes32 service, address addr)
    public
    canModify(msg.sender) {
    Micro(_services[service])._destruct(addr);
  }
}
