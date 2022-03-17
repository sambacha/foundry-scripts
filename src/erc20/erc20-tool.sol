// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ----------------------------------------------------------------------------
//
// TokenToolz.sol
//
// <https://github.com/bokkypoobah/TokenToolz>
// (c) BokkyPooBah / Bok Consulting Pty Ltd 2021. The MIT Licence.
// ----------------------------------------------------------------------------

/// @notice ERC20 https://eips.ethereum.org/EIPS/eip-20 with optional symbol, name and decimals
interface ERC20 {
    event Transfer(address indexed from, address indexed to, uint tokens);
    event Approval(address indexed tokenOwner, address indexed spender, uint tokens);

    function totalSupply() external view returns (uint);
    function balanceOf(address tokenOwner) external view returns (uint balance);
    function allowance(address tokenOwner, address spender) external view returns (uint remaining);
    function transfer(address to, uint tokens) external returns (bool success);
    function approve(address spender, uint tokens) external returns (bool success);
    function transferFrom(address from, address to, uint tokens) external returns (bool success);

    function symbol() external view returns (string memory);
    function name() external view returns (string memory);
    function decimals() external view returns (uint8);
}

contract TokenToolz {
    function getTokenInfo(ERC20 token, address tokenOwner, address spender) public view returns (uint _decimals, uint _totalSupply, uint _balance, uint _allowance, string memory _symbol, string memory _name) {
        if (address(token) == address(0)) {
            return (18, 0, tokenOwner.balance, 0, "ETH", "Ether");
        } else {
            try token.symbol() returns (string memory s) {
                _symbol = s;
            } catch {
                _symbol = "(null)";
            }
            try token.name() returns (string memory n) {
                _name = n;
            } catch {
                _name = "(null)";
            }
            try token.decimals() returns (uint8 d) {
                _decimals = d;
            } catch {
                _decimals = 0xff;
            }
            (_totalSupply, _balance, _allowance) = (token.totalSupply(), token.balanceOf(tokenOwner), token.allowance(tokenOwner, spender));
        }
    }

    function getTokensInfo(ERC20[] memory tokens, address tokenOwner, address spender) public view returns (uint[] memory totalSupply, uint[] memory balance, uint[] memory allowance) {
        totalSupply = new uint[](tokens.length);
        balance = new uint[](tokens.length);
        allowance = new uint[](tokens.length);
        for (uint i = 0; i < tokens.length; i++) {
            try tokens[i].totalSupply() returns (uint ts) {
                totalSupply[i] = ts;
            } catch {
                totalSupply[i] = 0;
            }
            try tokens[i].balanceOf(tokenOwner) returns (uint b) {
                balance[i] = b;
            } catch {
                balance[i] = 0;
            }
            try tokens[i].allowance(tokenOwner, spender) returns (uint a) {
                allowance[i] = a;
            } catch {
                allowance[i] = 0;
            }
        }
    }
}
