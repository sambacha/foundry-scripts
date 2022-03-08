// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "./IHevm.sol";

contract TokenCheats is DSTest {
    Hevm hevm = Hevm(0x7109709ECfa91a80626fF3989D68f67F5b1DD12D);

    // Gives an arbitrary amount of specified ERC20 token to arbitrary address

    // Stolen shamelessly from https://github.com/makerdao/spells-kovan/blob/d16a34a8ad2b98c44f344968a01b1373b1a022fa/archive/2021-03-11-AddETHC.t.sol#L939
    function giveTokens(
        address recipient,
        IERC20 token,
        uint256 amount
    ) internal {
        // Edge case - balance is already set for some reason
        if (token.balanceOf(recipient) == amount) return;

        for (int256 i = 0; i < 100; i++) {
            // Scan the storage for the balance storage slot
            bytes32 prevValue = hevm.load(
                address(token),
                keccak256(abi.encode(recipient, uint256(i)))
            );
            hevm.store(
                address(token),
                keccak256(abi.encode(recipient, uint256(i))),
                bytes32(amount)
            );
            if (token.balanceOf(recipient) == amount) {
                // Found it
                return;
            } else {
                // Keep going after restoring the original value
                hevm.store(address(token), keccak256(abi.encode(recipient, uint256(i))), prevValue);
            }
        }

        // We have failed if we reach here
        assertTrue(false);
    }
}
