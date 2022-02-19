# Disco Testing Contract Bundle 

## Overview

### assertRevert 

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