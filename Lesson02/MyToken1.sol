contract MyToken1 {

    /* Contract data: array with balances and initial number of tokens */
    mapping (address => uint256) public balanceOf;
    uint public initialSupply = 1000000;

    /* Initializes contract with initial supply tokens to the creator of the contract */
    constructor() public{
        balanceOf[msg.sender] = initialSupply;              // Give creator all initial tokens
    }

    /* Send coins */
    function transfer(address _to, uint256 _value) public{
        require(balanceOf[msg.sender] >= _value);           // Check if the sender has enough
        require(balanceOf[_to] + _value >= balanceOf[_to]); // Check for overflows
        balanceOf[msg.sender] -= _value;                    // Subtract from the sender
        balanceOf[_to] += _value;                           // Add the same to the recipient
    
        transferData memory _td = transferData(msg.sender,balanceOf[_to],balanceOf[msg.sender]);
        transfers.push(_td);
    }
    
    transferData[] transfers;
    
    struct transferData{
        address origin;
        uint balanceTo;
        uint balanceFrom;
    }
}