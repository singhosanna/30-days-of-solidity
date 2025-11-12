// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract EtherPiggyBank{
  address public bankManager;
  address [] users;
  mapping(address => bool)  isRegistered;
  mapping(address => uint)  bankBalance;
  constructor(){
    bankManager=msg.sender;
    users.push(msg.sender);
    isRegistered[msg.sender]=true;
  }
  modifier onlyManager(){
    require(msg.sender==bankManager,"You are not the bank manager");
    _;
  }
  function addUser(address _user) public onlyManager{
    require(!isRegistered[_user],"User already registered");
    users.push(_user);
    isRegistered[_user]=true;
  }
  function deposit(uint _amount) public{
    require(isRegistered[msg.sender],"User not registered");
    require(_amount > 0,"syntax error");
    bankBalance[msg.sender]+=_amount;
  }
  function depositETH() payable public{
    require(isRegistered[msg.sender],"User not registered");
    require(msg.value > 0,"syntax error");
    bankBalance[msg.sender]+=msg.value;
  }
  function withdraw(uint _amount) public{
    require(isRegistered[msg.sender],"User not registered");
    require(_amount > 0,"syntax error");
    require(bankBalance[msg.sender]>=_amount,"Insufficient balance");
    bankBalance[msg.sender]-=_amount;
  }
  function getBalance() public view returns(uint){
    return bankBalance[msg.sender];
  }
  function getUsers() public view returns(address[] memory){
    return users;
  }
}
