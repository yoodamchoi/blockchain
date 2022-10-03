//SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract VotingToken is ERC20 {
    struct voter {
        address voter;
        bool status;
    }

    constructor() ERC20 ("VotingToken", "VTO") {
        owner = msg.sender;
        _mint(owner, 1000 * 10 ** 18);

        for(uint i = 1; i <= 5; i++) {
            C.push(Candidate({
                id: i,
                count: 0
            }));
        }
    }

    address public owner;

    modifier onlyOwner() {
        require (msg.sender == owner, "Access Denied");
        _;
    }

    struct Candidate {
        uint id;
        uint count;
    }

    mapping (address => voter) public voters;

    Candidate[] public C;

    function balanceOf() public {
        address person;
        voters[person].voter = person;
        _transfer(owner, voters[person].voter, 1000);
    }

    function vote(uint candidate) public {
        voter storage sender = voters[msg.sender];
        require(balanceOf(sender.voter) != 0, "cannot vote");
        require(!sender.status, "only once");
        sender.status = true;
        C[candidate].count += 1;
    }

    function winningCount() public view returns (uint winningCount_) {
        uint winningCount = 0;
        for (uint p = 0; p < C.length; p++) {
            if(C[p].count > winningCount) {
                winningCount = C[p].count;
                winningCount_ = p;
            }
        }
    }
}