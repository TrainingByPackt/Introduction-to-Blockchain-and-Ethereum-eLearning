pragma solidity ^0.5.1;

contract MyToken {

    /* Contract data: array with balances and initial number of tokens */
    mapping (address => uint256) public balanceOf;
    uint public initialSupply = 1000000;

    /* Initializes contract with initial supply tokens to the creator of the contract */
    function MyToken() {
        // Give creator all initial tokens
        balanceOf[msg.sender] = initialSupply;
    }

    /* Send coins */
    function transfer(address _to, uint256 _value) {
        // Check if the sender has enough
        require(balanceOf[msg.sender] >= _value);
        // Check for overflows
        require(balanceOf[_to] + _value >= balanceOf[_to]);
        // Subtract from the sender
        balanceOf[msg.sender] -= _value;
        // Add the same to the recipient
        balanceOf[_to] += _value;

        // Build transferData
        transferData memory _td = transferData(msg.sender, balanceOf[_to], balanceOf[msg.sender]);

        // Push to collection
        transfers.push(_td);
    }

    transferData[] transfers;

    struct transferData{
        address origin;
        uint balanceTo;
        uint balanceFrom;
    }
}
