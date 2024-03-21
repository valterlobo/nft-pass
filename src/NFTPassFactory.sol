// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./NFTPass.sol";

contract NFTPassFactory {
    address payable feeAddr;
    uint256 feeTax;

    mapping(address => NFTPass[]) mapIssuerNFTPass;

    NFTPass[] openEvents;

    constructor(address payable _feeAddr, uint256 _feeTax) {
        feeAddr = _feeAddr;
        feeTax = _feeTax;
    }

    function getNFTPassIssuer(address issuer) public view returns (NFTPass[] memory) {
        return mapIssuerNFTPass[issuer];
    }

    function getOpenEvents() public view returns (NFTPass[] memory) {
        return openEvents;
    }

    function createNFTPaas(string memory nm, string memory sbl) public returns (NFTPass) {
        NFTPass nftPass = new NFTPass(msg.sender, feeAddr, feeTax, nm, sbl);
        mapIssuerNFTPass[msg.sender].push(nftPass);
        openEvents.push(nftPass);

        return nftPass;
    }

    function closeNFTPaas(address issuer, NFTPass nftClosed) public view {
        NFTPass[] memory nftEvents = mapIssuerNFTPass[issuer];

        int256 idxRemove = -1;

        for (uint256 i = 0; i < nftEvents.length; i++) {
            if (nftEvents[i] == nftClosed) {
                idxRemove = int256(i);
                break;
            }
        }

        if (idxRemove >= 0) {
            delete nftEvents[uint256(idxRemove)];
        }
    }
}
