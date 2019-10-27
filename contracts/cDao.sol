pragma solidity ^0.5.3;

contract cDao {

    //Amount of tokens in your contract
    //mapping(address => uint256) public tokens;
    //might not need a mapping

    struct contractor {
        address contractorAddress;
        uint tokenAllocation;
    }

    struct invoiceSubmission{
        address submittor;
        string invoiceHash;
        uint invoiceDate;
    }

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

    //Approve proposal - if this is true then we can build the contract
    bool approved;

    //Do we need a time release for funds
    // would this be a schedule like a once every month? Or maybe an end release date?
    //uint releaseFundsDate;
    
    //How much can this contract send out --- not needed I think.
    //mapping(address => mapping(address => uint256)) public allowance;
    //This might be an array? Not sure if needed
    //address fundReceiver;

    constructor( string memory _fundName, address _debtIssuer, address _operatorOwner, uint _fundAmount, address[] memory _subContractors) public {
        fundId = address(this);
        creationDate = now;
        fundName = _fundName;
        debtIssuer = _debtIssuer;
        operatorOwner = _operatorOwner;
        fundAmount = _fundAmount;
        totalTokens = _fundAmount;
        currentTokens = _fundAmount;
        subContractors = _subContractors;
    }

    function getTotalTokens() public view returns (uint){
        return totalTokens;
    }

    function getDaoInfo() public view returns (address, string memory, uint, uint, address, address){
        return (fundId, fundName, creationDate, currentTokens, debtIssuer, operatorOwner);
    }
}