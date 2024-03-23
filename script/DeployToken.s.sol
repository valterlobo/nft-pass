// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import "../src/NFTPass.sol";

contract NFTDeployScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address owner = 0x3F9E5E96b26156541D369e57337881f6BA9Bc6A9;

        string memory nm = "Hackaton NFT PASS";
        string memory symbol = "HKPASS";

        NFTPass nftPAss = new NFTPass(owner, owner, 10, nm, symbol);
        console.log(address(nftPAss));

        vm.stopBroadcast();
    }
}
