# ERC20 101

## Introduction

Welcome! This is an automated workshop that will explain how to deploy and ERC20 token, and customize it to perform specific functions.
It is aimed at developpers that have never written code in Solidity, but who understand its syntax.

## How to work on this TD

### Introduction

The TD has two components:

- An ERC20 token, ticker TD-ERC20-101, that is used to keep track of points
- An evaluator contract, that is able to mint and distribute TD-ERC20-101 points

Your objective is to gather as many TD-ERC20-101 points as possible. Please note :

- The 'transfer' function of TD-ERC20-101 has been disabled to encourage you to finish the TD with only one address
- You can answer the various questions of this workshop with different ERC20 contracts. However, an evaluated address has only one evaluated ERC20 contract at a time. To change the evaluated ERC20 contract associated with your address, call `submitExercice()` with that specific address.
- In order to receive points, you will have to do execute code in `Evaluator.sol` such that the function `TDERC20.distributeTokens(msg.sender, n);` is triggered, and distributes n points.
- This repo contains an interface `IExerciceSolution.sol`. Your ERC20 contract will have to conform to this interface in order to validate the exercice; that is, your contract needs to implement all the functions described in `IExerciceSolution.sol`.
- A high level description of what is expected for each exercice is in this readme. A low level description of what is expected can be inferred by reading the code in `Evaluator.sol`.
- The Evaluator contract sometimes needs to make payments to buy your tokens. Make sure he has enough ETH to do so! If not, you can send ETH directly to the contract.

### Getting to work

- Clone the repo on your machine
- Install the required packages `npm install truffle`, `npm install @openzeppelin/contracts@3.4.1` , `npm install @truffle/hdwallet-provider`
- Renam `example-truffle-config.js` to `truffle-config.js` . That is now your truffle config file.
- Configure a seed for deployment of contracts in your truffle config file
- Register for an infura key and set it up in your truffle config file
- Download and launch Ganache
- Test that you are able to connect to the goerli network with `truffle console`
- Test that you are able to connect to the goerli network with `truffle console --network goerli`
- To deploy a contract, configure a migration in the [migration folder](migrations). Look at the way the TD is deploy and try to iterate
- Test your deployment in Ganache `truffle migrate`
- Deploy on goerli `truffle migrate --network goerli --skip-dry-run`

## Points list

### Setting up

- Create a git repository and share it with the teacher
- Install truffle and create an empty truffle project (2 pts). Create an infura API key to be able to deploy to the goerli testnet
  These points will be attributed manually if you do not manage to have your contract interact with the evaluator, or automatically in the first question.

### ERC20 basics

- Call `ex1_getTickerAndSupply()` in the evaluator contract to receive a random ticker for your ERC20 token, as well as an initial token supply (1 pt). You can read your assigned ticker and supply in `Evaluator.sol` by calling getters `readTicker()` and `readSupply()`
- Create an ERC20 token contract with the proper ticker and supply (2 pt)
- Deploy it to the goerli testnet (1 pts)
- Call `submitExercice()` in the Evaluator to configure the contract you want evaluated (Previous 5 points are attributed at that step)
- Call `ex2_testErc20TickerAndSupply()` in the evaluator to receive your points (2 pts)

### Distributing and selling tokens

- Create a `getToken()` function in your contract, deploy it, and call the `ex3_testGetToken()` function that distributes token to the caller (2 pts).
- Create a `buyToken()` function in your contract, deploy it, and call the `ex4_testBuyToken()` function that lets the caller send an arbitrary amount of ETH, and distributes a proportionate amount of token (2 pts).

### Creating an ICO allow list

- Create a customer allow listing function. Only allow listed users should be able to call `getToken()`
- Call `ex5_testDenyListing()` in the evaluator to show he can't buy tokens using `buyTokens()` (1 pt)
- Allow the evaluator to buy tokens
- Call `ex6_testAllowListing()`in the evaluator to show he can now buy tokens `buyTokens()` (2 pt)

### Creating multi tier allow list

