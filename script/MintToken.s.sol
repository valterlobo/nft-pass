// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console} from "forge-std/Script.sol";
import "../src/NFTPass.sol";

contract NFTMintScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        //address  to = payable(vm.envAddress("TO_MINT"));
        address tkContract = vm.envAddress("TK_CONTRACT");
        NFTPass nft = NFTPass(payable(tkContract));
        console.log(address(nft));
        //nft.mint(to, 1, 2);
        //nft.mint(to, 2, 1);
        vm.stopBroadcast();
    }
}
