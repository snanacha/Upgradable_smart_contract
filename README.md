UPGRADABLE ERC20 SMART CONTRACT USING OPENZEPPELIN LIBRARY
----------------------------------------------------------

** Smart contracts are immutable, by design. But software quality heavily depends on the ability to upgrade and patch source code to produce iterative releases. Even though blockchain-based software profits significantly from the technology’s immutability, still a certain degree of mutability is needed for bug fixing and potential product improvements.

The traditional way of creating and deploying a new version of the contract includes manually migrating all states from the old contract to the new contract.
1.  Deploy a new version of the contract
2.  Manually migrate all state from the old one contract to the new one (which can be very expensive in terms of gas fees!)
3.  Update all contracts that interacted with the old contract to use the address of the new one
4.  Reach out to all your users and convince them to start using the new deployment (and handle both contracts being used simultaneously, as users are slow to migrate)

But this method poses several problems:
1.  Migrating the contract state can be expensive.
2.  As we create & deploy a new contract, the contract address will change. So you would need to update all contracts that interacted with the old contract to use the address of the new version.
3.  You would also have to reach out to all your users and convince them to start using the new contract and handle both contracts being used simultaneously, as users are slow to migrate.

WORKING OF UPGRADABLE SMART CONTRACTS
-------------------------------------

A better way is to use a proxy contract with an interface where each method delegates to the implementation contract (which contains all the logic).
A delegate call is similar to a regular call, except that all code is executed in the context of the caller (proxy), not of the callee (implementation). Because of this, a transfer in the implementation contract’s code will transfer the proxy’s balance, and any reads or writes to the contract storage will read or write from the proxy’s storage.
This approach is better because the users only interact with the proxy contract and we can change the implementation contract while keeping the same proxy contract.

To solve this problem, we can use a fallback function in the proxy contract. The fallback function will execute on any request, redirecting the request to the implementation and returning the resulting value (using opcodes). This is similar to the previous approach, but here the proxy contract doesn’t have interface methods, only a fallback function, so there is no need to change the proxy address if contract methods are changed.

OPENZEPPELIN UPGRADES
---------------------

OpenZeppelin provides a platform to develop, deploy and operate smart contract projects on Ethereum. We deploy a new version of the contract to the blockchain, allow other contracts to use them, link our project to EVM contracts already deployed and allow the usage of industry standard tested contracts of the zeppelin to be used with it. 

HOW TO UPGRADE SMART CONTRACTS
------------------------------

When you create a new upgradeable contract instance, the OpenZeppelin Upgrades Plugins actually deploys three contracts:
1.  The contract you have written, which is known as the implementation contract containing the logic.
2.  A ProxyAdmin to be the admin of the proxy.
3.  A proxy to the implementation contract, which is the contract that you actually interact with.

This allows us to decouple a contract’s state and code: the proxy holds the state, while the implementation contract provides the code. And it also allows us to change the code by just having the proxy delegate to a different implementation contract.

An upgrade then involves the following steps:
1.  Deploy the new implementation contract.
2.  Send a transaction to the proxy that updates its implementation address to the new one.

Any user of the smart contract always interacts with the proxy, which never changes its address. This allows you to roll out an upgrade or fix a bug without requesting your users to change anything on their end - they just keep interacting with the same address as always.

DSTEP 1: INITIALIZATION
-----------------------
Due to a requirement of the proxy-based upgradeability system, no constructors can be used in upgradeable contracts.To help us run initialization code, OpenZeppelin Contracts provides the Initializable base contract that allows us to tag a method as initializer, ensuring it can be run only once.When deploying this contract, we will need to specify the initializer function name (only when the name is not the default of initialize) and provide the admin address that we want to use.

DSTEP 2: UPGRADING
------------------
Due to technical limitations, when you upgrade a contract to a new version we cannot change the storage layout of that contract.This means that, if we have already declared a state variable in your contract,we cannot remove it, change its type, or declare another variable before it.Although, we can change the contract’s functions and events.
The ERC20 contract is initialized with the token’s name, symbol and decimals in its constructor.


DSTEP 3: TESTING
----------------
To test upgradeable contracts we should create unit tests for the implementation contract, along with creating higher level tests for testing interaction via the proxy. We can use deployProxy in our tests just like we do when we deploy.

## SAMPLE RINKEBY TRANSACTION [ETHERSCAN]
![pl](https://user-images.githubusercontent.com/30749584/97263096-41779500-1848-11eb-9db7-26fe5e91d633.JPG)
## DEPLOYED CONTRACT & INTERACTIONS
![ll](https://user-images.githubusercontent.com/30749584/97263498-1f324700-1849-11eb-9272-36afb14d1677.JPG)

