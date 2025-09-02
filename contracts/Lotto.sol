// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.30;

contract Lottory {
    address public manager;
    address [] public players;
    uint public  winnerIndex;
    uint public  totalParticipant;
    address public  winnerPlayer;

constructor(){

    manager = msg.sender;
    
}

function enter() payable  public {
    require(msg.value >= 0.005 ether,"enter>=0.005");
     players.push(msg.sender);
     totalParticipant = players.length;
}

function pickWinner() public {
    require (msg.sender == manager,"You are not Autohorized");
    uint index = random()% players.length;
    (bool success,) = players[index].call{value:(address(this).balance)}("");
    require(success,"Tranfer failed");
    winnerPlayer = players[index];
    players = new address [](0);

}

function random() public  view returns(uint){    
    return uint(keccak256(abi.encodePacked(block.prevrandao,block.timestamp,players)));
}
}