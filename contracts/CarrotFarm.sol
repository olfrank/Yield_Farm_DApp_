pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./CarrotToken.sol";

contract TokenFarm {
    //userAddress => stakingBal
    mapping(address => uint256) stakingBalance;
    mapping(address => bool) isStaking;
    mapping(address => uint256) public startTime;
    mapping(address=> uint256) public crtBalace;

    string public name = "TokenFarm";

    IERC20 public daiToken;
    Carrot public crtToken;

    event Stake(address indexed from, uint256 amount);
    event Unstake(address indexed from, uint256 amount);
    event YieldWithdraw(address indexed to, uint256 amount);

    constructor(IERC20 _daiToken, Carrot _crtToken){
        daiToken = _daiToken;
        crtToken = _crtToken;
    }


    //********** Core function shells ***********

    function stake(uint256 amount) public {
        require(amount > 0 && daiToken.balanceOf(msg.sender) >= amount, "You cannot stake zero tokens");

        if(isStaking[msg.sender] == true){
            uint256 toTransfer = calculateYield(msg.sender);
            crtBalace[msg.sender] += toTransfer;
        }

        daiToken.transferFrom(msg.sender, address(this), amount);
        stakingBalance[msg.sender] += amount;
        startTime[msg.sender] = block.timestamp;
        isStaking[msg.sender] = true;

        emit Stake(msg.sender, amount);
    }

    function unstake(uint256 amount) public {
        require(isStaking[msg.sender] == true && stakingBalance[msg.sender] >= amount, "Nothing to unstake");
        uint256 yield = calculateYield(msg.sender);
        startTime[msg.sender] = block.timestamp;
        uint256 balanceTransfer = amount;
        amount = 0; // to prevent re-entrancy 
        stakingBalance[msg.sender] -= balanceTransfer;
        daiToken.transfer(msg.sender, balanceTransfer);
        crtBalace[msg.sender] += yield;

        if(stakingBalance[msg.sender] == 0){
            isStaking[msg.sender] == false;
        }

        emit Unstake(msg.sender, amount);
    }

    function withdrawYield() public {
        
        uint256 toTransfer = calculateYield(msg.sender);
        require(toTransfer > 0 || crtBalace[msg.sender] > 0, "Nothing to withdraw")



    }




    function calculateYield(address staker) internal returns(uint256){

    }




    function _stake() internal {

    }

    function _unstake() internal {

    }

    function _withdrawYield() internal {

    }


}
