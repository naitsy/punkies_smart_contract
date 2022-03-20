//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract PunksDNA {
    string[] private _accessoriesType = [
        "Blank",
        "Kurt",
        "Prescription01",
        "Prescription02",
        "Round",
        "Sunglasses",
        "Wayfarers"
    ];

    string[] private _clotheColor = [
        "Black",
        "Blue01",
        "Blue02",
        "Blue03",
        "Gray01",
        "Gray02",
        "Heather",
        "PastelBlue",
        "PastelGreen",
        "PastelOrange",
        "PastelRed",
        "PastelYellow",
        "Pink",
        "Red",
        "White"
    ];

    string[] private _clotheType = [
        "BlazerShirt",
        "BlazerSweater",
        "CollarSweater",
        "GraphicShirt",
        "Hoodie",
        "Overall",
        "ShirtCrewNeck",
        "ShirtScoopNeck",
        "ShirtVNeck"
    ];

    string[] private _eyeType = [
        "Close",
        "Cry",
        "Default",
        "Dizzy",
        "EyeRoll",
        "Happy",
        "Hearts",
        "Side",
        "Squint",
        "Surprised",
        "Wink",
        "WinkWacky"
    ];

    string[] private _eyebrowType = [
        "Angry",
        "AngryNatural",
        "Default",
        "DefaultNatural",
        "FlatNatural",
        "RaisedExcited",
        "RaisedExcitedNatural",
        "SadConcerned",
        "SadConcernedNatural",
        "UnibrowNatural",
        "UpDown",
        "UpDownNatural"
    ];

    string[] private _facialHairColor = [
        "Auburn",
        "Black",
        "Blonde",
        "BlondeGolden",
        "Brown",
        "BrownDark",
        "Platinum",
        "Red"
    ];

    string[] private _facialHairType = [
        "Blank",
        "BeardMedium",
        "BeardLight",
        "BeardMagestic",
        "MoustacheFancy",
        "MoustacheMagnum"
    ];

    string[] private _hairColor = [
        "Auburn",
        "Black",
        "Blonde",
        "BlondeGolden",
        "Brown",
        "BrownDark",
        "PastelPink",
        "Platinum",
        "Red",
        "SilverGray"
    ];

    string[] private _hatColor = [
        "Black",
        "Blue01",
        "Blue02",
        "Blue03",
        "Gray01",
        "Gray02",
        "Heather",
        "PastelBlue",
        "PastelGreen",
        "PastelOrange",
        "PastelRed",
        "PastelYellow",
        "Pink",
        "Red",
        "White"
    ];

    string[] private _graphicType = [
        "Bat",
        "Cumbia",
        "Deer",
        "Diamond",
        "Hola",
        "Pizza",
        "Resist",
        "Selena",
        "Bear",
        "SkullOutline",
        "Skull"
    ];

    string[] private _mouthType = [
        "Concerned",
        "Default",
        "Disbelief",
        "Eating",
        "Grimace",
        "Sad",
        "ScreamOpen",
        "Serious",
        "Smile",
        "Tongue",
        "Twinkle",
        "Vomit"
    ];

    string[] private _skinColor = [
        "Tanned",
        "Yellow",
        "Pale",
        "Light",
        "Brown",
        "DarkBrown",
        "Black"
    ];

    string[] private _topType = [
        "NoHair",
        "Eyepatch",
        "Hat",
        "Hijab",
        "Turban",
        "WinterHat1",
        "WinterHat2",
        "WinterHat3",
        "WinterHat4",
        "LongHairBigHair",
        "LongHairBob",
        "LongHairBun",
        "LongHairCurly",
        "LongHairCurvy",
        "LongHairDreads",
        "LongHairFrida",
        "LongHairFro",
        "LongHairFroBand",
        "LongHairNotTooLong",
        "LongHairShavedSides",
        "LongHairMiaWallace",
        "LongHairStraight",
        "LongHairStraight2",
        "LongHairStraightStrand",
        "ShortHairDreads01",
        "ShortHairDreads02",
        "ShortHairFrizzle",
        "ShortHairShaggyMullet",
        "ShortHairShortCurly",
        "ShortHairShortFlat",
        "ShortHairShortRound",
        "ShortHairShortWaved",
        "ShortHairSides",
        "ShortHairTheCaesar",
        "ShortHairTheCaesarSidePart"
    ];

    function deterministicPseudoRandomDNA( uint256 tokenId, address minter ) internal pure returns( uint256) {

        // sumo los dos parametros
        uint256 combined = tokenId + uint160(minter);

        // lo paso a bytes para hashearlos y obtener el numero "aleatorio"
        bytes memory encoded = abi.encodePacked(combined);

        // genero el hash
        bytes32 hashed = keccak256(encoded);

        return uint256(hashed);
    }


    uint8 constant ADN_SECTION_SIZE = 2;

    function getDNASection( uint256 dna, uint8 rightDiscard) internal pure returns(uint8){
        return uint8(( dna % (1 * 10 ** ( rightDiscard + ADN_SECTION_SIZE)) ) / ( 1 * 10 ** rightDiscard));
    }

    function getAccessoriesType( uint256 dna ) public view returns( string memory ){
        uint8 section = getDNASection(dna, 0);
        return _accessoriesType[ (section % _accessoriesType.length) ];
    }

    function getClotheColor( uint256 dna ) public view returns( string memory ){
        uint8 section = getDNASection(dna, 2);
        return _clotheColor[ (section % _clotheColor.length) ];
    }

    function getClotheType( uint256 dna ) public view returns( string memory ){
        uint8 section = getDNASection(dna, 4);
        return _clotheType[ (section % _clotheType.length) ];
    }

    function getEyeType( uint256 dna ) public view returns( string memory ){
        uint8 section = getDNASection(dna, 6);
        return _eyeType[ (section % _eyeType.length) ];
    }

    function getEyebrowType( uint256 dna ) public view returns( string memory ){
        uint8 section = getDNASection(dna, 8);
        return _eyebrowType[ (section % _eyebrowType.length) ];
    }

    function getFacialHairColor( uint256 dna ) public view returns( string memory ){
        uint8 section = getDNASection(dna, 10);
        return _facialHairColor[ (section % _facialHairColor.length) ];
    }

    function getFacialHairType( uint256 dna ) public view returns( string memory ){
        uint8 section = getDNASection(dna, 10);
        return _facialHairType[ (section % _facialHairType.length) ];
    }

    function getHairColor( uint256 dna ) public view returns( string memory ){
        uint8 section = getDNASection(dna, 12);
        return _hairColor[ (section % _hairColor.length) ];
    }

    function getHatColor( uint256 dna ) public view returns( string memory ){
        uint8 section = getDNASection(dna, 14);
        return _hatColor[ (section % _hatColor.length) ];
    }

    function getGraphicType( uint256 dna ) public view returns( string memory ){
        uint8 section = getDNASection(dna, 16);
        return _graphicType[ (section % _graphicType.length) ];
    }

    function getMouthType( uint256 dna ) public view returns( string memory ){
        uint8 section = getDNASection(dna, 18);
        return _mouthType[ (section % _mouthType.length) ];
    }

    function getSkinColor( uint256 dna ) public view returns( string memory ){
        uint8 section = getDNASection(dna, 20);
        return _skinColor[ (section % _skinColor.length) ];
    }

    function getTopType( uint256 dna ) public view returns( string memory ){
        uint8 section = getDNASection(dna, 22);
        return _topType[ (section % _topType.length) ];
    }

}