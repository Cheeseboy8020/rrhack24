/*// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.6.0 <0.9.0;

interface OtherFoodDistributor {
    function increaseQuantity(string calldata _itemName, uint256 _quantity) external returns (bool);
    function decreaseQuantity(string calldata _itemName, uint256 _quantity) external returns (bool);
}

contract FoodDistributor is OtherFoodDistributor {
    struct Item {
        string itemName;
        uint256 quantity;
    }

    mapping(string => uint256) public itemNameToQuantity;
    address public owner;
    address public otherAddress;

    // Mapping to track re-entry
    mapping(string => bool) internal _isProcessing;

    constructor(address _otherAddress) public {
        owner = msg.sender;
        otherAddress = _otherAddress != address(0) ? _otherAddress : msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    function addItem(string memory _itemName, uint256 _quantity) public {
        itemNameToQuantity[_itemName] += _quantity;
    }

    function transferItemOut(address _recipient, string memory _itemName, uint256 _quantity) public {
        require(!_isProcessing["transferItemOut"], "Already processing");

        _isProcessing["transferItemOut"] = true;
        require(itemNameToQuantity[_itemName] >= _quantity, "Insufficient quantity in the current contract");

        // Decrease quantity in the current contract
        itemNameToQuantity[_itemName] -= _quantity;

        // Call the recipient contract to increase quantity
        OtherFoodDistributor recipientContract = OtherFoodDistributor(_recipient);
        require(recipientContract.increaseQuantity(_itemName, _quantity), "Increase quantity call failed");

        _isProcessing["transferItemOut"] = false;
    }

    function transferItemIn(string memory _itemName, uint256 _quantity) public  {
        require(!_isProcessing["transferItemIn"], "Already processing");

        _isProcessing["transferItemIn"] = true;

        // Increase quantity in the current contract
        itemNameToQuantity[_itemName] += _quantity;

        _isProcessing["transferItemIn"] = false;
    }

    function increaseQuantity(string calldata _itemName, uint256 _quantity) external override returns (bool) {
        itemNameToQuantity[_itemName] += _quantity;
        return true;
    }

    function decreaseQuantity(string calldata _itemName, uint256 _quantity) external override returns (bool) {
        itemNameToQuantity[_itemName] -= _quantity;
        return true;
    }
}*/

pragma solidity ^0.8.20;

import "./@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./@openzeppelin/contracts/utils/Counters.sol";
import "./@openzeppelin/contracts/access/Ownable.sol";
import "./@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNFT is ERC721URIStorage, Ownable {
    /*using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;*/

    constructor() ERC721("RRHACK", "CAR") Ownable(msg.sender) {}  // Provide the initial owner address by calling the Ownable constructor with msg.sender

    /*function mintNFT(address recipient, string memory tokenURI)
    public onlyOwner
    returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);

        return newItemId;
    }*/
}
