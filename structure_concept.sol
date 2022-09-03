// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

contract struct_concept
{
    struct User
    {
        string name;
        string email;
        uint age;
        uint phone;
    }

    User [] public users;
    uint index;

    function add_user(string memory _name, string memory _email, uint _age, uint _phone) external
    {
       User memory temp = User(_name,_email,_age,_phone);
       users.push(temp);
        
    }

    function changeName(uint i ,string memory _name) public
    {
       users[i].name=_name;    
    }

    mapping (address => User) public allUsers;

    function addDatatoMapping(string memory _name, string memory _email, uint _age, uint _phone) external 
    {
        User memory temp = User(_name,_email,_age,_phone);
       allUsers[msg.sender]=temp;
    }

    
}
