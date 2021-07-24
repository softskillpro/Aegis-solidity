// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.9.0;
import '@uniswap/v2-core/contracts/interfaces/IUniswapV2Factory.sol';
////////////////////////////////////
/// DO NOT USE IN PRODUCTION!!! ///
///////////////////////////////////

////////////////////////////
/// GENERAL INSTRUCTIONS ///
////////////////////////////

// 1. AT THE TOP OF EACH CONTRACT FILE, PLEASE LIST GITHUB LINKS TO ANY AND ALL REPOS YOU BORROW FROM THAT YOU DO NOT EXPLICITLY IMPORT FROM ETC.
// 2. PLEASE WRITE AS MUCH OR AS LITTLE CODE AS YOU THINK IS NEEDED TO COMPLETE THE TASK
// 3. LIBRARIES AND UTILITY CONTRACTS (SUCH AS THOSE FROM OPENZEPPELIN) ARE FAIR GAME

//////////////////////////////
/// CHALLENGE INSTRUCTIONS ///
//////////////////////////////

// 1. Fill in the contract's functions so that the unit tests pass in tests/Challenge.spec.ts
// 2. Please be overly explicit with your code comments
// 3. Since unit tests are prewritten, please do not rename functions or variables

contract Challenge {
  uint256 public x;
  uint256 public y;
  uint256 public z;

  /// @dev delegate incrementX to the Incrementor contract below
  /// @param inc address to delegate increment call to
  function incrementX(address inc) external {
    Incrementor incContract = Incrementor(inc);
    incContract.incrementX();
    x = incContract.x();
  }

  /// @dev delegate incrementY to the Incrementor contract below
  /// @param inc address to delegate increment call to
  function incrementY(address inc) external {
    Incrementor incContract = Incrementor(inc);
    incContract.incrementY();
    y = incContract.y();
  }

  /// @dev delegate incrementZ to the Incrementor contract below
  /// @param inc address to delegate increment call to
  function incrementZ(address inc) external {
    Incrementor incContract = Incrementor(inc);
    incContract.incrementZ();
    z = incContract.z();
  }

  /// @dev determines if argument account is a contract or not
  /// @param account address to evaluate
  /// @return bool if account is contract or not
  function isContract(address account) external view returns (bool) {
    if(account == address(this)) {
      return true;
    }
    return false;
  }

  /// @dev converts address to uint256
  /// @param account address to convert
  /// @return uint256
  function addressToUint256(address account) external pure returns (uint256) {
    return uint256(uint160(account));
  }

  /// @dev converts uint256 to address
  /// @param num uint256 number to convert
  /// @return address
  function uint256ToAddress(uint256 num) external pure returns (address) {
    return address(uint160(num));
  }

  /// @dev computes uniswapV2 pair address
  /// @notice FUNCTION MUST REMAIN PURE
  /// @param token0 address of first token in pair
  /// @param token1 address of second token in pair
  /// @return address of pair
  function getUniswapV2PairAddress(address token0, address token1)
    external
    view
    returns (address)
  {
    return IUniswapV2Factory(0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f).getPair(token0, token1); // Need to change by network
  }
}

contract Incrementor {
  uint256 public y;
  uint256 public z;
  uint256 public x;

  function incrementX() external {
    x++;
  }

  function incrementY() external {
    y++;
  }

  function incrementZ() external {
    z++;
  }
}
