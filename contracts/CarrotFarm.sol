pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./CarrotToken.sol";

contract TokenFarm {
    //userAddress => stakingBal
    mapping(address => uint256) stakingBalance;
    mapping(address => bool) isStaking;
    mapping(address => uint256) public startTime;
    mapping(address=> uint256) public crtBalace;

    string public name ="TokenFarm";

    IERC20 public daiToken;
    Carrot public crtToken;

    


}