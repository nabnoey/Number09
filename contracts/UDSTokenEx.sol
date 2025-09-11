// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract UDSTokenEx is ERC20 {
    uint256 public unitsOneTokenToBuy = 10;
    address public owner;
     
    event Buy(address indexed from,address indexed to,uint token);

 constructor() ERC20("UdsaneeToken", "UDS") {
        owner = msg.sender;
        _mint(address(this), 1000000 * 10 ** decimals());
    }

  modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this function");
        _;
    }          

function buy() payable public  {
      require(msg.value > 0, "There is no ETH to exchange");// เช็คว่ามี ETH ที่จะมาแลกมั้ย
        uint256 amount = msg.value * unitsOneTokenToBuy;//ใส่ ETH เข้ามาเท่าไร
        require(amount > 0, "Too less amount of token");// เช็คว่ามี Token มากกว่า 0 คือมี UDS Token ให้แลกนะ
        require(balanceOf(address(this)) >= amount, "There is no token left. Sold out!!");
         _transfer(address(this), msg.sender, amount);
        emit Buy(address(this), msg.sender, amount);
    }

// owner คนที่ deploy contract สามารถ withdraw ETH ได้
  function withdraw(uint256 amt) public onlyOwner {
        require(address(this).balance >= amt, "Not enough ETH in contract");
        payable(owner).transfer(amt);
    }
}