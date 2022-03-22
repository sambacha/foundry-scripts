/**!
* @filename DPackFoundry
* @version 0.0.0-draft
* @license MPL-2.0
* @since 0.0.0-0
*/

import fs from 'fs';
import path from 'path';
// TODO
import { handleRequest } from './utils';


const OUTPUT_DIR = path.join(process.cwd(), './build/protocols');
const PROTOCOL_LIST_PATH = path.join(__dirname, '../build/dpacklist.js');

/**
 * @function dpackInstaller
 * @summary Downloads compiled contracts in dpack-1 format for protocol
 * Fetches files from github (and ipfs), and installs them
 * @param protocols List of protocol names
 */
 
// TODO installer = dpackInstaller
export async function installer(protocols?: string[] | undefined) {
    console.log('Installing protocols for Foundry...');
    try {
        await fs.promises.mkdir(OUTPUT_DIR, { recursive: true });
    } catch (err) {
        if (err.code != 'EEXIST') throw err;
    }
    const allProtocolNames = await getAllProtocolNames();
    if (protocols == undefined) {
        protocols = allProtocolNames;
    }
    await Promise.all(protocols.map(handleProtocol));
    function handleProtocol(protocolName: string): Promise<void> {
        try {
            if (!allProtocolNames.includes(protocolName)) {
                throw Error('[ERROR]: No protocol with that name exists');
            }
            return install(protocolName);
        } catch (error) {
            console.error(
                `[FAILURE]: Failed to install protocol ${protocolName}:`,
                error.message
            );
        }
    }
    console.log('[TASK]: Protocol Installed!');
}


async function getAllProtocolNames(): Promise<Array<string>> {
    const list = await fs.promises.readFile(PROTOCOL_LIST_PATH);
    return list
        .toString()
        .split('\n')
        .map((name: string) => {
            return name.split('.json')[0];
        });
}

// TODO
const GITHUB_ORG = ''
const GITHUB_REPO = ''
const ABI_OUTPUT = ''

async function install(protocolName: string) {
    const protocolFilePath = path.join(OUTPUT_DIR, protocolName + '.json');
    const protocolUrl = `https://raw.githubusercontent.com/${GITHUB_ORG}${GITHUB_REPO}/master/abi_storage/src/${ABI_OUTPUT}.json`;
    const protocol = await handleRequest(protocolUrl, { json: true });
    await fs.promises.writeFile(
        protocolFilePath,
        JSON.stringify(protocol, null, 4)
    );
    console.log('Saved', protocolName, 'to', protocolFilePath);
}
