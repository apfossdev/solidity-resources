// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract FallbackExample {
    uint256 public result;

    //receive and fallback both must be external and payable
    receive() external payable { //no need of function keyword for receive function
        // whenever we send ETH to this contract, as long as there is no data associated with it, this RECEIVE function will get triggered
        result = 1;
    }

    fallback() external payable {
        result = 2; //with calldata low level instructions, then result will be 2
    }
}

// Ether is sent to contract
//      is msg.data empty?
//          /   \
//         yes  no
//         /     \
//    receive()?  fallback()
//     /   \
//   yes   no
//  /        \
//receive()  fallback()

