// SPDX-License-Identifier: BSD-3-Clause
pragma solidity ^0.8.10;

import "https://github.com/LogETH/compound-protocol/blob/master/contracts/CToken.sol";

contract PriceOracle {
    /// @notice Indicator that this is a PriceOracle contract (for inspection)
    bool public constant isPriceOracle = true;

    mapping(CToken => OracleProxy) public Oracall;

    /**
      * @notice Get the underlying price of a cToken asset
      * @param cToken The cToken to get the underlying price of
      * @return The underlying asset price mantissa (scaled by 1e18).
      *  Zero means the price is unavailable.
      */
    function getUnderlyingPrice(CToken cToken) virtual external view returns (uint){

        return Oracall[cToken].getPrice();
    }

    function addOracle(CToken cToken, OracleProxy oracleAddress) public {

        Oracall[cToken] = oracleAddress;
    }

//    0xaed0c38402a5d19df6e4c03f4e2dced6e29c1ee9
}

interface OracleProxy{

    // Chainlink Dev Docs https://docs.chain.link/docs/
    function getPrice() external view returns (uint);
}
