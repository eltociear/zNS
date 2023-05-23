// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { IZNSAccessController } from "./IZNSAccessController.sol";


abstract contract AccessControlled {

    event AccessControllerSet(address accessController);

    IZNSAccessController internal accessController;


    modifier onlyAdmin() {
        accessController.checkAdmin(msg.sender);
        _;
    }


    /**
     * @dev This is here to make sure the external function is always implemented in children,
     * otherwise we will not be able to reset the module.
     */
    function setAccessController(address _accessController) external virtual;

    function getAccessController() external view returns (address) {
        return address(accessController);
    }

    function _setAccessController(address _accessController) internal {
        require(_accessController != address(0), "AC: _accessController is 0x0 address");
        accessController = IZNSAccessController(_accessController);
        emit AccessControllerSet(_accessController);
    }
}
