// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;
contract MathTest{
    
    uint  a = 50;
    uint  b = 100;


function getPlus() public view returns(uint){
 return  a+b;
}

function  getMinus() public view returns(uint){
 return a-b;

}

function getMultiply() public view returns(uint){
 
     return a*b;


}

function getDivide() public view returns(uint){
 
  return  a/b;

}

function getScrap() public view returns(uint){
  return  a%b;
}

function getAverage(uint x,uint y,uint z) public pure returns(uint){
   uint result = (x+y+z)/3;
    return result;

}

}
