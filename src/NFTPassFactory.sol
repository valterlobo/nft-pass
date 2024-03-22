// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./NFTPass.sol";

contract NFTPassFactory {
    address payable private immutable feeAddr;
    uint256 private immutable feeTax;

    mapping(address => NFTPass[]) mapIssuerNFTPass;

    NFTPass[] openEvents;

    constructor(address payable _feeAddr, uint256 _feeTax) {
        require(_feeAddr != address(0), "feeAddr address must be a not zero");

        feeAddr = _feeAddr;
        feeTax = _feeTax;
    }

    function getNFTPassIssuer(address issuer) public view returns (NFTPass[] memory) {
        return mapIssuerNFTPass[issuer];
    }

    function getOpenEvents() public view returns (NFTPass[] memory) {
        return openEvents;
    }

    function createNFTPass(string memory nm, string memory sbl) public returns (NFTPass) {
        NFTPass nftPass = new NFTPass(msg.sender, feeAddr, feeTax, nm, sbl);
        mapIssuerNFTPass[msg.sender].push(nftPass);
        openEvents.push(nftPass);

        return nftPass;
    }

    function closeNFTPass(address issuer, NFTPass nftClosed) public view {
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
