// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.10;

/// @title Hevm

interface Hevm {
    // Set block.timestamp (newTimestamp)
   function warp(uint256 x) external;

    // Set block.height (newHeight)
    function roll(uint256 x) external;

    // Set block.basefee (newBasefee)
    function fee(uint256) external;

    // Stores a value to an address' storage slot, (who, slot, value)
   function store(address c,bytes32 loc,bytes32 val) external;

    // Loads a storage slot from an address (who, slot)
   function load(address c,bytes32 loc) external returns (bytes32 val);


    // Signs data, (privateKey, digest) => (r, v, s)
   function sign(uint256 sk,bytes32 digest) external returns (uint8 v, bytes32 r, bytes32 s);


    // Gets address for a given private key, (privateKey) => (address)
   function addr(uint256 sk) external returns (address addr);

    // Performs a foreign function call via terminal, (stringInputs) => (result)
   function ffi(string[] calldata) external returns (bytes memory);


    // Sets the *next* call's msg.sender to be the input address
    function prank(address) external;

    // Sets all subsequent calls' msg.sender to be the input address until `stopPrank` is called
    function startPrank(address) external;

    // Resets subsequent calls' msg.sender to be `address(this)`
    function stopPrank() external;

    // Sets an address' balance, (who, newBalance)
    function deal(address, uint256) external;

    // Sets an address' code, (who, newCode)
    function etch(address, bytes calldata) external;

    // Expects an error on next call
    function expectRevert(bytes calldata) external;

    // Expects an event on next call
    function expectEmit(
        bool,
        bool,
        bool,
        bool
    ) external;

    // Record all storage reads and writes
    function record() external;

    // Gets all accessed reads and write slot from a recording session, for a given address
    function accesses(address)
        external
        returns (bytes32[] memory reads, bytes32[] memory writes);
}

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.
