pragma solidity ^0.5.3;

contract cDao {

    //Amount of tokens in your contract
    //mapping(address => uint256) public tokens;
    //might not need a mapping

    struct contractor {
        address contractorAddress;
        uint initialTokensAllocated;
        uint remainingTokensAllocated;
        uint currentAvailableTokens;
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

    //This is the amount of money being issued
    uint totalFundAmount;

    //Amount of tokens created
    uint totalTokensFund;

    //Current amount of tokens left
    uint currentTokensFund;

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
        totalFundAmount = _fundAmount;
        totalTokensFund = _fundAmount;
        currentTokensFund = _fundAmount;
        //We need to confirm that the total amount of allocations in the array are not > the total tokens being submitted.
        for (uint i = 0; i < _subContractors.length; i++) {
            contractorInfo[_subContractors[i]] = contractor(_subContractors[i], _allocations[i], _allocations[i]);
        }
        allocations = _allocations;
        subContractors = _subContractors;
    }

    function getTotalTokens() public view returns (uint){
        return totalTokensFund;
    }

    function getRemainingTokens() public view returns (uint){
        return currentTokensFund;
    }

    function getDaoDetails() public view returns (address, string memory, uint, uint, address, address){
        return (fundId, fundName, creationDate, currentTokensFund, debtIssuer, operatorOwner);
    }

    function getDaoBalance() public view returns (uint){
        return address(this).balance;
    }

    function getDaoContractors() public view returns (address[] memory){
        return subContractors;
    }

    function getDaoAllocations() public view returns (uint[] memory){
        return allocations;
    }

    function doSubmitInvoice(string memory _fileHash, uint _amountRequested) public {
        invoiceSubmission[_fileHash] = invoice(msg.sender, _fileHash, now, _amountRequested);
    }

    // Needs validation and testing.
    function confirmInvoiceTransferTokens(address _to, uint256 _amount) public returns (bool success) {
        if (msg.sender == operatorOwner) {
            if (currentTokensFund > _amount) {
                //
                //
            }
        return true;
        }
    }


    // Needs validation and testing.
    function pullFundsBurnToken(address payable _to, uint _amount) public returns (bool success) {
        //confirm the contractor address trying to pull funds is eligibile to pull funds
        //check to see if the contractor address has available tokens left
        //_to.transfer(address(this)._amount);
    }

    //possible functionality --- block additional fund transfers into the Dao if the fundAdmount !== 0 

    //killswitch - stop all fund transfers immediately

    //
}