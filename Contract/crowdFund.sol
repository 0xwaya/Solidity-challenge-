pragma solidity ^0.5.0;

contract CrowdFundingERC20 {
    // Token Details
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    // Crowdfunding Details
    uint256 public fundingGoal;
    uint256 public totalRaised;
    uint256 public deadline;
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowed;

    // Events
    event FundTransfer(
        address indexed _from,
        address indexed _to,
        uint256 _value
    );

    // Constructor
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _totalSupply,
        uint256 _fundingGoal,
        uint256 _deadline
    ) public {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _totalSupply;
        fundingGoal = _fundingGoal;
        deadline = _deadline;
    }

    // Fallback function
    function () external payable {
        require(msg.value > 0);
        uint256 amount = msg.value;
        _transfer(msg.sender, address(this), amount);
        totalRaised += amount;
    }

    // Transfer tokens
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(_value <= balances[msg.sender]);
        _transfer(msg.sender, _to, _value);
        return true;
    }

    // Transfer tokens from one address to another
    function _transfer(address _from, address _to, uint256 _value) internal {
        require(_value > 0);
        require(_to != address(0));
        require(balances[_from] >= _value);
        require(allowed[_from][msg.sender] >= _value);

        balances[_from] -= _value;
        balances[_to] += _value;
        allowed[_from][msg.sender] -= _value;
        emit FundTransfer(_from, _to, _value);
    }

    // Approve tokens
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        return true;
    }

    // Transfer tokens from one address to another
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);
        _transfer(_from, _to, _value);
        return true;
    }

    // Check if the crowdfunding goal has been reached
    function goalReached() public view returns (bool) {
        return totalRaised >= fundingGoal;
    }
}
