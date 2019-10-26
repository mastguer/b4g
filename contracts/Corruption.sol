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

    //Amount of tokens in your contract
    mapping(address => uint256) public tokens;

    //How much can this contract send out --- not needed I think.
    //mapping(address => mapping(address => uint256)) public allowance;

    //Map the contractors info to their address - so it can be easily referenced
    mapping(address => contractorInfo) public contractor;

    //This is for debugging /tracking successful builds
    address[] allContracts;

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

    //Amount of tokens created
    uint totalTokens;

    //Current amount of tokens left
    uint currentTokens;

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
        cDao c = new cDao(_fundName,  _debtIssuer, _operatorOwner, _fundAmount, _subContractors);
        allContracts.push(address(c));
    }

    function getAllContracts() public view returns (address[] memory){
        return allContracts;
    }

    function getTotalTokens(address _contract) public view returns (uint) {
        return cDao(_contract).getTotalTokens();
    }

    function getDaoInfo(address _contract) public view returns (address, string memory, uint, uint, address, address) {
        return cDao(_contract).getDaoInfo();
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