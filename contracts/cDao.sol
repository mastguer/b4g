pragma solidity ^0.5.3;
pragma experimental ABIEncoderV2;

contract cDao {

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
        bool complete;
    }

    //contractor[address] will retrieve their address and token allocation
    mapping(address => contractor) public contractorInfo;

    //need an array of invoices
    address[] invoices;

    //need to setup an invoice struct map
    mapping(string => invoice) public invoiceData;

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
            contractorInfo[_subContractors[i]] = contractor(_subContractors[i], _allocations[i], _allocations[i], 0);
            subContractors.push(_subContractors[i]);
        }
    }

    function getTotalTokens() public view returns (uint){
        return totalTokensFund;
    }

    function getRemainingTokens() public view returns (uint){
        return currentTokensFund;
    }

    function getDaoDetails() public view returns (address, string memory, uint, uint, address, address, address[] memory, uint[]){
        return (fundId, fundName, creationDate, currentTokensFund, debtIssuer, operatorOwner, subContractors, allocations);
    }

    function getDaoBalance() public view returns (uint){
        return address(this).balance;
    }

    function getContrator(address _address) public view returns (address, uint, uint, uint){
        return (contractorInfo[_address].contractorAddress,
        contractorInfo[_address].initialTokensAllocated,
        contractorInfo[_address].remainingTokensAllocated,
        contractorInfo[_address].currentAvailableTokens);
    }

    function getDaoContractorsWithFunds() public view returns (address[] memory, uint[] memory, uint[] memory, uint[] memory){
        address[] memory contractoraddress = new address[](subContractors.length);
        uint[] memory initialTokens = new uint[](subContractors.length);
        uint[] memory remainingTokens = new uint[](subContractors.length);
        uint[] memory currentlyAvailableToWithdraw = new uint[](subContractors.length);
        for (uint i = 0; i < subContractors.length; i++) {
            contractoraddress[i] = contractorInfo[subContractors[i]].contractorAddress;
            initialTokens[i] = contractorInfo[subContractors[i]].initialTokensAllocated;
            remainingTokens[i] = contractorInfo[subContractors[i]].remainingTokensAllocated;
            currentlyAvailableToWithdraw[i] = contractorInfo[subContractors[i]].currentAvailableTokens;
        }
        return (contractoraddress,initialTokens,remainingTokens,currentlyAvailableToWithdraw);
    }

    function doSubmitInvoice(string memory _fileHash, uint _amountRequested) public {
        if (contractorInfo[msg.sender].contractorAddress == msg.sender){
            invoiceData[_fileHash] = invoice(msg.sender, _fileHash, now, _amountRequested, false);
        }
    }

    function confirmInvoiceTransferTokens(address _to, uint256 _amountRequested) public returns (bool success) {
        if (msg.sender == operatorOwner) {
            if (currentTokensFund > _amountRequested) {
                contractorInfo[_to].currentAvailableTokens = (contractorInfo[_to].currentAvailableTokens + _amountRequested);
                contractorInfo[_to].remainingTokensAllocated = (contractorInfo[_to].remainingTokensAllocated - _amountRequested);
                currentTokensFund = (currentTokensFund - _amountRequested);
                return true;
            }
            return false;
        }
    }


    function pullFundsBurnToken(address payable _to, uint _amount) public returns (bool success) {
        if (contractorInfo[msg.sender].contractorAddress == msg.sender){
        //confirm the contractor address trying to pull funds is eligibile to pull funds
        //check to see if the contractor address has available tokens left
        //_to.transfer(address(this)._amount);
        }
    }

}