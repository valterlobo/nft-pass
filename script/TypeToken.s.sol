// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Script, console} from "forge-std/Script.sol";
import "../src/NFTPass.sol";

contract NFTTypeScript is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);
        address tkContract = vm.envAddress("TK_CONTRACT");
        NFTPass nft = NFTPass(tkContract);

        //NFT info
        string memory nm = "Hackaton Como ganhei varios";
        string memory description = "Dicas para participar e ganhar hackatons";
        string memory dateStart = "20/04/2024";
        string memory dateEnd = "22/04/2024";
        string memory timeStart = "11:00";
        string memory timeEnd = "12:00";
        string memory instructions = "Transmitido ao vivo no YouTube.";
        string memory author = "Grace Hopper";
        string memory image = "ipfs://QmTMG4fuQcsDX7D7r7bpGSLAMC7C5eYCGKdFrKnACGJHKc/image.gif";
        string memory local = "Online";
        string memory link = "https://www.youtube.com/watch?v=eBAdDVDId0U";

        nft.setPassInfo(
            nm, description, dateStart, dateEnd, timeStart, timeEnd, instructions, author, image, local, link
        );

        // PROPS
        PassType.Property[] memory props = new PassType.Property[](3);
        uint256 maxSupply = 10;
        // PassType.Property memory propPAss = PassType.Property("name", "NFT PASS COURSE SOLIDITY");

        props[0] = PassType.Property("Nome", "Maria das NFT", "HOST");
        props[1] = PassType.Property("Nome", "JOAO DA WEB3", "HOST");
        props[2] = PassType.Property("URL", "https://www.youtube.com/watch?v=eBAdDVDId0U", "ACESSO");

        // TYPE : COMMUN
        nft.addPASSType(
            1,
            "COMMUN",
            "COMMUN- PASS para o acesso ao webnar",
            "ipfs://QmTMG4fuQcsDX7D7r7bpGSLAMC7C5eYCGKdFrKnACGJHKc/image.gif",
            maxSupply,
            45000000000000000,
            props
        );

        //TYPE : VIP

        nft.addPASSType(
            2,
            "VIP",
            "VIP- PASS para o acesso ao webnar & perguntas para o HOST",
            "ipfs://QmVmZdDKTSGEfiagaiEVqoMec1QtGpNS7GxHfacJ4s483B",
            maxSupply,
            85000000000000000,
            props
        );

        vm.stopBroadcast();
    }
}
