// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import { SimpleStorage } from "./SimpleStorage.sol";

//here the below contract AddFiveStorage is a child of SimpleStorage and it can use all the functions present inside it
// we inherit all the buttons as well
contract AddFiveStorage is SimpleStorage {
    // function sayHello() public pure returns (string memory) {
    //     return "Hello";
    // }

    // +5
    // overrides
    // virtual override

    //to make a function overrideable we must add the virtual keyword to the end
    function store(uint256 _newNumber) public override {
        myFavouriteNumber = _newNumber + 5;
    }
}