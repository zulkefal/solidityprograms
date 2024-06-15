//Get funds from users
//withdraw funds
//set a minimum funding value in usd


// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {PriceConverter} from "./PriceConverter.sol";


error NotOwner();
contract FundMe{
    using PriceConverter for uint256;
    uint256 public minimumUsd=1 * 1**18;
    address[] public funders;
    mapping (address => uint256) public addressToAmountFunded;
    address public immutable owner;

    constructor(){
    owner=msg.sender;
    }

    function fund() public payable {
        //allow user to send $
        //have a minimum sent of $5
        require(msg.value.getConversionRate() >= minimumUsd, "You need to spend more ETH!");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]+=msg.value;
    }

    function withDraw() public onlyOwner{

        for(uint256 funderIndex =0; funderIndex <funders.length; funderIndex++)
        {
            address funder= funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        funders = new address [] (0);

        //transfer
        // payable(msg.sender).transfer(address(this).balance);

        //send
        // bool sendSuccess= payable(msg.sender).send(address(this).balance);
        // require(sendSuccess,"Failed to Send");

        //call
       (bool callsuccess,)= payable(msg.sender).call{value:address(this).balance}("");
        require(callsuccess,"Call Failed");


    }

    modifier onlyOwner(){
        // require(msg.sender == owner, "sender is not Owner");
       if(msg.sender!=owner){
        revert NotOwner();
       }
        _;
    }

    
}
