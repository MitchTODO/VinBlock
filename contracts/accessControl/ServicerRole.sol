// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

contract ServicerRole {

    struct Servicer {
        bool isServicer;     
        string servicerProfile;      // Car image and description ie four door , two door color
    }

    event ServicerAdded(address indexed account);
    event ServicerRemoved(address indexed account);

    //Roles.Role private drivers;
    mapping(address => Servicer) private servicers;

    // Define a modifier that checks to see if msg.sender has the appropriate role
    modifier onlyServicer() {
        require(isServicer(msg.sender),"Sender isn't a servicer");
        _;
    }

    /**
    * @dev Checks if given address is a servicer
    *
    */
    function isServicer(address account) public view returns (bool) {
        return servicers[account].isServicer;
    }

    function getServicerRate(address account) 
    public 
    view 
    returns (Servicer memory) 
    {
        return servicers[account];
    }

    /**
    * @dev Adds servicers
    *
    */
    function addServicer(string memory _servicerProfile) 
    public 
    {
        Servicer memory servicerDetails;
        servicerDetails.isServicer = true;
        servicerDetails.servicerProfile = _servicerProfile;

        servicers[msg.sender] = servicerDetails;
        emit ServicerAdded(msg.sender);
    }

    /**
    * @dev Removes servicers
    *
    */
    function removeServicer() 
    public
    virtual
    onlyServicer
    {
        delete servicers[msg.sender];
        emit ServicerRemoved(msg.sender);
    }

}