// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {PassType} from "../src/PassType.sol";

contract PassTypeTest is Test {
    PassType public passType;
    address promotor = vm.addr(0x1);
    address publco1 = vm.addr(0x2);
    address publco2 = vm.addr(0x3);

    function setUp() public {
        passType = new PassType(promotor);
    }

    function test_addPASSType() public {
        uint256 id = 1;
        string memory nameType = "COMUM";
        string memory descriptionType = "COMUM  - PASS para o acesso ao webnar";
        string memory imgType = "http//uri";
        PassType.Property[] memory props = new PassType.Property[](3);
        uint256 maxSupply = 10;

        // PassType.Property memory propPAss = PassType.Property("name", "NFT PASS COURSE SOLIDITY");

        props[0] = PassType.Property("Nome", "Maria das NFT", "HOST");
        props[1] = PassType.Property("Nome", "JOAO DA WEB3", "HOST");
        props[2] = PassType.Property("URL", "IPFS://XXXXXXXXXXXX/img.png", "ACESSO");

        vm.prank(promotor);
        passType.addPASSType(id, nameType, descriptionType, imgType, maxSupply, 45000000, props);

        PassType.PASSType memory passTypeItem = passType.getPASSType(id);
        console.log("Name:%s  | MAX SUPPLY %d", passTypeItem.name, passTypeItem.maxSupply);
        assertEq(nameType, passTypeItem.name);
        assertEq(id, passTypeItem.id);
        assertEq(maxSupply, passTypeItem.maxSupply);

        vm.prank(promotor);
        passType.addPASSType(
            2,
            "VIP",
            "VIP- PASS para o acesso ao webnar & perguntas para o HOST",
            "http//vippass",
            maxSupply,
            85000000,
            props
        );

        PassType.Property[] memory propsGet = passType.getMetadatas(id);

        console.log(propsGet[0].key, propsGet[0].value);
        console.log(propsGet[1].key, propsGet[1].value);

        //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        // vm.expectRevert(abi.encodeWithSelector(ERC20Capped.ERC20ExceededCap.selector, maxSupply + bobAmount, maxSupply));
        //vm.startPrank(alice);
        //token.mint(bob, bobAmount);

        uint256[] memory indexTypes = passType.getIndexPASSTypes();

        for (uint256 i = 0; i < indexTypes.length; i++) {
            uint256 idType = indexTypes[i];
            PassType.PASSType memory p = passType.getPASSType(idType);
            console.log(p.name);
        }

        string memory strJSON = passType.getPassTypeJSON(id);
        console.log(strJSON);

        strJSON = passType.getPassTypeJSON(2);
        console.log(strJSON);
    }

    function testLimitMaxSupply() external {}

    function testgetPassInfoJSON() external {
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

        vm.prank(promotor);
        passType.setPassInfo(
            nm, description, dateStart, dateEnd, timeStart, timeEnd, instructions, author, image, local, link
        );
        console.log("---------------");
        string memory passInfoJSON = passType.getPassInfoJSON();
        console.log(passInfoJSON);
    }
}
