# Solidity-Challenge

## INSTRUCTIONS:

### General Instructions

- Click the green "Use this template" button. Make your solution repo private, and invite DMJ16 and devin-aegis-studio to the repo once you're ready to submit.

- AT THE TOP OF EACH CONTRACT FILE, PLEASE LIST GITHUB LINKS TO ANY AND ALL REPOS YOU BORROW FROM THAT YOU DO NOT EXPLICITLY IMPORT FROM ETC.
- PLEASE WRITE AS MUCH OR AS LITTLE CODE AS YOU THINK IS NEEDED TO COMPLETE THE TASK
- LIBRARIES AND UTILITY CONTRACTS (SUCH AS THOSE FROM OPENZEPPELIN) ARE FAIR GAME

### Challenge Contract

- Fill in the Challenge contract's functions so that the unit tests pass in tests/Challenge.spec.ts

  1. Please be overly explicit with your code comments
  2. Since the unit tests are written according to the incomplete contract, please do not rename functions or variables

### MaybeProblems Contracts

- In each contract, comment above each line where there may be a significant error
- If there is an error, explain in detail why there is an error and how one might fix the error
- Do not actually code any solutions
- Only comment how to fix each error in a short paragraph

### MockERC1155 Contract

- Debug the contract

  1. Debugging includes incorrect code, anti-patterns, bad formatting, gas considerations etc
  2. Please comment your code explaining your reasoning for changes/additions
  3. There are no unit tests associated with the MockERC1155 contract
  4. In case you're unfamiliar, please read about the [ERC1155 standard here](https://docs.openzeppelin.com/contracts/4.x/erc1155), but please do not spend any time converting the contract into a proper ERC1155 contract

## Usage

On Github, click the green "Use this template" button.

### Install Dependencies

```sh
yarn install
```

### Compile

1. Deletes hardhat cache and contract artifacts
2. Compiles contracts

```sh
yarn compile
```

### Coverage

1. Generates the code coverage report

```sh
yarn coverage
```

### Deploy

1. Configure deploy.ts script
2. Run below command to deploy contract to Ethereum mainnet

```sh
yarn deploy
```

**Notice: write your own testnet deployment script + command as needed**

### Prettier

1. Automatically formats Solidity code

```sh
yarn prettier
```

### Test

1. Runs mocha unit tests

```sh
yarn test
```

### TypeChain

1. Generates Smart Contract TypeScript bindings

```sh
yarn typechain
```
