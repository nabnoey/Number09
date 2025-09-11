// SPDX-License-Identifier: MIT
// Compatible with OpenZeppelin Contracts ^5.4.0
pragma solidity ^0.8.30;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {ERC20Permit} from "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";

contract UDSTokenEx is ERC20 {
    uint256 uintsOneTokenToBuy = 10;
    event Buy(address indexed form, address indexed to, uint256 tokens);
    address public owner;
    mapping(address => uint256) balances;

    constructor() ERC20("UDSTokenEx", "UDS") {
        _mint(address(this), 1000000 * 10 ** decimals());
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    function buy() payable public {
        balances[msg.sender] += msg.value;
        uint256 amount = balances[msg.sender] * uintsOneTokenToBuy;
        require(amount > 0, "Too less amount of token");
        require(balanceOf(address(this)) >= amount, "There is no token left. Sold out!");
        _transfer(address(this), msg.sender, amount);
        emit Buy(address(this), msg.sender, amount);
    }

     function withdraw(uint256 amt) public onlyOwner {
        require(address(this).balance >= amt, "Not enough ETH in contract");
        payable(owner).transfer(amt);
    }
}
