// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract Bank {
    address public owner;
    uint256 public rate = 3; 
    mapping(address => uint256) private balances;
    address[] private accounts;

    constructor() {
        owner = msg.sender;
    }

   
    modifier onlyOwner {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }

     function getBalance() public view returns(uint256) {
        return balances[msg.sender];
       
    }

    function deposit() public payable {
        balances[msg.sender]+=msg.value;
    }
   function withdraw(uint256 amount) public {

    require(balances[msg.sender] >= amount, "Insuffient money to withdraw!!!");
    balances[msg.sender] -= amount;

     (bool success, ) = msg.sender.call{value: amount}("");

     require(success, "Withdraw failed!!");

   }


   function getAllBalance() public view  returns(uint256) {
     return  address(this).balance;
   }
  
    function getSystemBalance() public view onlyOwner returns (uint256) {
        return address(this).balance;
    }

    
    function calculateInterest(address user) public view returns (uint256) {
        return (balances[user] * rate) / 100;
    }

    function totalInterestPerYear() public view returns (uint256) {
        uint256 totalInterest = 0;
        for (uint256 i = 0; i < accounts.length; i++) {
            totalInterest += calculateInterest(accounts[i]);
        }
        return totalInterest;
    }
}
