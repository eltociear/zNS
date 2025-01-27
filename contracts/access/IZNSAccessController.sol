// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { IAccessControlUpgradeable } from "@openzeppelin/contracts-upgradeable/access/IAccessControlUpgradeable.sol";


interface IZNSAccessController is IAccessControlUpgradeable {
    function initialize(
        address[] calldata governorAddresses,
        address[] calldata operatorAddresses
    ) external;

    function setRoleAdmin(bytes32 role, bytes32 adminRole) external;

    function checkGovernor(address account) external view;

    function checkAdmin(address account) external view;

    function checkExecutor(address account) external view;

    function checkRegistrar(address account) external view;

    function isAdmin(address account) external view returns (bool);

    function isRegistrar(address account) external view returns (bool);
}
