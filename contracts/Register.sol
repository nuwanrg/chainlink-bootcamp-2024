// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract Register{
    string private info;

    function setInfo(string memory info_) public {
        info=info_;
    }

    function getInfo() public view returns (string memory){
        return info;
    }

}