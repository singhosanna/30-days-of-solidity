// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract adminOnly{
  address public owner;
  uint public treasuryAmount;
  mapping(address=>uint) public withdrawlAllwoance;
  mapping(address=>bool) public hasWithdrawn;
  constructor(uint _treasuryAmount){
    owner=msg.sender;
    treasuryAmount=_treasuryAmount;
  }
  modifier onlyOwner{
    require(msg.sender==owner,"Only owner can call this function");
    _;
  }
  function addTreasure(uint _addAmount) public onlyOwner{
    treasuryAmount+=_addAmount;
  }
  function approveWithdrawl(address _user,uint _amount) public onlyOwner{
    require(_amount<=treasuryAmount,"exceeded maximum treasuryAmount");
    withdrawlAllwoance[_user]=_amount;
    hasWithdrawn[_user]=false;
  }
  function withdrawTreasure(uint _amount) public{
    if(msg.sender==owner){
      require(_amount<=treasuryAmount,"exceeded maximum treasuryAmount");
      treasuryAmount-=_amount;
  }
    else{
      require(withdrawlAllwoance[msg.sender]>=_amount,"insufficient allowance");
      require(withdrawlAllwoance[msg.sender]>0,"insufficient allowance");
      require(!hasWithdrawn[msg.sender],"you have already withdrawed");
      require(_amount<=treasuryAmount,"exceeded maximum treasuryAmount");
      withdrawlAllwoance[msg.sender]-=_amount;
      treasuryAmount-=_amount;
      hasWithdrawn[msg.sender]=true;
    }
  }
  function resetWithdrawlStatus(address _user) public onlyOwner{
    hasWithdrawn[_user]=false;
  }
  function transferOwnership(address _owner) public onlyOwner{
    require(_owner!=address(0),"invalid address");
    owner=_owner;
  }
}
