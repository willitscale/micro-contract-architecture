pragma solidity ^0.4.0;

import "./Gateway.sol";
import "../services/Transactions.sol";
import "../services/Products.sol";

contract Shop is Gateway(msg.sender) {

  bytes32 public constant PRODUCTS = "PRODUCTS";
  bytes32 public constant TRANSACTIONS = "TRANSACTIONS";

  function listProducts()
    public
    canAccess(PRODUCTS)
    returns (bytes32) {
    return Products(_services[PRODUCTS])._list();
  }

  function addProduct(bytes32 data)
    public
    canAccess(PRODUCTS)
    returns (uint) {
    return Products(_services[PRODUCTS])._add(data);
  }

  function deleteProduct(uint productId)
    public
    canAccess(PRODUCTS)
    returns (bool) {
    return Products(_services[PRODUCTS])._del(productId);
  }

  function getProduct(uint productId)
    public
    canAccess(PRODUCTS)
    returns (bytes32) {
    return Products(_services[PRODUCTS])._get(productId);
  }

  function productVersion()
    public
    canAccess(PRODUCTS)
    returns (bytes32) {
    return Products(_services[PRODUCTS])._ver();
  }

  function addToBasket(uint productId)
    public
    canAccess(TRANSACTIONS)
    returns (bool) {
    return Transactions(_services[TRANSACTIONS])._add(productId);
  }

  function checkout()
    public
    canAccess(TRANSACTIONS)
    returns (uint) {
    return Transactions(_services[TRANSACTIONS])._checkout();
  }

  function transactionVersion()
    public
    canAccess(TRANSACTIONS)
    returns (bytes32) {
    return Transactions(_services[TRANSACTIONS])._ver();
  }
}
