    EIP: <to be assigned>
    Title: Micro Contract Architecture
    Author: James Lockhart <james@n3tw0rk.co.uk>
    Type: Standard Track
    Category: ERC
    Status: Draft
    Created: 2017-10-29

## Simple Summary
A contract design pattern to detach functionality and enable contract mutability.

## Abstract
Micro contract architecture is based around the microservice architecture design. This where functionality of one system is spread across multiple smaller components, allowing individual component modification to not impact the entire system. The micro contract design encapsulates an single contract which follows a gateway design pattern that delegates functionality to micro contracts.

## Motivation
The micro contract architecture is to addresses two key issues within smart contracts. The first is the immutability of contracts, once a contract has been deployed to the network it is set in stone and any bugs or vulnerabilities are set firmly with it. Micro contracts won't resolve this completely, but allows contracts to have detached functionality and enables publishers to fix core issues in a live contract. The second issue this will help resolve is monolithic contracts, where an entire application's functionality is contained within a single contract. Monolithic architecture is one of the key driving forces many service developers move towards a micro base architecture. Functionality detachment enables improved development, code clarity, maintainability and minimizes deployment risks.

## Specification
There are two core components of the micro contract architecture design which are the gateway and the micro contract.

* * *

#### The Gateway

The gateway acts as a not just a relay, but also a component manager. It has the ability to delegate contracts to lookup keys and control access to components.

```javascript
contract Gateway {
  address internal _owner;
  mapping(bytes32 => address) internal _services;
  mapping(bytes32 => bool) internal _enabled;

  event ServiceComponentModification(bytes32, address);
  event ServiceAccessModification(bytes32, bool);

  modifier canModify(address addr) {
    require(_owner == addr);
    _;
  }

  function modifyComponent(bytes32 action, address addr) public canModify(msg.sender);
  function modifyAccess(bytes32 action, bool enabled) public canModify(msg.sender);
}
```

* * *

##### Owner Constraint

Ownership is a subjective design to either singular or delegated, for this concept I've opted for singular and implementations are at the developers discretion.

```javascript
address internal _owner;
```
This is simply an owner address stored against a storage variable which usually would be assigned from the constructor and immutable once set.

```javascript
modifier canModify(address addr) {
  require(_owner == addr);
  _;
}
```

The modifier is essential to ensure constraints are applied to component alterations and access modification.

* * *

##### Component modification

Components are referenced by fixed byte arrays and are represented as ASCII strings, the micro contracts are stored as addresses which is what allows the modification of the micro contracts.

```javascript
mapping(bytes32 => address) internal _services;
```

Each service should have an `byte32` to `address` mapping which stores the locations of the micro contracts.

```javascript
event ServiceComponentModification(bytes32, address);
```

Events should be logged on any change to micro contract locations to ensure all changes are as transparent as possible.

```javascript
function modifyComponent(bytes32 action, address addr) public canModify(msg.sender);
```

The function call to modify the component location.

* * *

##### Access modification

Similar to the component modification, component access is identified by a fixed byte array, but unlike the components access it is driven by a simple `bool` to represent if the component can be accessed or not. This feature is designed to support the transition of a micro service by disabling the component before the transition and enabling it after the transition, as well as allowing the disabling of components if required.

```javascript
mapping(bytes32 => bool) internal _enabled;
```

Availability of components is represented by a mapping of `bytes32` to `bool` which should use the same keys as the component mapping.

```javascript
event ServiceAccessModification(bytes32, bool);
```

Events for all access modification should be logged to ensure transparency.

```javascript
function modifyAccess(bytes32 action, bool enabled) public canModify(msg.sender);
```

The function call to modify the component accessibility.

* * *

#### The Micro Contract

The micro contract template is quite straight forward as it only requires a simple access check and a validation function. This is similar to the owner constraint, but the constraint modifier should be applied to every function to prevent unauthorized interactions and access should be limited to the gateway and not the owner/creator.

```javascript
contract Micro {
  address internal _gateway;
  modifier isGateway(address addr) {
    require(_gateway == addr);
    _;
  }

  function isMicroContract() public isGateway(msg.sender) returns (address);
}
```

* * *

##### Gateway Restrictions

Due to the services being in essence part of the gateway all interactions should be limited to and only to the gateway its self.

```javascript
address internal _gateway;
```

The gateway address.

```javascript
modifier isGateway(address addr) {
  require(_gateway == addr);
  _;
}
```

Modifier to verify a call is being made from the assigned gateway.

```javascript
function isMicroContract() public isGateway(msg.sender) returns (address);
```

Function to allow the gateway to verify that this is infact a valid micro contract.

* * *

## Rationale
Immutable contracts were always going to be a challenge to the software development world and the difficult ability to produce bug free applications. Re-deploying contracts adds extra load to the network, user confusion, high gas overheads and can be quite a time consuming process, especially if user data is involved. Utilizing the micro contract design almost negates all of these issues, but understandably contributes a different set of issues. Immutability gives the users of a DApp a clear transparency, trust and overall clarity of what their interactions implicate, where as the micro contract design can take this away. The transparency remains, but this now burdened with the task of researching the micro contacts and their references. This design is fully applicable to the current state of the network, but can be done deceptively and a standard should be introduce to highlight this.

## Known Issues
Currently, there is a limitation on passing dynamic values between contract such as `string`, `bytes` and primitive arrays. Data transmission and retrieval must be achieved using a combination of a fixed length data types and multi-value parameters and return values.

## References
- [Pattern: Microservice Architecture](http://microservices.io/patterns/microservices.html)
