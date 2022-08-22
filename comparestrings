// SPDX-License-Identifier: GPL-3.0
import "hardhat/console.sol";

pragma solidity ^0.8.7;

contract strings{
    
    function compare (string memory name1, string memory name2) public pure returns (bool)
    {
        if(keccak256(abi.encodePacked(name1))==keccak256(abi.encodePacked(name2)))
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}
