#!/usr/bin/env node
// @package generate salt
// @version 0.1.0
// @summary generate salt for create2
// @see {@link https://docs.manifoldfinance.com}
import { ethers } from "ethers";
console.log('Generating Salt for deployment')
ethers.utils.id(Date.now().toString());
// TODO write to file, etc etc
console.log('salt:' + ethers.utils.id(Date.now().toString()));
