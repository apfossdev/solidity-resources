// SPDX-License-Identifier: MIT
pragma solidity 0.8.24; //stating our version of solidity

//similar to Class in OOPS
contract SimpleStorage {
    //Basic types: boolean, uint(unsigned whole number), int(signed number), address, bytes
    // bool hasFavouriteNumber = false;
    // uint256 favouriteNumber = 88; //can specify the number of bits used, the default for uint and max. is 256 bits, but be explicit as much as possible
    // string favouriteNumberInText = "eighty-eight"; //string is in double quotes
    // int256 favouriteInt = -88;
    // address myAddress = 0xD1f6Ca8adE0962A6b172c4c03ae088329d9FdD9f;
    // bytes32 favouriteBytes32 = "cat"; //strings are specifically byte objects for text, so they can easily be converted to each other, bytes32 is the largest and bytes and bytes32 are not the same unlike 
    // each of the types have a default value like 0, false and etc;

    uint256 myFavouriteNumber; //0; public changes the visibility of this variable making it visible to everyone, the default is internal
    // here the above is a storage variable without needing to mention it explicitly as it is defined globally

    // uint256[] listOfFavouriteNumbers; // [0, 78, 99], 0 indexed

    // create own custom types using struct keyword
    struct Person{
        uint256 favouriteNumber;
        string name;
    }

    //dynamic array
    Person[] public listOfPeople; // []

    //key value pairs like a dictionary for easy access
    mapping(string => uint256) public nameToFavouriteNumber;

    //static array
    // Person[3] public listOfPeople; // [] at max 3 elements only


    // Person public pat = Person({favouriteNumber: 7, name: "Pat"});
    // Person public mariah = Person({favouriteNumber: 16, name: "Mariah"});
    // Person public jon = Person({favouriteNumber: 12, name: "Jon"});

    function store(uint256 _favouriteNumber) public {
        myFavouriteNumber = _favouriteNumber;
        // uint256 testVar = 5;
    }

    //view (it just reads and doesn't update and we don't need to send a transaction, hence blue and not orange), 
    // pure (view + and doesn't all to read from a state
    // both of these types of functions don't use any gas
    function retrieve() public view returns(uint256){
        return myFavouriteNumber;
    } //but this does cause gas as a gas using function calls it

    // function something() public {
    //     testVar = 6; //functional variables, it can;t
    //     favouriteNumber = 7; //global variable, it can access
    // }

    // calldata, memory, storage
    // calldata and memory that the variable is going to exist only during the function call and will be deleted from existence beyond it 
    // most of the types variables default to memory
    // strings are special so we need to explicitly mention whether memory or calldata
    // the diff b/w calldata and memory variables is that
    // memory variables can be changed/ manipulated inside the function
    // calldata variables can't be changed inside the function
    // while storage is a permanent variable that can be modified

    // data location must be explicitly specified for arrays, mappings and struct (and strings) as they are NOT PRIMIMITIVE TYPES
    //For Primitive Types, no need to mention the data location, the compiler is smart enough to allocate them automatically
    // Also in the function parameters, we can't declare it as storage as it has got to be a temporary variable, as it will be destroyed once the function call is done
    function addPerson(string memory _name, uint256 _favouriteNumber) public {
        // Person memory newPerson = Person (_favouriteNumber, _name); can use this as well for below work
        // _name = "cat";
        listOfPeople.push( Person(_favouriteNumber, _name) );
        nameToFavouriteNumber[_name] = _favouriteNumber; //this is saying that anytime you look up the name of the person in this function by entering their name, you will automatically get their favourite number back, here inside the square brakets there is the key
    } 


    // 0xd9145CCE52D386f254917e481eB44e9943F39138 - this contract's address

    //input bytecode 0x608060405234801561001057600080fd5b5060e38061001f6000396000f3fe6080604052348015600f57600080fd5b506004361060285760003560e01c80636057361d14602d575b600080fd5b60436004803603810190603f91906085565b6045565b005b8060008190555050565b600080fd5b6000819050919050565b6065816054565b8114606f57600080fd5b50565b600081359050607f81605e565b92915050565b6000602082840312156098576097604f565b5b600060a4848285016072565b9150509291505056fea264697066735822122035d3c6191330c56b474109858eae5a11e3aaf32a71288522e32e07f11bd8da6764736f6c63430008130033

}