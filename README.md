# `foundry-scripts`

> Shell Utilities and Aggregated Testing Contract Bundles

## Command Line

| $CMD            	| Type 	|                 Alias                	|                                                                                                         Description 	|
|-----------------	|------	|:------------------------------------:	|--------------------------------------------------------------------------------------------------------------------:	|
| bind            	|      	|       opts= "-c -r -o -d -w -h"      	|                                                                     Generate rust bindings for your smart contracts 	|
| build           	|      	|                                      	|                                                                                          Build your smart contracts 	|
| clean           	|      	|                                      	|                                                                   Removes the build artifacts and cache directories 	|
| completions     	|      	|                                      	|                                                                                   Generate shell completions script 	|
| config          	|      	|    opts= "-c -r -o -d -w -f -v -h:   	|                                                                               Shows the currently set config values 	|
| create          	|      	| opts= "-c -r -o -d -w -f -i -l -t -h 	|                                                                                          Deploy a compiled contract 	|
| flatten         	|      	|          opts= "-o -c -r -h"         	|                                                                              Concats a file with all of its imports 	|
| help            	|      	|                                      	|                                                           Print this message or the help of the given subcommand(s) 	|
| init            	|      	|           opts= "-t -q -h"           	|                                                                              Initializes a new forge sample project 	|
| inspect         	|      	|                                      	|                                                        Outputs a contract in a specified format (ir, assembly, ...) 	|
| install         	|      	|                                      	| Installs one or more dependencies as git submodules (will install existing dependencies if no arguments	are	provided) 	|
| remappings      	|      	|                                      	|                                                    Prints the automatically inferred remappings for this repository 	|
| remove          	|      	|                                      	|                                                                Removes one or more dependencies from git submodules 	|
| run             	|      	|                                      	|                                                                             Run a single smart contract as a script 	|
| snapshot        	|      	|                                      	|                                                                         Creates a snapshot of each test's gas usage 	|
| test            	|      	|                                      	|                                                                                           Test your smart contracts 	|
| tree            	|      	|                                      	|                                                      Display a tree visualization of the project's dependency graph 	|
| update          	|      	|                                      	|                                                                                    Fetches all upstream lib changes 	|
| verify-check    	|      	|                                      	|                                     Check verification status on Etherscan. Requires `ETHERSCAN_API_KEY` to be set. 	|
| verify-contract 	|      	|           opts= "-c -r -h"           	|                       Verify your smart contracts source code on Etherscan. Requires `ETHERSCAN_API_KEY` to be set. 	|


## Contracts

### `assertRevert`

```solidity

    function assertRevert(function() external payable) public {
        revert();
    }

    /**
     * @notice Asserts that the given function call fails with the given error message.
     */
    function assertRevert(function() external payable, bytes32 _errorMessage) public {
        revert();
    }

    /**
     * @notice Asserts that the given function call fails with the given error message.
     */
    function assertRevert(function() external payable, bytes32 _errorMessage, bytes32 _errorData) public {
        revert();
    }
```

## `ds-test`

> methods

### IS_TEST

```solidity
function IS_TEST() external view returns (bool)
```


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### failed

```solidity
function failed() external view returns (bool)
```


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |## Events

### log

```solidity
event log(string)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0  | string | undefined |

### log_address

```solidity
event log_address(address)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0  | address | undefined |

### log_bytes

```solidity
event log_bytes(bytes)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0  | bytes | undefined |

### log_bytes32

```solidity
event log_bytes32(bytes32)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0  | bytes32 | undefined |

### log_int

```solidity
event log_int(int256)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0  | int256 | undefined |

### log_named_address

```solidity
event log_named_address(string key, address val)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| key  | string | undefined |
| val  | address | undefined |

### log_named_bytes

```solidity
event log_named_bytes(string key, bytes val)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| key  | string | undefined |
| val  | bytes | undefined |

### log_named_bytes32

```solidity
event log_named_bytes32(string key, bytes32 val)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| key  | string | undefined |
| val  | bytes32 | undefined |

### log_named_decimal_int

```solidity
event log_named_decimal_int(string key, int256 val, uint256 decimals)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| key  | string | undefined |
| val  | int256 | undefined |
| decimals  | uint256 | undefined |

### log_named_decimal_uint

```solidity
event log_named_decimal_uint(string key, uint256 val, uint256 decimals)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| key  | string | undefined |
| val  | uint256 | undefined |
| decimals  | uint256 | undefined |

### log_named_int

```solidity
event log_named_int(string key, int256 val)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| key  | string | undefined |
| val  | int256 | undefined |

### log_named_string

```solidity
event log_named_string(string key, string val)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| key  | string | undefined |
| val  | string | undefined |

### log_named_uint

```solidity
event log_named_uint(string key, uint256 val)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| key  | string | undefined |
| val  | uint256 | undefined |

### log_string

```solidity
event log_string(string)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0  | string | undefined |

### log_uint

```solidity
event log_uint(uint256)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0  | uint256 | undefined |

### logs

```solidity
event logs(bytes)
```

#### Parameters

| Name | Type | Description |
|---|---|---|
| _0  | bytes | undefined |
