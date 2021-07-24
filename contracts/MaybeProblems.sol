// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;

//////////////////////////////
/// CHALLENGE INSTRUCTIONS ///
//////////////////////////////

// In each contract below, comment above each line where there may be a significant error
// If there is an error, explain in detail why there is an error and how one might fix the error
// Do not actually code any solutions. Only comment how to fix each error in a short paragraph

// withdraw function could be attacked. It calls the anonymous fallback function on msg.sender.
// The caller would then call the function again, hence the reentrancy attack.
// To fix this, I'll add bool-type variable to lock and modifier to check it.
// This modifier should be called in withdraw function
contract A {
  uint256 public constant WITHDRAWAL_LIMIT = 1 ether;
  mapping(address => uint256) public lastWithdrawTime;
  mapping(address => uint256) public balances;

  function deposit() public payable {
    balances[msg.sender] += msg.value;
  }

  function withdraw(uint256 _amount) public {
    require(balances[msg.sender] >= _amount);
    require(_amount <= WITHDRAWAL_LIMIT);
    require(block.timestamp >= lastWithdrawTime[msg.sender] + 1 weeks);
    (bool sent, ) = msg.sender.call{ value: _amount }("");
    require(sent, "Failed to send Ether");
    balances[msg.sender] -= _amount;
    lastWithdrawTime[msg.sender] = block.timestamp;
  }
}

// Both functions of this contract uses this.balance and logic depends on this.balance. This value could be changed by
// other oeprations (send ether to contract), so attacker always could be winner or in other case, this contract logic
// don't work correctly.
// To prevent this, we need to track balance changes by contract functions only.
contract B {
  uint256 public targetAmount = 7 ether;
  address public winner;

  function deposit() public payable {
    require(msg.value == 1 ether, "You can only send 1 Ether");
    uint256 balance = address(this).balance;
    require(balance <= targetAmount, "Game is over");
    if (balance == targetAmount) winner = msg.sender;
  }

  function claimReward() public {
    require(msg.sender == winner, "Not winner");
    (bool sent, ) = msg.sender.call{ value: address(this).balance }("");
    require(sent, "Failed to send Ether");
  }
}

contract C1 {
  address public owner;

  function pwn() public {
    owner = msg.sender;
  }
}

// Contract C1 and C2 is simple usage of proxy, but in C1 is stateful, An attacker could be owner of C1 and manage the contract itself.
// To avoid this, make the C1 contract as library. Because library is non-stateful.
contract C2 {
  address public owner;
  C1 public c1;

  constructor(C1 _c1) {
    owner = msg.sender;
    c1 = C1(_c1);
  }

  fallback() external payable {
    address(c1).delegatecall(msg.data);
  }
}

// The problem is using tx.origin
// If the attacker define interface of the contract D and call the transfer method, tx.origin is owner address.
// So, don't use tx.origin for authorization.
// Use msg.sender instead.
contract D {
  address public owner;

  constructor() payable {
    owner = msg.sender;
  }

  function transfer(address payable _to, uint256 _amount) public {
    require(tx.origin == owner, "Not owner");
    (bool sent, ) = _to.call{ value: _amount }("");
    require(sent, "Failed to send Ether");
  }
}

// Same signature can be used multiple times to execute a function.
// This can be harmful if the signer's intention was to approve a transaction once.
// To prevent, we can use nonce as a parameter of transfer and getTxHash function.
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract E {
  using ECDSA for bytes32;

  address[2] public owners;

  constructor(address[2] memory _owners) payable {
    owners = _owners;
  }

  function deposit() external payable {}

  function transfer(
    address _to,
    uint256 _amount,
    bytes[2] memory _sigs
  ) external {
    bytes32 txHash = getTxHash(_to, _amount);
    require(_checkSigs(_sigs, txHash), "invalid sig");

    (bool sent, ) = _to.call{ value: _amount }("");
    require(sent, "Failed to send Ether");
  }

  function getTxHash(address _to, uint256 _amount)
    public
    view
    returns (bytes32)
  {
    return keccak256(abi.encodePacked(_to, _amount));
  }

  function _checkSigs(bytes[2] memory _sigs, bytes32 _txHash)
    private
    view
    returns (bool)
  {
    bytes32 ethSignedHash = _txHash.toEthSignedMessageHash();

    for (uint256 i = 0; i < _sigs.length; i++) {
      address signer = ethSignedHash.recover(_sigs[i]);
      bool valid = signer == owners[i];

      if (!valid) {
        return false;
      }
    }

    return true;
  }
}
