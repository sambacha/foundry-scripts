// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "ds-test/test.sol";
import "./TypeConverts.sol";

contract TypeConvertsTest is DSTest, TypeConverts {
    function setUp() public {
        // Tested contract is inherited
    }

    function test_addressConvert() public {
        address test_address = 0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619;
        emit log_address(test_address);

        string memory out = addressToString(test_address);
        emit log_string(out);

        assertEq(out, "0x7ceb23fd6bc0add59e62ac25578270cff1b9f619");
    }
}
