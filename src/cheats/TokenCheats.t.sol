// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";

import "./TokenCheats.sol";

contract TokenCheatsTest is DSTest, TokenCheats {
    TokenCheats tc;
    // NOTE: Address is for polygon DAI
    IERC20 DAI = IERC20(0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063);
    IERC20 WMATIC = IERC20(0x0d500B1d8E8eF31E21C99d1Db9A6444d3ADf1270);
    IERC20 USDC = IERC20(0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174);

    IERC20[] testTokens = [DAI, WMATIC, USDC];

    function setUp() public {
        // Tested contract is inherited
    }

    function test_tokenCheats() public {
        IERC20 currToken;

        for (uint256 i = 0; i < testTokens.length; i++) {
            currToken = testTokens[i];
            assertEq(currToken.balanceOf(address(this)), 0);

            giveTokens(address(this), currToken, 100 ether);
            assertEq(currToken.balanceOf(address(this)), 100 ether);

            currToken.transfer(0xBdEf5Ac3144deAeb9df6F56e86b0AD9C2dBDE530, 10 ether);
            assertEq(currToken.balanceOf(address(this)), 90 ether);
        }
    }
}
