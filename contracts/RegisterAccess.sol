// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract RegisterAccess{
    string[] private info;
    address public owner;
    mapping (address => bool) public allowlist;


    constructor() {
        owner = msg.sender;
        allowlist[msg.sender] = true;
    } 

    event InfoChange(string oldInfo, string newInfo); 

    //Modifier to restrict function to access only by owner
    modifier onlyOwner {
        require(msg.sender == owner,"Only owner");
        _;
    } 

    //Modifer to check if the sender is in the allowlist
    modifier onlyAllowlist {
        require(allowlist[msg.sender] == true, "Only allowlist");
        _;
    }

    // Function to retrieve a message from the info array by index
    function getInfo(uint index) public view returns (string memory) {
        require(index < info.length, "Index out of bounds");
        return info[index];
    } 

    function setInfo(uint index, string memory _info) public onlyAllowlist{
        emit InfoChange (info[index], _info);
        info[index]=_info;
    }

    //function to add message to info array
    function addInfo  (string memory _info)public onlyAllowlist returns ( uint index){
        info.push(_info);
        index =info.length-1;
    }

    function listInfo()public view returns(string[] memory){
        return info;
    } 

    // Function to add a member to the allowlist
    function addMember(address _member) public onlyOwner {
        allowlist[_member]=true;
    }
   

    //Function to remove a member from the whitelist
    function delMember(address _member) public onlyOwner{
        allowlist[_member]=false;
    }
}