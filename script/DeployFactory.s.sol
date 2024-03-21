// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import "../src/NFTPassFactory.sol";

contract DeployFactory is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        address payable feeAddr = payable(0x3F9E5E96b26156541D369e57337881f6BA9Bc6A9);
        uint256 feeTax = 10;
        NFTPassFactory factory = new NFTPassFactory(feeAddr, feeTax);

        vm.stopBroadcast();
    }
}
