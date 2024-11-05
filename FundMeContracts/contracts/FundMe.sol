// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { PriceConvertor } from "./PriceConvertor.sol";

// if we compile the interface we will get the required abi of the contract address required below
// interface AggregatorV3Interface {
//   function decimals() external view returns (uint8);

//   function description() external view returns (string memory);

//   function version() external view returns (uint256);

//   function getRoundData(
//     uint80 _roundId
//   ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

//   function latestRoundData()
//     external
//     view
//     returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
// }

error NotOwner(); //custom errors to save gas compared to storing and responding with error strings

contract FundMe {
    // Contract should receive funds
    // Withdraw funds to the owner address of the contract
    // Set a minimum donation value in USD

    // uint256 public myValue = 1; 

    using PriceConvertor for uint256; //this is how we use the library on all uint256, implementation below

    uint256 public constant MINIMUM_USD = 5e18; //as the getConversionRate value has a precision of 10^18;
    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded; //mapping to easily access which address sent how much in the future
    //funder and amountFunded are just syntactic sugar have no real meaning here

    //we setup this constructor so that an owner address variable is created
    //and this constructor initializes whoever deploys this contract
    //i.e. the msg.sender to be the owner
    //so that only he can withdraw the funds
    address public immutable i_owner;
    constructor() {
        i_owner = msg.sender;
    }


    function fund() public payable{         

        //allow users to send monie to contract -> makes the function payable (able to receive eth now)
        //have a minimum usd funding value $5
        //how do we send eth to this contract
        
        // for minimum usd funding value, we use a checker like below, if not satisfied condition the function exits with the checker default msg on the right
        // myValue = myValue + 2;
        // require(msg.value > 1e18, "didn't send minimum amount of 1 ETH"); //1e18 = 1eth = 10^18 wei
        // a ton of computation

        //in the above section, if the txn is reverted it undoes whatever is done previously and refunds the gas to the party who initiated the txn
        //but you will spend some gas if you send reverted txns

        //what is a revert?
        //undoes any action that have been done, and sends the remaining gas back
        //like above the myValue variable if the function below is reverted continues to remain at 1 or the prev. value, this is called as reverting
        //yes failed txns do use up gas, so we can set a gas limit

        // msg.value.getConversionRate(); //here as msg.value is a uint256(as the type parameter in the library for getConversionRate() is also uint256) it is passed to the getConversionRate no need to write the variable inside the brackets
        // require(getConversionRate(msg.value) >= minimumUSD, "didn't send >= $5 USD"); //msg.value is in eth
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send >= $5 USD"); //msg.value is in eth
        funders.push(msg.sender); //this is to push all the addresses of the fund senders into an address array
        addressToAmountFunded[msg.sender] += msg.value; //how much amount is being funded here is added to the key
    }


    function withdraw() onlyOwner public {
       
       //so that only the owner is able to withdraw the funds by using this function else will exit right away
       // require(msg.sender == owner, "Must be owner!");
       // for loop

        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex]; //get the funder's address from the funders array
            addressToAmountFunded[funder] = 0; //we set this mapping to 0 as we are going to withdraw all the funds sent by this particular address
        }
        //reset the array -> here we'll create a new array itself to do this
        funders = new address [](0); //here we reset the array with this syntax 
        
        //withdraw the funds
        // 3 ways
        // transfer (2300 gas, throws error)
        // msg.sender -> address type
        // payable(msg.sender) -> payable address type for transfers
        //(this) refers to the entire contract FundMe and this.balance refers to the eth balance of the entire contract
        payable(msg.sender).transfer(address(this).balance);
        // send (2300 gas, returns bool, wont error but will return a bool whether successful or not)
        bool sendSuccess = payable(msg.sender).send(address(this).balance);
        require(sendSuccess, "Send failed");
        // call (very powerful, can call any function in eth without even their abi)
        // it returns two variables destructured below
        (bool callSuccess, /**bytes memory dataReturned, no need of this now so just leave the comma**/) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call failed");
        // call is by far the best/recommended method to send/receive transactions
    }

    // what if you want to require to be owner in many more functions and not just one
    // thats where function modifier come into play
    // define it at the end like this and use it by placing the name of the function modifier
    // in the function which you want that check to occur
    modifier onlyOwner(){
        // require(msg.sender == i_owner, "Sender is not owner!");
        if(msg.sender != i_owner) { revert NotOwner(); }
        _; //special syntax for functionmodifier
    }
    // need not set visibility for modifiers as well as they aren't functions 

    // what happens if someone sends this contract eth without calling the fund function?
    receive() external payable {
        fund(); //now it will automatically route them to fund if no calldata and doesn't click fund and sends eth
    }

    fallback() external payable {
        fund();//now it will automatically route them to fund if there is calldata too and doesn't click fund and sends eth

    }
    // receive() and fallback()

}