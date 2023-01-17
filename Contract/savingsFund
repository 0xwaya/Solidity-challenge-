
pragma solidity ^0.5.0;

contract savingsFund {
    address public owner;
    uint public totalFund;
    uint public totalInterest;
    uint public totalWithdrawals;
    uint public totalDeposits;
    uint public APY;
    mapping (address => uint) public balances;
    mapping (address => uint) public deposits;
    mapping (address => uint) public withdrawals;
    mapping (address => uint) public interestEarned;
    event Deposit(address indexed _from, uint _value);
    event Withdrawal(address indexed _from, uint _value);
    event InterestEarned(address indexed _from, uint _value);
    constructor() public {
        owner = msg.sender;
        totalFund = 0;
        totalInterest = 0;
        totalWithdrawals = 0;
        totalDeposits = 0;
        APY = 20;
    }
    function deposit() public payable {
        require(msg.value > 0);
        balances[msg.sender] += msg.value;
        deposits[msg.sender] += msg.value;
        totalFund += msg.value;
        totalDeposits += msg.value;
        emit Deposit(msg.sender, msg.value);
    }
    function withdraw(uint _amount) public {
        require(_amount > 0 && _amount <= balances[msg.sender]);
        balances[msg.sender] -= _amount;
        withdrawals[msg.sender] += _amount;
        totalFund -= _amount;
        totalWithdrawals += _amount;
        msg.sender.transfer(_amount);
        emit Withdrawal(msg.sender, _amount);
    }
    function calculateInterest() public {
        uint interest = (balances[msg.sender] * APY) / 100;
        balances[msg.sender] += interest;
        interestEarned[msg.sender] += interest;
        totalInterest += interest;
        emit InterestEarned(msg.sender, interest);
    }
    function getBalance() public view returns (uint) {
        return balances[msg.sender];
    }
    function getTotalFund() public view returns (uint) {
        return totalFund;
    }
    function getTotalInterest() public view returns (uint) {
        return totalInterest;
    }
    function getTotalWithdrawals() public view returns (uint) {
        return totalWithdrawals;
    }
    function getTotalDeposits() public view returns (uint) {
        return totalDeposits;
    }
    function getAPY() public view returns (uint) {
        return APY;
    }
    function getDeposits(address _addr) public view returns (uint) {
        return deposits[_addr];
    }
    function getWithdrawals(address _addr) public view returns (uint) {
        return withdrawals[_addr];
    }
    function getInterestEarned(address _addr) public view returns (uint) {
        return interestEarned[_addr];
    }
    function kill() public {
        require(msg.sender == owner);
        selfdestruct(owner);
    }
}
