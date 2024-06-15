// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;
import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter{

    function getPrice()  internal view returns (uint256)
    {
        AggregatorV3Interface pricefeed = AggregatorV3Interface(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43);
        (,int256 price,,,)=pricefeed.latestRoundData();
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethamount)  internal  view returns (uint256)
    {
        uint256 ethPrice= getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethamount)/ 1e18;
        return ethAmountInUsd;
    }

    function getVersion()  internal  view returns (uint256){
        return AggregatorV3Interface(0x1b44F3514812d835EB1BDB0acB33d3fA3351Ee43).version();
    }

}
