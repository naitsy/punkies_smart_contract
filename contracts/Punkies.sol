//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Base64.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

import "./PunkiesDNA.sol";

contract Punkies is ERC721, ERC721Enumerable, PunksDNA {
    using Counters for Counters.Counter;
    using Strings for uint256;
    
    mapping( uint256 => uint256 ) _tokenDNA;
    uint256 immutable _maxSupply;
    address _owner;

    Counters.Counter private id_counter;

    constructor( uint256 maxSupply ) ERC721("Punkies","PKIES") {
        _maxSupply = maxSupply;
        _owner = msg.sender;
    }

    function getMaxSupply() public view returns(uint256){
        return _maxSupply;
    }

    function mint() public {
        // me fijo si quedan PUNKS disponibles        
        uint256 current = id_counter.current();
        require( current < _maxSupply, "No PUNKS left");

        // genero el DNA para el NFT creado
        _tokenDNA[current] = deterministicPseudoRandomDNA(current, msg.sender);

        // envio el NFT
        _safeMint(msg.sender, current);

        // incremento el contador
        id_counter.increment();
    }


    function _baseURI() internal override pure returns(string memory){
        return "https://avataaars.io/";
    }

    function _paramsURI( uint256 _dna ) internal view returns(string memory){
                string memory params;

        {
            params = string(
                abi.encodePacked(
                    "accessoriesType=",
                    getAccessoriesType(_dna),
                    "&clotheColor=",
                    getClotheColor(_dna),
                    "&clotheType=",
                    getClotheType(_dna),
                    "&eyeType=",
                    getEyeType(_dna),
                    "&eyebrowType=",
                    getEyebrowType(_dna),
                    "&facialHairColor=",
                    getFacialHairColor(_dna),
                    "&facialHairType=",
                    getFacialHairType(_dna),
                    "&hairColor=",
                    getHairColor(_dna),
                    "&hatColor=",
                    getHatColor(_dna),
                    "&graphicType=",
                    getGraphicType(_dna),
                    "&mouthType=",
                    getMouthType(_dna),
                    "&skinColor=",
                    getSkinColor(_dna)
                )
            );
        }

        return string(abi.encodePacked(params, "&topType=", getTopType(_dna)));
    }

    function imageByDNA( uint256 dna ) public view returns( string memory ){

        return string(abi.encodePacked(_baseURI(), "?", _paramsURI(dna)));

    }


    function tokenURI( uint256 tokenId ) public view override returns(string memory) {
        require( _exists(tokenId), "ERC721 Metadata: URI Query for non exist token" );
        
        uint256 dna = _tokenDNA[ tokenId ];
        string memory image = imageByDNA(dna);

        string memory jsonURI = Base64.encode(
            abi.encodePacked(
                '{ "name": "Punkies #', tokenId.toString(),
                '", "description": "Punkies are randomized Avataaars stored on chain to practicing DApp development", "image": "',
                image,
                '"}'
                )
        );

        return string(abi.encodePacked("data:application/json;base64,", jsonURI));
    }

    // function mint() public payable  {
    //     // pregunto si esta enviando 0.1 eth
    //     require( msg.value >= 0.1 ether, "Insufficient funds" );

    //     // me fijo si quedan PUNKS disponibles        
    //     uint256 current = id_counter.current();
    //     require( current < _maxSupply, "No PUNKS left");

    //     // transfiero los ethers
    //     payable(_owner).transfer( msg.value );

    //     // envio el NFT
    //     _safeMint(msg.sender, current);

    //     // incremento el contador
    //     id_counter.increment();
    // }

    // Override required
    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

}