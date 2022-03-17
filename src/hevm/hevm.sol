/// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity >=0.8.4;

/// @title Hevm
interface Hevm {
    // Set block.timestamp (newTimestamp)
    function warp(uint256) external;

    /// @notice Set block.height (newHeight)
    function roll(uint256) external;

    /// @notice Loads a storage slot from an address (who, slot)
    function load(address, bytes32) external returns (bytes32);

    /// @notice Stores a value to an address' storage slot, (who, slot, value)
    function store(
        address,
        bytes32,
        bytes32
    ) external;

    /// @notice Signs data, (privateKey, digest) => (r, v, s)
    function sign(uint256, bytes32)
        external
        returns (
            uint8,
            bytes32,
            bytes32
        );

    // Gets address for a given private key, (privateKey) => (address)
    function addr(uint256) external returns (address);

    // Performs a foreign function call via terminal, (stringInputs) => (result)
    function ffi(string[] calldata) external returns (bytes memory);

    /// @notice Calls another contract with a specified `msg.sender`, (newSender, contract, input) => (success, returnData)
    function prank(
        address,
        address,
        bytes calldata
    ) external payable returns (bool, bytes memory);

    /// @notice Sets an address' balance, (who, newBalance)
    function deal(address, uint256) external;

    // Sets an address' code, (who, newCode)
    function etch(address, bytes calldata) external;

    // Expects an error on next call
    function expectRevert(bytes calldata) external;
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