pragma solidity ^0.8.10;

contract CrowdFunding {
    address public beneficiary;
    uint public fundingGoal;
    uint public amountRaised;
    uint public deadline;
    mapping (address => uint) public balanceOf;
    bool fundingGoalReached = false;
    bool crowdsaleClosed = false;
    event GoalReached();
    event FundTransfer(address backer, uint amount, bool isContribution);

    constructor(address beneficiaryAddress, uint goal, uint duration) public {
        beneficiary = beneficiaryAddress;
        fundingGoal = goal;
        deadline = now + duration;
    }

    function () external payable {
        require(!crowdsaleClosed);
        uint amount = msg.value;
        balanceOf[msg.sender] += amount;
        amountRaised += amount;
        emit FundTransfer(msg.sender, amount, true);
        if (amountRaised >= fundingGoal){
            fundingGoalReached = true;
            emit GoalReached();
        }
    }

    modifier afterDeadline() {
        if (now >= deadline) _;
    }

    function withdraw() public afterDeadline {
        uint amount = balanceOf[msg.sender];
        balanceOf[msg.sender] = 0;
        if (amount > 0) {
            msg.sender.transfer(amount);
            emit FundTransfer(msg.sender, amount, false);
        }
    }

    function safeWithdrawal() public afterDeadline {
        if (!fundingGoalReached) {
            uint amount = amountRaised;
            amountRaised = 0;
            if (amount > 0) beneficiary.transfer(amount);
        }
        crowdsaleClosed = true;
    }
}
