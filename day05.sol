// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract adminOnly{
  address public owner;
  uint public treasureAmount;
  mapping(address=>uint) public withdrawlAllowance;
  mapping(address=>bool) public hasWithdrawed;
  constructor(uint _treasureAmount){
    owner=msg.sender;
    treasureAmount=_treasureAmount;
  }
  modifier onlyOwner{
    require(msg.sender==owner,"Only owner can call this function");
    _;
  }
  function addTreasure(uint amount) public onlyOwner{
  treasureAmount += amount;
  }
  function approveWithdrawl(address user,uint amount) public onlyOwner{
  require(amount<=treasureAmount,"exceeded the maximum treasury funds avaliable");
  withdrawlAllowance[user]=amount;
  }
  function withdrawlTreasure(uint amount) public{
    uint allowance=withdrawlAllowance[msg.sender];
    if(msg.sender==owner){
      require(amount<=treasureAmount,"exceeded the maximum funds avaliable");
      treasureAmount -= amount;
    }
    else{
      require(allowance>0, "You don't have any treasure allowance");
      require(allowance>=amount,"exceeded the maximum funds avaliable");
      require(allowance<=treasureAmount,"exceeded the maximum treasury funds avaliable");
      require(!hasWithdrawed[msg.sender],"You have already withdrawed");
      treasureAmount-=amount;
      withdrawlAllowance[msg.sender]=0;
      hasWithdrawed[msg.sender]=true;
    }
  }
  function resetWithdrawlStatus(address _user) onlyOwner public {
    hasWithdrawed[_user]=false;
  }
  function transferOwnership(address _owner) onlyOwner public {
  require(_owner!=address(0),"Invalid address");
  owner=_owner;
  }
}
