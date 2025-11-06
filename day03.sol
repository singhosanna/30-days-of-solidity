// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract pollstation{
  string[] public candidates;
  mapping(string => uint) public votes;
  function addCandidate(string memory _candidates) public {
    candidates.push(_candidates);
    votes[_candidates]=0;
  }
  function vote(string memory _candidate) public {
    votes[_candidate]++;
  }
}
