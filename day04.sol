// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract auctionhouse{
  address owner;
  uint endtime;
  bool isend;
  uint public highestbid;
  address public highestbidder;
  string item;
  address[] public bidder;
  mapping(address=>uint) public bidamount;
  constructor(string memory _item,uint _biddingtime){
  owner=msg.sender;
  endtime=block.timestamp+_biddingtime;
  item=_item;
  isend=false;
}
  function bid(uint amount)external{
  require(block.timestamp < endtime, "Auction is ended.");
  require(!isend,"auction is ended");
  require(amount>0,"bid amount is not supported");
  require(msg.sender!=owner,"you are owner");
  require(amount>bidamount[msg.sender],"bid amount must be larger than the previous bid");
  if(bidamount[msg.sender]==0){
    bidder.push(msg.sender);
  }
  bidamount[msg.sender]=amount;
  if(bidamount[msg.sender]>highestbid){
    highestbidder=msg.sender;
    highestbid=amount;
  }
  }
  function endauction() public{
  require(block.timestamp < endtime, "Auction was ended");
  require(!isend,"auction was already been ended");
  require(msg.sender==owner,"you don't have the permission to end this auction");
  isend=true;
  }
}
