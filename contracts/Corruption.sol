pragma solidity ^0.5.3;

contract Corruption {
    
    struct contractorInfo{
        //The contractor info is their address
        address id;
        //Company Name
        string name;
        // This would be a hex to something hosted on IPFS or something
        string hexForLicense;
    }

    mapping(address => contractorInfo) public contractor;

    //This will be the address of the us
    address ourWallet;

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

    //This person
    address fundReceiver;

    //These people are able to receive funds
    //And these people would be able to request
    address[] subContractors;

    //Approve proposal - if this is true then we can build the contract
    bool approved;

    //Do we need a time release for funds
    // would this be a schedule like a once every month? Or maybe an end release date?
    uint releaseFundsDate;

    //Date of contract creation (unix time)
    uint creationDate;

    constructor() payable public {
        ourWallet = msg.sender;
    }

    //Submit a contrators info
    function doSubmitContractorInfo(address _id, string memory _name, string memory _hexForLicense) public payable {
        //The contractors license would be uploaded to an immutable decentralized file storage like IPFS in a Javascript implementation
        contractor[_id] = contractorInfo(address(this), _name, _hexForLicense);
    }

    function doCreateCorruptionContract(string memory _fundName, address _debtIssuer, address _operatorOwner, uint _fundAmount, address[] memory _subContractors) public {
        fundId = address(this);
        fundName = _fundName;
        debtIssuer = _debtIssuer;
        operatorOwner = _operatorOwner;
        fundAmount = _fundAmount;
        subContractors = _subContractors;
        creationDate = now;
    }
}