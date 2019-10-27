pragma solidity ^0.5.3;
pragma experimental ABIEncoderV2;
import './cDao.sol';

contract Corruption {

    //This is for debugging / tracking successful builds
    address[] allContracts;

    //This will be the address of the creator of this contract, OpenOrigin.
    address ourWallet;

    constructor() payable public {
        ourWallet = msg.sender;
    }

    function doCreateCorruptionContract(
        string memory _fundName, address _debtIssuer, address _operatorOwner, uint _fundAmount, address[] memory _subContractors, uint[] memory _allocations)
        public returns (address) {
        cDao c = new cDao(_fundName,  _debtIssuer, _operatorOwner, _fundAmount, _subContractors, _allocations);
        allContracts.push(address(c));
        return address(c);
    }

    function getAllContracts() public view returns (address[] memory){
        return allContracts;
    }

    function getTotalTokensInContract(address _cdao) public view returns (uint) {
        return cDao(_cdao).getTotalTokens();
    }

    function getDaoDetails(address _cdao) public view returns (address, string memory, uint, uint, address, address, address[] memory, address[] memory, uint[]) {
        return cDao(_cdao).getDaoDetails();
    }

    function getDaoBalance(address _cdao) public view returns (uint){
        return cDao(_cdao).getDaoBalance();
    }

    function getDaoContractorsWithFunds(address _cdao) public view returns (address[] memory, uint[] memory, uint[] memory, uint[] memory){
        return cDao(_cdao).getDaoContractorsWithFunds();
    }

    function doSubmitInvoice(address _cdao, string memory _fileHash, uint _amountRequested) public {
        return cDao(_cdao).doSubmitInvoice(_fileHash, _amountRequested);
    }

    // Needs validation and testing.
    function confirmInvoiceTransferTokens(address _cdao, address _to, uint256 _amountRequested) public returns (bool success) {
        return cDao(_cdao).confirmInvoiceTransferTokens(_to, _amountRequested);
    }

    // Needs validation and testing.
    function pullFundsBurnToken(address _cdao, address payable _to, uint _amount) public returns (bool success) {
        return cDao(_cdao).pullFundsBurnToken(_to, _amount);
    }
}