pragma solidity ^0.4.11;

contract token { 
    mapping(address => uint256) balances;
    function transfer(address _receiver, uint _amount) returns (bool success) {
        balances[_receiver] += _amount;
        return true;
    } 
}

contract Crowdsale {
    address public beneficiary;
    uint public fundingGoal; uint public amountRaised; uint public deadline; uint public price;
    token public tokenReward;
    mapping(address => uint256) public balanceOf;
    bool fundingGoalReached = false;
    event GoalReached(address beneficiary, uint amountRaised);
    event FundTransfer(address backer, uint amount, bool isContribution);
    bool crowdsaleClosed = false;

    /* data structure to hold information about campaign contributors */

    /*  at initialization, setup the owner */
    function Crowdsale(
    ) {
        beneficiary = 0x0; //if successful send to
        fundingGoal = 200 ether;
        deadline = now + 20160 minutes;
        price = 1;
        tokenReward = token(0x5DCae98c9fC12f91A0dFA4b440356e71D503b9F2);// addressOfTokenUsedAsReward);
    }

    /* The function without name is the default function that is called whenever anyone sends funds to a contract */
    function () payable {
        //require(!crowdsaleClosed);        
        uint amount = msg.value;
        balanceOf[msg.sender] = amount;
        amountRaised += amount;
        //tokenReward.transfer(msg.sender, amount / price);
        //FundTransfer(msg.sender, amount, true);
    }

    modifier afterDeadline() { if (now >= deadline) _; }

    /* checks if the goal or time limit has been reached and ends the campaign */
    function checkGoalReached() afterDeadline {
        if (amountRaised >= fundingGoal){
            fundingGoalReached = true;
            GoalReached(beneficiary, amountRaised);
        }
        crowdsaleClosed = true;
    }


    function safeWithdrawal() afterDeadline {
        if (!fundingGoalReached) {
            uint amount = balanceOf[msg.sender];
            balanceOf[msg.sender] = 0;
            if (amount > 0) {
                if (msg.sender.send(amount)) {
                    FundTransfer(msg.sender, amount, false);
                } else {
                    balanceOf[msg.sender] = amount;
                }
            }
        }

        if (fundingGoalReached && beneficiary == msg.sender) {
            if (beneficiary.send(amountRaised)) {
                FundTransfer(beneficiary, amountRaised, false);
            } else {
                //If we fail to send the funds to beneficiary, unlock funders balance
                fundingGoalReached = false;
            }
        }
    }
}
