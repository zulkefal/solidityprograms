pragma solidity ^0.8.7;

contract vote{

    mapping (address => bool) public PersonVote; // keep the track, person has voted or not.
    mapping (address => uint) public money; // keep the track, amount is being paid or not.
    mapping(address => uint) public time;
    uint VotingTime; // when the contract is deployed, save the current time

    address payable owner;

    constructor()
    {
        owner = payable (msg.sender); // make the deployer as owner
        VotingTime=uint (block.timestamp); // save deployed time
    }

    function Vote(address comingvoter) public payable
    {
        // you can vote only in 5 minutes
        require (block.timestamp-VotingTime < 300 , "Voting Time Has been Ended"); 

        // check amount is paid before vote or not
        require(money[msg.sender]==1, "You have'nt sent money to vote");       

        // check if he already voted or not
        require(PersonVote[comingvoter] != true , "You Have already voted");
        
        // once he voted, make it true and he will be marked as vote done
        PersonVote[comingvoter]=true; 
    }

    function givemoney_tovote() public payable
    {
        // this will keep track whether the amount is paid by voter or not.
        money[msg.sender]+=1; 
        
    }

    // to check how much is the balance in this contract
    function viewcontractbalance() public view returns(uint)
    {
        return address(this).balance;
    }
    
    //only owner will withdraw the balance from this contract
    function withdrawbalance() public payable 
    {
        require(owner == msg.sender, "Your are Not Authorized");
        owner.transfer(address(this).balance);
    }

}
