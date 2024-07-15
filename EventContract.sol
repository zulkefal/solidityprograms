// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract EventContract {
    struct Event {
        address organizer;
        string name;
        uint256 date;
        uint256 price;
        uint256 ticketCount;
        uint256 ticketRemain;
    }
    mapping(uint256 => Event) public events;
    mapping(address => mapping(uint256 => uint256)) public tickets;
    uint256 public nextId;

    function createEvent(
        string memory name,
        uint256 date,
        uint256 price,
        uint256 ticketCount
    ) external {
        require(date > block.timestamp, "Event Must be in future");
        require(ticketCount > 0, "Create at least 1 Ticket");

        events[nextId] = Event(
            msg.sender,
            name,
            date,
            price,
            ticketCount,
            ticketCount
        );
        nextId++;
    }

    function buyTickets(uint id, uint quantity) external payable{
        require(events[id].date!=0,"Events doesnt exist");
        require(block.timestamp <events[id].date,"Event has already occured");
        Event storage _event = events[id];
        require(msg.value < _event.price*quantity,"Pay Exact Price of Ticket");
        require(_event.ticketRemain>=quantity,"Not Enough Tickets Available");  
        _event.ticketRemain-=quantity;
        tickets[msg.sender][id]+=quantity;

    }

    function transferTicket(uint id, uint quantity,address to) external payable{
        require(events[id].date!=0,"Events doesnt exist");
        require(block.timestamp <events[id].date,"Event has already occured");
        require(tickets[msg.sender][id]>=quantity,"These Number of token are not available");
        tickets[msg.sender][id]-=quantity;
        tickets[to][id]+=quantity;
    }
}
