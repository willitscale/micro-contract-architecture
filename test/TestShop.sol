pragma solidity ^0.4.0;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";

import "../contracts/gateway/Shop.sol";

import "../contracts/services/transactions/TransactionsV1.sol";
import "../contracts/services/products/ProductsV1.sol";
import "../contracts/services/products/ProductsV2.sol";

contract TestShop {

  Shop private _shop;
  TransactionsV1 private _transactionsV1;
  ProductsV1 private _productsV1;
  ProductsV2 private _productsV2;

  function beforeEach() {
    _shop = new Shop();
    _transactionsV1 = new TransactionsV1(_shop);
    _productsV1 = new ProductsV1(_shop);
    _productsV2 = new ProductsV2(_shop);
  }

  function test_setProductsToVersion1_thenCallVersion() {
    _shop.modifyComponent("PRODUCTS", _productsV1);
    assert_isProductV1();
  }

  function test_setProductsToVersion2_thenCallVersion() {
    _shop.modifyComponent("PRODUCTS", _productsV2);
    assert_isProductV2();
  }

  function test_setProductsToVersion1_thenSetProductsToVersion2_thenAssertCorrectInstance() {
    _shop.modifyComponent("PRODUCTS", _productsV1);
    assert_isProductV1();
    _shop.modifyComponent("PRODUCTS", _productsV2);
    assert_isProductV2();
  }

  function test_setProductsToVersion2_thenSetProductsToVersion1_thenAssertCorrectInstance() {
    _shop.modifyComponent("PRODUCTS", _productsV2);
    assert_isProductV2();
    _shop.modifyComponent("PRODUCTS", _productsV1);
    assert_isProductV1();
  }

  function test_setProductsToVersion1_thenSetProductsToVersion2_thenSetProductsToVersion1_thenAssertCorrectInstance() {
    _shop.modifyComponent("PRODUCTS", _productsV1);
    assert_isProductV1();
    _shop.modifyComponent("PRODUCTS", _productsV2);
    assert_isProductV2();
    _shop.modifyComponent("PRODUCTS", _productsV1);
    assert_isProductV1();
  }

  function test_setTransactionsToVersion1_thenAssertCorrectInstance() {
    _shop.modifyComponent("TRANSACTIONS", _transactionsV1);
    assert_isTransactionV1();
  }

  function assert_isProductV1() {
    Assert.equal(_shop.listProducts(), 0x1, "Product V1 list should return 0x1");
    Assert.equal(_shop.addProduct(""), 1, "Add Product V1 should return 1");
    Assert.equal(_shop.deleteProduct(1), true, "Delete Product V1 should return true");
    Assert.equal(_shop.getProduct(1), "GET_1", "Get Product V1 should return GET1");
    Assert.equal(_shop.productVersion(), "VER_1", "Product V1 version should return 1");
  }

  function assert_isProductV2() {
    Assert.equal(_shop.listProducts(), 0x2, "Product V2 list should return 0x2");
    Assert.equal(_shop.addProduct(""), 2, "Add Product V2 should return 2");
    Assert.equal(_shop.deleteProduct(1), false, "Delete Product V2 should return false");
    Assert.equal(_shop.getProduct(1), "GET_2", "Get Product V2 should return GET_2");
    Assert.equal(_shop.productVersion(), "VER_2", "Product V2 version should return VER_2");
  }

  function assert_isTransactionV1() {
    Assert.equal(_shop.addToBasket(1), true, "Add to Baskey Transaction V1 should return true");
    Assert.equal(_shop.checkout(), 1, "Transaction Checkout V1 should return 1");
    Assert.equal(_shop.transactionVersion(), "VER_1", "Transaction version V1 should return VER_1");
  }
}