- Create a customer multi tier listing function. Only allow listed users should be able to call `buyToken()`; and customers should receive a different amount of token based on their level
- Call `ex7_testDenyListing()` in the evaluator to show he can't buy tokens using `buyTokens()` (1 pt)
- Add the evaluator in the first tier. He should now be able to buy N tokens for Y amount of ETH
- Call `ex8_testTier1Listing()` in the evaluator to show he can now buy tokens(2 pt)
- Add the evaluator in the second tier. He should now be able to buy 2N tokens for Y amount of ETH
- Call `ex9_testTier2Listing()` in the evaluator to show he can now buy more tokens(2 pt)

### All in one

- Finish all the workshop in a single transaction! Write a contract that implements a function called `completeWorkshop()` when called. Call `ex10_allInOne()` from this contract. All points are credited to the validating contract (2pt)

### Extra points

Extra points if you find bugs / corrections this TD can benefit from, and submit a PR to make it better. Ideas:

- Adding a way to check the code of a specific contract was only used once (no copying)

## TD addresses

- Points contracts `0x09f14a40Fd672B5B056FF8b5c343498452CAC4b2`
- Evaluator `0x7C5629d850eCD1E640b1572bC0d4ac5210b38FA5`

## The Solutions

Clone the repo on your machine
Install the required packages npm install truffle, npm install @openzeppelin/contracts@3.4.1 , npm install @truffle/hdwallet-provider
Renam example-truffle-config.js to truffle-config.js . That is now your truffle config file.
Configure a seed for deployment of contracts in your truffle config file : We use a metamask seed
Register for an infura key and set it up in your truffle config file
Download and launch Ganache
Truffle provides the compiler for smart contracts. We need it to convert the Solidity code into machine-readable code that can be deployed on Ganache blockchain.
Test that you are able to connect to the goerli network with nox truffle console --network goerli. To do so we need we need to set up the goerli network in the module.export in truffle.config.js. We will create an instance of HDWalletProvider with our mnemonic and the infura api key, but we can also use a private key instead of a mnemonic seed.
Example of code to set up our goerli network:

networks: {
goerli: {
provider: () => new HDWalletProvider(mnemonic, `https://goerli.infura.io/v3/${infuraApiKey}`),
network_id: 5,
gas: 5500000,
confirmations: 2,
timeoutBlocks: 200,
skipDryRun: true,
},

.exit to leave the console
Test your deployment in Ganache truffle migrate
Deploy on goerli truffle migrate --network goerli --skip-dry-run

### Ex1-2:

We first call the getTickerAndSupply function
then we call readTicker() and readSupply() to get the ticker and the supply
in the deploy script, we add the ticker and the supply for the deployment of our contract (variables are taken in the constructor)
then we call submit exercise with our adresse, and then we call the ex2 to get our points :)

### Ex3:

create a getToken() function in your contract, deploy it, and call the ex3_testGetToken() function that distributes token to the caller (2 pts).
we make sure that our contract ERC20TD inherits the functions of IExerciceSolution, then we implement and override all the function of IExerciceSolution
we need to implement the getToken() to success this exercise

### Ex4:

Create a buyToken() function in your contract, deploy it, and call the ex4_testBuyToken() function that lets the caller send an arbitrary amount of ETH, and distributes a proportionate amount of token (2 pts).

### Ex5:

Create a customer allow listing function. Only allow listed users should be able to call getToken()
Call ex5_testDenyListing() in the evaluator to show he can't buy tokens using buyTokens() (1 pt)

So what we are going to do is create a list of adresse that will store the people who are allow to buy

### Ex6:

Allow the evaluator to buy tokens
Call ex6_testAllowListing()in the evaluator to show he can now buy tokens buyTokens() (2 pt)

So we need to make a function that add an address in our whitelist array of address, we make this function public and call them on etherscan with the address we want in the whitelist (To go further, we should make a modifier so that only the owner of the contract can add people to the whitelist)
and then we call the ex6_testAllowListing() with the same address

### Ex7:

I create mapping to store address who are in first tier or second tier
updateTier() is a public function used to update the tier of a function

resources utiles :
https://www.youtube.com/watch?v=7ps_EPZWC_I&ab_channel=BenBK
https://www.youtube.com/watch?v=YYJgeV7sOvM&ab_channel=BlockExplorer
