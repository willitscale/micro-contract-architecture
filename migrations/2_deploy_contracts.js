var Shop = artifacts.require("./gateway/Shop.sol");

var ProductsV1 = artifacts.require("./services/products/ProductsV1.sol");
var ProductsV2 = artifacts.require("./services/products/ProductsV2.sol");

var TransactionsV1 = artifacts.require("./services/transactions/TransactionsV1.sol");

module.exports = function(deployer) {
  deployer.deploy(Shop).then(function() {
    return deployer.deploy([
      [ProductsV1, Shop.address],
      [ProductsV2, Shop.address],
      [TransactionsV1, Shop.address]
    ]);
  })
};
