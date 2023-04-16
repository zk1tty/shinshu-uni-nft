// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721URIStorage, Ownable {
    // TODO: need to count the totalSupply as counter
    // # Grammer: using A(library) for B(type, struct data type)
    using Counters for Counters.Counter;
    Counters.Counter private tokenCount;
    string public baseURI;
    
    constructor(string memory baseURI_) ERC721("TokenName", "Symbol") {
        baseURI = baseURI_;
    }

    function mint() public returns (uint256) {
        uint256 newTokenId = tokenCount.current();
        _safeMint(msg.sender, newTokenId);
        tokenCount.increment();

        // tokenID minted
        return newTokenId;
    }

    // Action1: baseURI hosts only one image file.
    // Action2: baseURI hosts the directory. -> update baseURI 
    function setBaseURI(string memory baseURI_) public{
        baseURI = baseURI_;
    }

    function _baseURI() internal view override virtual returns (string memory) {
        return baseURI;
    }

    // Action3:
    function mintwithTokenURI(string memory _tokenURI) public returns (uint256) {
        uint256 newTokenId = tokenCount.current();
        _safeMint(msg.sender, newTokenId);

        // ERC721URIStorage
        // @dev Sets `_tokenURI` as the tokenURI of `tokenId`.
        // function _setTokenURI(uint256 tokenId, string memory _tokenURI)

        // Action1: If no baseURI, return _tokenURI.
        // Action2: baseURI + _tokenURI
        _setTokenURI(newTokenId, _tokenURI);
        tokenCount.increment();

        // tokenID minted
        return newTokenId;
    }

}