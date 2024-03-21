// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {NFTPass, PassType} from "../src/NFTPass.sol";
import {NFTPassFactory} from "../src/NFTPassFactory.sol";

//import {BuyPass} from "../src/BuyPass.sol";

contract NFTPassTest is Test {
    NFTPass public nftPASS;
    NFTPassFactory public nftPassFactory;
    //BuyPass public buyPass;
    address promotor = vm.addr(0x1);
    address publico1 = vm.addr(0x2);
    address publico2 = vm.addr(0x4);
    address plataform = vm.addr(0x8);
    address buyer = vm.addr(0x12);

    function setUp() public {
        nftPASS = new NFTPass(promotor, publico1, 10, "HACK NFT PASS", "HKPASS");
        nftPassFactory = new NFTPassFactory(payable(plataform), 10);
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
        props[2] = PassType.Property("URL", "ipfs://QmTMG4fuQcsDX7D7r7bpGSLAMC7C5eYCGKdFrKnACGJHKc/image.gif", "ACESSO");

        vm.prank(promotor);
        nftPASS.addPASSType(id, nameType, descriptionType, imgType, maxSupply, 45000000000000000, props);

        PassType.PASSType memory passTypeItem = nftPASS.getPASSType(id);
        console.log("Name:%s  | MAX SUPPLY %d", passTypeItem.name, passTypeItem.maxSupply);
        assertEq(nameType, passTypeItem.name);
        assertEq(id, passTypeItem.id);
        assertEq(maxSupply, passTypeItem.maxSupply);

        vm.prank(promotor);
        nftPASS.addPASSType(
            2,
            "VIP",
            "VIP- PASS para o acesso ao webnar & perguntas para o HOST",
            "ipfs://QmTMG4fuQcsDX7D7r7bpGSLAMC7C5eYCGKdFrKnACGJHKc/image.gif",
            maxSupply,
            85000000000000000,
            props
        );

        PassType.Property[] memory propsGet = nftPASS.getMetadatas(id);

        console.log(propsGet[0].key, propsGet[0].value);
        console.log(propsGet[1].key, propsGet[1].value);

        //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        // vm.expectRevert(abi.encodeWithSelector(ERC20Capped.ERC20ExceededCap.selector, maxSupply + bobAmount, maxSupply));
        //vm.startPrank(alice);
        //token.mint(bob, bobAmount);

        uint256[] memory indexTypes = nftPASS.getIndexPASSTypes();

        for (uint256 i = 0; i < indexTypes.length; i++) {
            uint256 idType = indexTypes[i];
            PassType.PASSType memory p = nftPASS.getPASSType(idType);
            console.log(p.name);
        }

        string memory strJSON = nftPASS.getPassTypeJSON(id);
        console.log(strJSON);

        strJSON = nftPASS.getPassTypeJSON(2);
        console.log(strJSON);

        //mint !
        vm.prank(promotor);
        nftPASS.mint(publico1, 1, 4);

        vm.prank(promotor);
        nftPASS.mint(publico2, 2, 1);

        //criar o   NFT PASS
        string memory nm = "EVM NFT USE CASES";
        string memory sbl = "ENFT";

        vm.prank(publico2);
        NFTPass newPASS = nftPassFactory.createNFTPaas(nm, sbl);

        console.log(newPASS.name());
        assertEq(newPASS.owner(), publico2);
        setNFTTypes(newPASS, publico2);

        //COMPRANDO A NFT PASS VIP
        console.log("-------COMPRANDO A NFT PASS VIP --------");
        vm.deal(buyer, 10 ether);
        vm.deal(publico1, 0.8 ether);
        uint256 buyerBalanceBefore = address(buyer).balance;

        console.log("/MAX SUPPLY:", newPASS.getPASSType(1).maxSupply, "-", newPASS.getPASSType(2).maxSupply);
        console.log("/SUPPLY:", newPASS.getPASSType(1).supply, "-", newPASS.getPASSType(2).supply);

        vm.prank(buyer);
        newPASS.buyNFTPass{value: 0.255 ether}(2, 3);

        vm.prank(publico1);
        newPASS.buyNFTPass{value: 0.36 ether}(1, 8);

        console.log(newPASS.balanceOf(buyer, 2));

        uint256 buyerBalanceAfter = address(buyer).balance;

        console.log(buyerBalanceBefore, " ->", buyerBalanceAfter);

        console.log("/SUPPLY:", newPASS.getPASSType(1).maxSupply, "-", newPASS.getPASSType(2).maxSupply);
        console.log("/SUPPLY:", newPASS.getPASSType(1).supply, "-", newPASS.getPASSType(2).supply);
        console.log("CONTRACT BALANCE:", address(newPASS).balance);

        vm.prank(buyer);
        newPASS.claimPayment();

        console.log("AFTER CONTRACT BALANCE:", address(newPASS).balance);

        console.log("PROMOTOR BALANCE:", address(publico2).balance);

        console.log("-------/COMPRANDO A NFT PASS VIP --------");
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
        nftPASS.setPassInfo(
            nm, description, dateStart, dateEnd, timeStart, timeEnd, instructions, author, image, local, link
        );
        console.log("---------------");
        string memory passInfoJSON = nftPASS.contractURI();
        console.log(passInfoJSON);
    }

    function setNFTTypes(NFTPass nft, address addrCreate) public {
        uint256 id = 1;
        string memory nameType = "COMUM";
        string memory descriptionType = "COMUM  - PASS para o acesso ao webnar";
        string memory imgType = "http//uri";
        PassType.Property[] memory props = new PassType.Property[](3);
        uint256 maxSupply = 10;

        // PassType.Property memory propPAss = PassType.Property("name", "NFT PASS COURSE SOLIDITY");

        props[0] = PassType.Property("Nome", "Maria das NFT", "HOST");
        props[1] = PassType.Property("Nome", "JOAO DA WEB3", "HOST");
        props[2] = PassType.Property("URL", "ipfs://QmTMG4fuQcsDX7D7r7bpGSLAMC7C5eYCGKdFrKnACGJHKc/image.gif", "ACESSO");

        vm.prank(addrCreate);
        nft.addPASSType(id, nameType, descriptionType, imgType, maxSupply, 45000000000000000, props);

        PassType.PASSType memory passTypeItem = nft.getPASSType(id);
        console.log("Name:%s  | MAX SUPPLY %d", passTypeItem.name, passTypeItem.maxSupply);
        assertEq(nameType, passTypeItem.name);
        assertEq(id, passTypeItem.id);
        assertEq(maxSupply, passTypeItem.maxSupply);

        vm.prank(addrCreate);
        nft.addPASSType(
            2,
            "VIP",
            "VIP- PASS para o acesso ao webnar & perguntas para o HOST",
            "ipfs://QmTMG4fuQcsDX7D7r7bpGSLAMC7C5eYCGKdFrKnACGJHKc/image.gif",
            maxSupply,
            85000000000000000,
            props
        );

        PassType.Property[] memory propsGet = nft.getMetadatas(id);

        console.log(propsGet[0].key, propsGet[0].value);
        console.log(propsGet[1].key, propsGet[1].value);

        //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
        // vm.expectRevert(abi.encodeWithSelector(ERC20Capped.ERC20ExceededCap.selector, maxSupply + bobAmount, maxSupply));
        //vm.startPrank(alice);
        //token.mint(bob, bobAmount);

        uint256[] memory indexTypes = nft.getIndexPASSTypes();

        for (uint256 i = 0; i < indexTypes.length; i++) {
            uint256 idType = indexTypes[i];
            PassType.PASSType memory p = nft.getPASSType(idType);
            console.log(p.name);
        }

        string memory strJSON = nft.getPassTypeJSON(id);
        console.log(strJSON);

        strJSON = nft.getPassTypeJSON(2);
        console.log(strJSON);
    }
}
