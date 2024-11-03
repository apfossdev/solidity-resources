// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

contract SimpleStorage {
    uint256 myFavouriteNumber;

    struct Person {
        uint256 favouriteNumber;
        string name;
    }
    
    Person[] public listOfPeople;

    mapping(string => uint256) public nameToFavouriteNumber;

    function store(uint256 _favouriteNumber) public virtual {
        myFavouriteNumber = _favouriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return myFavouriteNumber;
    }

    function addPerson(string memory _name, uint256 _favouriteNumber) public {
        listOfPeople.push(Person(_favouriteNumber, _name));
        nameToFavouriteNumber[_name] = _favouriteNumber;
    }
}

contract SimpleStorage2 {}
contract SimpleStorage3 {}
contract SimpleStorage4 {}
//there is a syntax to only import a specific contract from such files with multiple contracts to save execution time