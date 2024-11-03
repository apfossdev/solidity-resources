// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { SimpleStorage } from "./SimpleStorage.sol"; 

contract StorageFactory {

    // uint256 public favouriteNumber
    //type visibility name 
    // as struct keyword allows us to create new personal types
    // similarly here the contract keyword SimpleStorage automatically identifies itself to a contract type
    // here we are creating a new contract variable simpleStorage from the og SimpleStorage contract
    // SimpleStorage public simpleStorage;
    SimpleStorage[] public listOfSimpleStorageContracts;
    // address[] public listOfSimpleStorageAddresses;

    function createSimpleStorageContract() public {
        // Howdoes the storage factory know what the simple storage contract looks like?
        // simpleStorage = new SimpleStorage(); //now we have deployed a contract from another contract; it is a new contract instance of SimpleStorage allowing you to interact with the simpleStorage variable
        // the above is only reassignment as it was already declared above in the comments above this function
        SimpleStorage newSimpleStorageContract = new SimpleStorage();
        listOfSimpleStorageContracts.push(newSimpleStorageContract);
    }

    //how to call different functions from other contracts here
    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        // Address
        // ABI - Application Binary Interface
        // we need the above 2 to interact with other conttact's functions
        // SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];
        // mySimpleStorage.store(_newSimpleStorageNumber); //this function when given the index, it just stores the a number to the simpleStorageContracts from the list in the SimpleStorage variable
        // the above 2 lines is replaced by this 
        listOfSimpleStorageContracts[_simpleStorageIndex].store(_newSimpleStorageNumber); 
        //so here it does this address: numberGivenAsArgument
        // SimpleStorage mySimpleStorage = SimpleStorage(listOfSimpleStorageContracts[_simpleStorageIndex]); //typecasting it to SimpleStorage
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256){
        // SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];
        // return mySimpleStorage.retrieve(); //this function when given the simpleStorageIndex returns the number stored to the contract address stored in the list
        //above is the same as below functionality in one line
        return listOfSimpleStorageContracts[_simpleStorageIndex].retrieve();
    }
}