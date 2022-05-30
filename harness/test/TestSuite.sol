pragma solidity 0.5.4;
pragma experimental ABIEncoderV2;

import "openzeppelin-solidity/contracts/token/ERC20/IERC20.sol";
import "./Callable.sol";
import "./TestUtils.sol";
import "./TestAccount.sol";
import "./TestedToken.sol";


contract TestSuite {
    using TestUtils for Callable.CallResult;
    using TestedToken for address;
    using Callable for address;

    mapping(address => uint) public testResults;
    TestAccount[3] public testAccounts;

    bytes4[22] private testSignatures = [
        bytes4(keccak256(bytes("existenceTransferTest(address)"))),
        bytes4(keccak256(bytes("existenceApproveTest(address)"))),
        bytes4(keccak256(bytes("existenceTransferFromTest(address)"))),
        bytes4(keccak256(bytes("existenceAllowance(address)"))),
        bytes4(keccak256(bytes("existenceBalanceOf(address)"))),
        bytes4(keccak256(bytes("existenceTotalSupplyTest(address)"))),
        bytes4(keccak256(bytes("existenceName(address)"))),
        bytes4(keccak256(bytes("existenceSymbol(address)"))),
        bytes4(keccak256(bytes("existenceDecimals(address)"))),
        bytes4(keccak256(bytes("basicApproveTest(address)"))),
        bytes4(keccak256(bytes("approveZeroTokensTest(address)"))),
        bytes4(keccak256(bytes("allowanceRewriteTest(address)"))),
        bytes4(keccak256(bytes("basicTransferTest(address)"))),
        bytes4(keccak256(bytes("transferZeroTokensTest(address)"))),
        bytes4(keccak256(bytes("transferMoreThanBalanceTest(address)"))),
        bytes4(keccak256(bytes("basicTransferFromTest(address)"))),
        bytes4(keccak256(bytes("transferFromWithoutAllowanceTest(address)"))),
        bytes4(keccak256(bytes("transferFromNotFullAllowanceTest(address)"))),
        bytes4(keccak256(bytes("transferFromChangeAllowanceTest(address)"))),
        bytes4(keccak256(bytes("transferFromMoreThanAllowedTest(address)"))),
        bytes4(keccak256(bytes("transferFromOnBehalf(address)"))),
        bytes4(keccak256(bytes("transferFromLowFunds(address)")))
    ];

    modifier revertAfter() {
        _;
        TestUtils.returnAndRevert(true);
    }

    constructor() public {
        testAccounts[0] = new TestAccount();
        testAccounts[1] = new TestAccount();
        testAccounts[2] = new TestAccount();
    }

    function existenceTransferTest(address token) external revertAfter returns(bool) {

        testAccounts[0].transfer(testAccounts[1], 1000, token).expectTrue();
    }

    function existenceApproveTest(address token) external revertAfter returns(bool) {
        testAccounts[0].approve(testAccounts[1], 1000, token).expectTrue();
    }

    function existenceTransferFromTest(address token) external revertAfter returns(bool) {
        testAccounts[0].approve(testAccounts[1], 1000, token).expectTrue();
        testAccounts[1].transferFrom(testAccounts[0], testAccounts[1], 1000, token).expectTrue();
    }

    function existenceTotalSupplyTest(address token) external revertAfter returns(bool) {
        token.totalSupply().expectUInt();
    }

    function existenceBalanceOf(address token) external revertAfter returns(bool) {
        token.balanceOf(testAccounts[0]).expectUInt();
    }

    function existenceAllowance(address token) external revertAfter returns(bool) {
        token.allowance(testAccounts[0], testAccounts[1]).expectUInt();
    }

    function existenceName(address token) external revertAfter returns(bool) {
        token.name().expectNonEmptyResult();
    }

    function existenceSymbol(address token) external revertAfter returns(bool) {
        token.symbol().expectNonEmptyResult();
    }

    function existenceDecimals(address token) external revertAfter returns(bool) {
        uint tokenDecimals = token.decimals().toUInt();
        if (tokenDecimals >= 77) {
            TestUtils.returnAndRevert(false);
        }
    }

    function basicApproveTest(address token) external revertAfter returns(bool) {
        testAccounts[0].approve(testAccounts[1], 1000, token).expectTrue();
        token.allowance(testAccounts[0], testAccounts[1]).expectEqual(1000);
    }

    function approveZeroTokensTest(address token) external revertAfter returns(bool) {
        testAccounts[0].approve(testAccounts[1], 0, token).expectTrue();
        token.allowance(testAccounts[0], testAccounts[1]).expectEqual(0);
    }

    function allowanceRewriteTest(address token) external revertAfter returns(bool) {
        testAccounts[0].approve(testAccounts[1], 1000, token).expectTrue();
        token.allowance(testAccounts[0], testAccounts[1]).expectEqual(1000);
        testAccounts[0].approve(testAccounts[1], 2000, token).expectTrue();
        token.allowance(testAccounts[0], testAccounts[1]).expectEqual(2000);
    }

    function basicTransferTest(address token) external revertAfter returns(bool) {
        uint balance0Old = token.balanceOf(testAccounts[0]).toUInt();
        uint balance1Old = token.balanceOf(testAccounts[1]).toUInt();

        testAccounts[0].transfer(testAccounts[1], 1000, token).expectTrue();
        token.balanceOf(testAccounts[0]).expectEqual(balance0Old - 1000);
        token.balanceOf(testAccounts[1]).expectEqual(balance1Old + 1000);
    }

    function transferZeroTokensTest(address token) external revertAfter returns(bool) {
        uint balance0Old = token.balanceOf(testAccounts[0]).toUInt();
        uint balance1Old = token.balanceOf(testAccounts[1]).toUInt();

        testAccounts[0].transfer(testAccounts[1], 0, token).expectTrue();
        token.balanceOf(testAccounts[0]).expectEqual(balance0Old);
        token.balanceOf(testAccounts[1]).expectEqual(balance1Old);
    }

    function transferMoreThanBalanceTest(address token) external revertAfter returns(bool) {
        uint balance0Old = token.balanceOf(testAccounts[0]).toUInt();
        token.balanceOf(testAccounts[1]).toUInt();

        testAccounts[0].transfer(testAccounts[1], balance0Old + 1, token).expectRevert();
    }

    function basicTransferFromTest(address token) external revertAfter returns(bool) {
        uint balance0Old = token.balanceOf(testAccounts[0]).toUInt();
        uint balance1Old = token.balanceOf(testAccounts[1]).toUInt();

        testAccounts[0].approve(testAccounts[1], 1000, token).expectTrue();
        testAccounts[1].transferFrom(testAccounts[0], testAccounts[1], 1000, token).expectTrue();

        token.balanceOf(testAccounts[0]).expectEqual(balance0Old - 1000);
        token.balanceOf(testAccounts[1]).expectEqual(balance1Old + 1000);
        token.allowance(testAccounts[0], testAccounts[1]).expectEqual(0);
    }

    function transferFromWithoutAllowanceTest(address token) external revertAfter returns(bool) {
        testAccounts[0].approve(testAccounts[1], 0, token).expectTrue();
        token.balanceOf(testAccounts[0]).toUInt();
        token.balanceOf(testAccounts[1]).toUInt();

        testAccounts[1].transferFrom(testAccounts[0], testAccounts[1], 1, token).expectRevert();
    }

    function transferFromNotFullAllowanceTest(address token) external revertAfter returns(bool) {
        uint balance0Old = token.balanceOf(testAccounts[0]).toUInt();
        uint balance1Old = token.balanceOf(testAccounts[1]).toUInt();

        testAccounts[0].approve(testAccounts[1], 1000, token).expectTrue();
        testAccounts[1].transferFrom(testAccounts[0], testAccounts[1], 600, token).expectTrue();

        token.balanceOf(testAccounts[0]).expectEqual(balance0Old - 600);
        token.balanceOf(testAccounts[1]).expectEqual(balance1Old + 600);
        token.allowance(testAccounts[0], testAccounts[1]).expectEqual(400);
    }

    function transferFromMoreThanAllowedTest(address token) external revertAfter returns(bool) {
        testAccounts[0].approve(testAccounts[1], 600, token).expectTrue();
        token.balanceOf(testAccounts[0]).toUInt();
        token.balanceOf(testAccounts[1]).toUInt();

        testAccounts[1].transferFrom(testAccounts[0], testAccounts[1], 601, token).expectRevert();
    }

    function transferFromChangeAllowanceTest(address token) external revertAfter returns(bool) {
        testAccounts[0].approve(testAccounts[1], 1000, token).expectTrue();
        uint balance0Old = token.balanceOf(testAccounts[0]).toUInt();
        uint balance1Old = token.balanceOf(testAccounts[1]).toUInt();

        testAccounts[1].transferFrom(testAccounts[0], testAccounts[1], 600, token).expectTrue();
        token.balanceOf(testAccounts[0]).expectEqual(balance0Old - 600);
        token.balanceOf(testAccounts[1]).expectEqual(balance1Old + 600);

        testAccounts[0].approve(testAccounts[1], 0, token).expectTrue();
        testAccounts[1].transferFrom(testAccounts[0], testAccounts[1], 400, token).expectRevert();
    }

    function transferFromLowFunds(address token) external revertAfter returns(bool) {
        uint balance0 = token.balanceOf(testAccounts[0]).toUInt();
        testAccounts[0].approve(testAccounts[1], balance0 + 1, token).expectTrue();
        testAccounts[1].transferFrom(testAccounts[0], testAccounts[1], balance0 + 1, token).expectRevert();
    }

    function transferFromOnBehalf(address token) external revertAfter returns(bool) {
        uint balance0Old = token.balanceOf(testAccounts[0]).toUInt();
        uint balance1Old = token.balanceOf(testAccounts[1]).toUInt();
        uint balance2Old = token.balanceOf(testAccounts[2]).toUInt();

        testAccounts[0].approve(testAccounts[2], 1000, token).expectTrue();
        testAccounts[2].transferFrom(testAccounts[0], testAccounts[1], 1000, token).expectTrue();
        token.allowance(testAccounts[0], testAccounts[2]).expectEqual(0);
        token.balanceOf(testAccounts[0]).expectEqual(balance0Old - 1000);
        token.balanceOf(testAccounts[1]).expectEqual(balance1Old + 1000);
        token.balanceOf(testAccounts[2]).expectEqual(balance2Old);
    }

    function callTest(uint testNum, address token) internal returns(bool) {
        bytes memory payload = abi.encodeWithSelector(testSignatures[testNum], token);
        return address(this).makeCall(payload).toBool();
    }

    function runTests(address token, address customer) external returns(uint) {
        require(msg.sender == address(this), "use check() function to run tests");
        IERC20(token).transferFrom(customer, address(testAccounts[0]), 1000);

        // run tests
        uint testsPassed = 1;  // make the least bit equal to 1 to point out tests were run
        uint totalTests = testSignatures.length;
        for (uint testNum = 0; testNum < totalTests; ++testNum) {
            // call test
            bool testResult = callTest(testNum, token);
            // decode result and save
            if (testResult) {
                testsPassed += 1<<(testNum+1);
            }
        }

        // return testsPassed and revert
        assembly {
             let memOffset := mload(0x40)
             mstore(memOffset, testsPassed)
             mstore(0x40, add(memOffset, 32))
             revert(memOffset, 32)
        }
    }

    function check(address token) external returns(uint) {
        testResults[token] = 1;  // make the least bit equal to 1 to point out tests were run
        bytes memory payload = abi.encodeWithSignature("runTests(address,address)", token, msg.sender);
        Callable.CallResult memory callResult = address(this).makeCall(payload);
        if (callResult.data.length != 32) {
            return 1;
        }
        uint testsPassed = abi.decode(callResult.data, (uint));
        if (testsPassed <= 1) {
            return 1;
        }
        testResults[token] = testsPassed;
        return testsPassed;
    }
}