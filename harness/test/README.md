## Test design

The project relies on two EVM bytecode features:

1. One contract can call another via `call()` function. If internal transaction fails, it does not revert the main one.
2. Internal transactions can revert and return value at the same time.

TestSuite uses these tricks 
- to revert any token state changes caused by performed tests
- to recover possible failures due to token contract issues
- to test if token functions revert when they should

TestSuite runs every test in isolated manner.  It invokes every test case using low-level `call()` and checks if the internal transaction was successful and what did it return. Results of all performed tests are written to storage.

## Project architecture
The project includes the following smart contracts.

##### TestSuite
This smart contract contains all test cases.
It has `check(address token)` function that works as entry point and invokes all tests.

##### Callable
Other contracts use this library to make low-level calls. 
It converts results of those calls to `CallResult` struct.

##### TestedToken
This library wraps the following ERC20 functions:
- `balanceOf()`
- `totalSupply()`
- `allowance()`
- `name()`
- `symbol()`
- `decimals()`

It uses `Callable` library to convert results to `CallResult` struct.
`TestSuite` contract uses this library in test cases.

##### TestAccount
This smart contract behaves as token user and proxies all `transfer()`, `transferFrom()` and `approve()` functions to token.

##### TestUtils
This library checks if `CallResult` struct matches expected value.


## Test results representation

To reduce gas consumption results of every test case are stored as a single bit.  All results fit in a single storage slot. Inside that slot the smallest bit (i.e. 2^0) indicates whether tests were run at least once. Other bits correspond to the test cases. Each bit indicates whether the test has passed (1 means success).

The table below maps the test cases to the bits.

| test case                        | bit index    | test passed if                    |
|----------------------------------|--------------|-----------------------------------|
| existenceTransferTest            | 1            | test_result & 2^1 != 0            |
| existenceApproveTest             | 2            | test_result & 2^2 != 0            |
| existenceTransferFromTest        | 3            | test_result & 2^3 != 0            |
| existenceAllowance               | 4            | test_result & 2^4 != 0            |
| existenceBalanceOf               | 5            | test_result & 2^5 != 0            |
| existenceTotalSupplyTest         | 6            | test_result & 2^6 != 0            |
| existenceName                    | 7            | test_result & 2^7 != 0            |
| existenceSymbol                  | 8            | test_result & 2^8 != 0            |
| existenceDecimals                | 9            | test_result & 2^9 != 0            |
| basicApproveTest                 | 10           | test_result & 2^10 != 0           |
| approveZeroTokensTest            | 11           | test_result & 2^11 != 0           |
| allowanceRewriteTest             | 12           | test_result & 2^12 != 0           |
| basicTransferTest                | 13           | test_result & 2^13 != 0           |
| transferZeroTokensTest           | 14           | test_result & 2^14 != 0           |
| transferMoreThanBalanceTest      | 15           | test_result & 2^15 != 0           |
| basicTransferFromTest            | 16           | test_result & 2^16 != 0           |
| transferFromWithoutAllowanceTest | 17           | test_result & 2^17 != 0           |
| transferFromNotFullAllowanceTest | 18           | test_result & 2^18 != 0           |
| transferFromChangeAllowanceTest  | 19           | test_result & 2^19 != 0           |
| transferFromMoreThanAllowedTest  | 20           | test_result & 2^20 != 0           |
| transferFromOnBehalf             | 21           | test_result & 2^21 != 0           |
| transferFromLowFunds             | 22           | test_result & 2^22 != 0           |

That means, if the test result is equal to 11, token was tested and only tests with indexes 1 and 3 succeeded (since 2^0 + 2^1 + 2^3 = 11).
