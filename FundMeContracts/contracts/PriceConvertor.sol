// SPDX-License-Identifier: MIT

//Libraries are similar to contracts with these 2 features
// 1. All functions are internal
// 2. No state variables are allowed

pragma solidity ^0.8.24;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


library PriceConvertor{
    function getPrice() internal view returns(uint256){
        //The `getPrice` function returns the current value of Ethereum in USD as a `uint256`.
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF); //change the address here too to deploy to zksync sepolia testnet
        (, int256 answer, , , ) = priceFeed.latestRoundData(); //destructuring with commas in eth
        //price of eth in terms of usd
        // ETH/USD rate in 18 digits -> * 10^10
        return uint256(answer * 1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256){
        // The `getConversionRate` function converts a specified amount of ETH to its USD equivalent.
        uint256 ethPrice = getPrice();
        //the product below has a precision of 36 so we divide by 10^18 to bring back the precision to 10^18
        uint256 ethAmountInUSD = ( ethPrice * ethAmount) / 1e18;
        return ethAmountInUSD;
        // Always multiply before dividing to maintain precision and avoid truncation errors in Solidity
    }

    function getVersion() internal view returns (uint256) {
        return AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF).version(); //this address will charge for each testnet

    }
}
