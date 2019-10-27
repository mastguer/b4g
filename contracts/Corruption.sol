pragma solidity ^0.5.3;
import './cDao.sol';

contract Corruption {

    struct contractorInfo{
        //The contractor info is their address
        address id;
        //Company Name
        string name;
        // This would be a hex to something hosted on IPFS or something
        string hexForLicense;
    }

    //This is for debugging /tracking successful builds
    address[] allContracts;

    //This will be the address of the us
    address ourWallet;

    constructor() payable public {
        ourWallet = msg.sender;
    }

    //Map the contractors info to their address - so it can be easily referenced
    //mapping(address => contractorInfo) public contractor;
    //Submit a contrators info
    //function doSubmitContractorInfo(address _id, string memory _name, string memory _hexForLicense) public payable {
    //    //The contractors license would be uploaded to an immutable decentralized file storage like IPFS in a Javascript implementation
    //    contractor[_id] = contractorInfo(address(this), _name, _hexForLicense);
    //}

    function doCreateCorruptionContract(
        string memory _fundName, address _debtIssuer, address _operatorOwner, uint _fundAmount, address[] memory _subContractors, uint[] memory _allocations)
        public {
        cDao c = new cDao(_fundName,  _debtIssuer, _operatorOwner, _fundAmount, _subContractors, _allocations);
        allContracts.push(address(c));
    }

    function getAllContracts() public view returns (address[] memory){
        return allContracts;
    }

    function getTotalTokensInContract(address _contract) public view returns (uint) {
        return cDao(_contract).getTotalTokens();
    }

    function getDaoInfo(address _contract) public view returns (address, string memory, uint, uint, address, address) {
        return cDao(_contract).getDaoDetails();
    }

    function getDaoBalance(address _contract) public view returns (uint){
        return cDao(_contract).getDaoBalance();
    }
}