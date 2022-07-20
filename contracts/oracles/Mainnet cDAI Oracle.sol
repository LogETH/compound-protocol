// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.10;

import "https://github.com/LogETH/compound-protocol/blob/master/contracts/CToken.sol";

contract DAIOracleProxy {
    /// @notice Indicator that this is a PriceOracle contract (for inspection)
    bool public constant isPriceOracle = true;

    Oracle DAIUSD = Oracle(0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9); // Mainnet DAIUSD
    cToken cDAI;


    function getPrice() virtual external view returns (uint){

        (,int price,,,) = DAIUSD.latestRoundData();

        return (uint(price)*cDAI.exchangeRateCurrent())/10e6;
    }

}

interface Oracle{

    // Chainlink Dev Docs https://docs.chain.link/docs/
    function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}

interface cToken{
    
    function exchangeRateCurrent() external view returns (uint256);
}
