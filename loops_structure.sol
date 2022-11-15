// SPDX-License-Identifier: GPL-3.0
import "hardhat/console.sol";

pragma solidity ^0.8.7;

contract loop
{
  //*******************FOR-Loop*********************************************
    uint[10] public array;
    function ForLoop() public  {
            
            for (uint i=0 ; i<array.length; i++)
            {
                   array[i]=i;
            }

    }
    
    
  //###############################STRUCTURE#########################################
  struct User
    {
        string Name;
        string email;
        uint age;
        uint phone;
    }

    User [] user;
    uint index;

    function add_user(string memory _name, string memory _email, uint _age, uint _phone) public
    {
        user[index].name=_name;
    }
    
    //#################################WHILE-Loop########################################
    
     int public num=1;

    function loop() public returns (uint)
    {
        while (num<10)
        {
        
          num++;
        }        
    }

}
