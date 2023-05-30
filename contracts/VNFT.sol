// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./accessControl/ServicerRole.sol";
import "@identity.com/gateway-protocol-eth/contracts/Gated.sol";


// only from authoized accounts 
// TODO add recall authority
contract VNFT is ERC721,ServicerRole,Gated {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    uint256 constant epochYear = 31556926;

    event MintVehicles(bytes32 vehicleId);
    event IssueReCall(bytes32 recallId, bytes32 vehicleId);
    event FixReCall(bytes32 recallId, bytes32 vehicleId);
    event AddServiceRecord(bytes32 vehicleId);

    struct Vehicle {
        bytes32 UID;             // hash of vin
        uint256 year;            // vehicle year
        string make;             // make of vehicle
        string model;            // model of vehicle
        string assetUri;         // image of vehicle
    }

    struct Recall {
        bytes32 id;
        string title;
        string description;
    }

    struct Service {
        address servicer;
        string title;
        string description;
    }
 
    // Owned tokens
    mapping(address => uint256[]) private tokenOwners; 

    // Vehicle NFTS
    mapping(uint256 => bytes32) private tokenToVin;
    mapping(bytes32 => Vehicle) private vehicles;
    mapping(bytes32 => Service[]) private serviceHistory;

    // Map make mode year to recall list
    // hash(model make) -> year -> of start and end index of uint256
    mapping(bytes32 => mapping(uint256 => bytes32[])) private groupRecalls;

    // vehicle vin Hash -> recall -> hasBeenFixed
    mapping(bytes32 => mapping(bytes32 => bool)) private fixRecalls;

    // recallId -> recall 
    mapping(bytes32 => Recall) private recalls;

    constructor(address gatewayTokenContract, uint256 gatekeeperNetwork, string memory name, string memory symbol) ERC721(name, symbol) 
    Gated(gatewayTokenContract, gatekeeperNetwork)
    {}

    /**
     * @dev createToken
     * 
     * Internal for 
     *
     * @param _owner NFT owner 
     *
     */
    function createToken(bytes32 vinId,address _owner) internal returns (uint256) {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        tokenToVin[newItemId] = vinId;
        tokenOwners[_owner].push(newItemId);
        _mint(_owner, newItemId);
        return newItemId;
    }

    /**
     * @dev mintVehicle
     *
     * Creates a digital representation of the vehicle 
     * TODO Use Civic IDV service to check for human
     *
     * @param _vinId        vehicle vin id
     * @param _make         vehicle make
     * @param _model        vehicle model
     * @param _assetUri     vehicle asset uri
     * 
     */
    function mintVehicle(bytes32 _vinId, uint256 _year ,string memory _make, string memory _model, string memory _assetUri) 
    public

    {
        Vehicle memory vehicle;
        require(vehicles[_vinId].UID == 0, "Vehicle already minted.");

        vehicle.UID = _vinId;
        vehicle.year = _year;
        vehicle.make = _make;
        vehicle.model = _model;
        vehicle.assetUri = _assetUri;
        
        vehicles[_vinId] = vehicle;
        createToken(_vinId,msg.sender);

        emit MintVehicles(_vinId);
    }

    function getTotalSupply()
    public
    view 
    returns(uint256 counter)
    {
        return(_tokenIds._value);
    }

    /**
     * @dev getOwnedVehicles
     *
     * @param _owner        address
     *
     */
    function getOwnedVehicles(address _owner)
    public
    view
    returns(uint256[] memory)
    {
        return(tokenOwners[_owner]);
    }

    /**
     * @dev getVehicleByVin
     *
     * @param _vinId        bytes32
     *
     */
    function getVehicleByVin(bytes32 _vinId)
    public
    view
    returns(Vehicle memory)
    {
        return(vehicles[_vinId]);
    }

    /**
     * @dev getVehicleByTokenId
     *
     * @param _tokenId      uint256
     *
     */
    function getVehicleByTokenId(uint256 _tokenId)
    public
    view
    returns(Vehicle memory)
    {
        return(vehicles[tokenToVin[_tokenId]]);
    }

    /**
     * @dev transferFrom
     *
     * Override XRC721 / ERC721 
     * 
     * @param from          address 
     * @param to            address 
     * @param tokenIndex    uint256 
     */
    function transferFrom(address from,address to,uint256 tokenIndex)
    public
    override
    {
        require(tokenIndex <= tokenOwners[from].length,"token index out of range!");
        uint256 tokenId = tokenOwners[from][tokenIndex];

        safeTransferFrom(from,to,tokenId);
        
        // transfer token via index to new owner
        tokenOwners[to].push(tokenOwners[from][tokenIndex]);
        // Note this could lead to high gas if owned tokens is large
        for (uint i = tokenIndex; i < tokenOwners[from].length - 1; i++) {
           tokenOwners[from][i] = tokenOwners[from][i+1];
        }
        tokenOwners[from].pop();
    }



/******************************** Recall Services ***********************************/

    /**
     * @dev issueReCall
     *
     * @param _make             string make of vehicle
     * @param _model            string model of vehicle
     * @param _year             uint256 year 
     * @param _title            string title 
     * @param _description      string description
     *
     */
    function issueReCall(string memory _make, string memory _model,uint256 _year, string memory _title, string memory _description)
    public 
    {
        Recall memory recall;
        recall.title = _title;
        recall.description = _description;

        bytes32 recallId = keccak256(abi.encodePacked(_title, _description));
        bytes32 vehicleKey = keccak256(abi.encodePacked(_make, _model));

        // year for vehicle from 1971 
        uint256 yearIndex = _year / epochYear; 

        // append recall id
        groupRecalls[vehicleKey][yearIndex].push(recallId);

        // set recallId to recall 
        recalls[recallId] = recall;
        
        /*
        // loop through each vehicle key hash (make model)
        for(uint256 vk = 0; vk < _vehicleKey.length; vk++) {
            // loop through each year list
            for(uint256 y = 0; y < _epochYearList.length; y++) {
                
                // year for vehicle from 1971 
                uint256 yearIndex = _epochYearList[y] / epochYear; 
                bytes32[] memory recallsForVK = groupRecalls[_vehicleKey[vk]][yearIndex];

                recallsForVK[recallsForVK.length + 1] = recallId;

                // add recalls
                groupRecalls[_vehicleKey[vk]][yearIndex] = recallsForVK;
                recalls[recallId] = recall;
            }
        }
        */

        // Check if issue authority
        emit IssueReCall(recallId,vehicleKey);
    }

    /**
     * @dev fixReCall
     *
     * @param _recallId     bytes32 recallId
     * @param _vehicleId    bytes32 vehicleId
     *           
     */
    function fixReCall(bytes32 _recallId, bytes32 _vehicleId)
    public 
    {
        fixRecalls[_vehicleId][_recallId] = true;
        emit FixReCall(_recallId,_vehicleId);
    }

    /**
     * @dev getRecalls
     *
     * Allows user to get recalls for vehicle
     *
     * @param _make     string make of vehicle
     * @param _model    string model of vehicle
     * @param _year     uint256 epoch year of vehicle
     *           
     */
    function getRecalls(string memory _make, string memory _model, uint256 _year)
    public
    view
    returns(bytes32[] memory)
    {
        bytes32 vehiclesKey = keccak256(abi.encodePacked(_make, _model));
        uint256 yearIndex = _year / epochYear; 
        return(groupRecalls[vehiclesKey][yearIndex]);
    }


/******************************** Service History ***********************************/

    /**
     * @dev addService
     *
     * @param _vehicleId      vin hash of vehicle id
     * @param _title          title of service
     * @param _description    description of service
     *
     * TODO add timestamp of service
     */
    function vehicleService(bytes32 _vehicleId, string memory _title, string memory _description)
    public 
    onlyServicer
    {
        Service memory service;
        service.title = _title;
        service.description = _description;
        service.servicer = msg.sender;

        serviceHistory[_vehicleId].push(service);

        emit AddServiceRecord(_vehicleId);
    }

    /**
     * @dev getVehicleServiceCount
     *
     * @param _vehicleId vehicle id
     *
     */
    function getVehicleServiceCount(bytes32 _vehicleId)
    public
    view
    returns(uint256)
    {
        return(serviceHistory[_vehicleId].length);
    }

    /**
     * @dev getVehicleService
     *
     * @param _vehicleId      vehicle id
     * @param _startIndex     start index to get 
     * @param _amount         amount of service records
     */
    function getVehicleService(bytes32 _vehicleId, uint256 _startIndex, uint256 _amount)
    public
    view
    returns(Service[] memory)
    {
        uint256 end = _startIndex + _amount;
        uint256 newIndex = 0;

        Service[] memory temp = new Service[](_amount);
        for(uint a = _startIndex; a < end; a++) {
            temp[newIndex] = serviceHistory[_vehicleId][a];
            newIndex++;
        }
        return temp;
    }
}