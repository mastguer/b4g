pragma solidity ^0.5.3;

contract cDao {

    //Amount of tokens in your contract
    //mapping(address => uint256) public tokens;
    //might not need a mapping

    struct contractor {
        address contractorAddress;
        uint tokenAllocation;
    }

    // Structure for submitted invoice to the cDao
    struct invoice{
        address submittor;
        string invoiceHash;
        uint invoiceDate;
        uint amountRequested;
    }

    //contractor[address] will retrieve their address and token allocation
    mapping(address => contractor) public contractorInfo;

    //need an array of invoices
    address[] invoices;

    //need to setup an invoice struct map
    mapping(string => invoice) public invoiceSubmission;

    //Date of contract creation (unix time)
    uint creationDate;

    //This will be the address of the fund
    address fundId;

    //Fund Name
    string fundName;

    //This is the person that will approve everything
    address operatorOwner;

    //This person is issuing the debt (government)
    address debtIssuer;

    //This is the amount of money being issues
    uint fundAmount;

    //Amount of tokens created
    uint totalTokens;

    //Current amount of tokens left
    uint currentTokens;

    //These people are able to receive funds
    //And these people would be able to request
    address[] subContractors;

    //These are the allocations amounts of the total
    uint[] allocations;

    //Approve proposal - if this is true then we can build the contract
    bool approved;

    //Do we need a time release for funds would this be a schedule like a once every month? Or maybe an end release date?
    //uint releaseFundsDate;
    
    //How much can this contract send out --- not needed I think.
    //mapping(address => mapping(address => uint256)) public allowance;

    constructor(
        string memory _fundName, address _debtIssuer, address _operatorOwner, uint _fundAmount, address[] memory _subContractors, uint[] memory _allocations
        ) public {
        fundId = address(this);
        creationDate = now;
        fundName = _fundName;
        debtIssuer = _debtIssuer;
        operatorOwner = _operatorOwner;
        fundAmount = _fundAmount;
        totalTokens = _fundAmount;
        currentTokens = _fundAmount;
        subContractors = _subContractors;
        //We need to confirm that the total amount of allocations in the array are not > the total tokens being submitted.
        allocations = _allocations;
    }

    function getTotalTokens() public view returns (uint){
        return totalTokens;
    }

    function getDaoDetails() public view returns (address, string memory, uint, uint, address, address){
        return (fundId, fundName, creationDate, currentTokens, debtIssuer, operatorOwner);
    }

    function getDaoBalance() public view returns (uint){
        return address(this).balance;
    }

    function doSubmitInvoice(string memory _fileHash, uint _amountRequested) public {
        invoiceSubmission[_fileHash] = invoice(msg.sender, _fileHash, now, _amountRequested);
    }

    function transfer(address _to, uint256 _value) public returns (bool success) {
        //require(balanceOf[msg.sender] >= _value);
        //balanceOf[msg.sender] -= _value;
        //balanceOf[_to] += _value;
        //Transfer(msg.sender, _to, _value);
        //return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool success) {
        //allowance[msg.sender][_spender] = _value;
        //Approval(msg.sender, _spender, _value);
        //return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        //require(_value <= balanceOf[_from]);
        //require(_value <= allowance[_from][msg.sender]);
        //balanceOf[_from] -= _value;
        //balanceOf[_to] += _value;
        //allowance[_from][msg.sender] -= _value;
        //Transfer(_from, _to, _value);
        //return true;
    }
}