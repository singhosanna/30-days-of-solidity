// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract auctionhouse{
  address owner;
  uint highestbid;
  address highestbidder;
  uint endtime;
  bool isended;
  string item;
  address[] public bidders;
  mapping(address=>uint) public bids;
  constructor(string memory _item,uint _biddingtime){
    owner=msg.sender;
    item=_item;
    endtime=block.timestamp+_biddingtime;
  }
  function bid(uint amount) external{
    require(block.timestamp<endtime,"auction has ended");
    require(amount>highestbid,"you need to bid higher");
    require(msg.sender!=owner,"owner cannot bid");
    require(msg.sender!=highestbidder,"you are already the highest bidder");
    if(bids[msg.sender]==0){
      bidders.push(msg.sender);
    }
    bids[msg.sender]=amount;
    if(amount>highestbid){
      highestbid=amount;
      highestbidder=msg.sender;
    }
  }
  function endauction()external{
    require(block.timestamp>endtime,"auction hasn't ended");
    require(!isended,"auction is ended");
    isended=true;
  }
  }
