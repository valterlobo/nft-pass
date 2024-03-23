// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./NFTPass.sol";

contract NFTPassFactory {
    address payable private immutable feeAddr;
    uint256 private immutable feeTax;

    mapping(address => NFTPass[]) mapIssuerNFTPass;

    NFTPass[] openNFTPass;

    constructor(address payable _feeAddr, uint256 _feeTax) {
        require(_feeAddr != address(0), "feeAddr address must be a not zero");

        feeAddr = _feeAddr;
        feeTax = _feeTax;
    }

    function createNFTPass(string memory nm, string memory sbl) external returns (NFTPass) {
        NFTPass nftPass = new NFTPass(msg.sender, feeAddr, feeTax, nm, sbl);
        mapIssuerNFTPass[msg.sender].push(nftPass);
        openNFTPass.push(nftPass);

        return nftPass;
    }

    function getNFTPassIssuer(address issuer) external view returns (NFTPass[] memory) {
        return mapIssuerNFTPass[issuer];
    }

    function getOpenNFTPass() external view returns (NFTPass[] memory) {
        return openNFTPass;
    }
}
