// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

contract Voting {
    address public officialAddress;


    string[] public candidateList; 

    mapping(string => uint) public votesReceived;

    
    mapping(address => bool) public isVoted;  

 
    enum State {Created, Voting, Ended}  
    State public state;

    constructor(address _officialAddress, string[] memory candidateNames) {
        officialAddress = _officialAddress; 
        candidateList = candidateNames; 
        state = State.Created;
    }

    modifier onlyOfficial() {
        require(msg.sender == officialAddress, "ONLY Official");
        _;
    }

    modifier inState(State _state){
        require(state == _state, "INCORRECT STATE");
        _;
    }

    function startVote() public inState(State.Created) onlyOfficial {
        state = State.Voting;
    }

    function endVote() public inState(State.Voting) onlyOfficial {
        state = State.Ended;
    }

    function voteForCandidate(string memory candidate) public inState(State.Voting) {
        require(!isVoted[msg.sender], "Already voted!");
        votesReceived[candidate] += 1;
        isVoted[msg.sender] = true;
    }

   function totalVotesAll() 
    public 
    view 
    inState(State.Ended) 
    returns (uint total) 
{
    for (uint i = 0; i < candidateList.length; i++) {
        total += votesReceived[candidateList[i]];
    }
}
}
