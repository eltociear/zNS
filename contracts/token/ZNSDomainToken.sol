// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import { ERC721Upgradeable } from "@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol";
import { UUPSUpgradeable } from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import { IZNSDomainToken } from "./IZNSDomainToken.sol";
import { AccessControlled } from "../access/AccessControlled.sol";


/**
 * @title A contract for tokenizing domains under the ZNS Architecture
 */
contract ZNSDomainToken is AccessControlled, UUPSUpgradeable, ERC721Upgradeable, IZNSDomainToken {
    function initialize(
        address accessController,
        string memory tokenName,
        string memory tokenSymbol
    ) public override initializer {
        __ERC721_init(tokenName, tokenSymbol);
        _setAccessController(accessController);
    }

    /**
     * @notice Mints a token with a specified tokenId, using _safeMint, and sends it to the given address
     * @param to The address that will recieve the newly minted domain token
     * @param tokenId The TokenId that the caller wishes to mint/register
     */
    function register(address to, uint256 tokenId) external override onlyRole(REGISTRAR_ROLE) {
        _safeMint(to, tokenId);
    }

    /**
     * @notice Burns the token with the specified tokenId
     * @param tokenId The tokenId that the caller wishes to burn/revoke
     */
    function revoke(uint256 tokenId) external override onlyRole(REGISTRAR_ROLE) {
        _burn(tokenId);
    }

    /**
     * @notice Set the address of the access controller contract
     * @param _accessController The new access controller contract
     */
    function setAccessController(address _accessController) external override onlyRole(GOVERNOR_ROLE) {
        _setAccessController(_accessController);
    }

    /**
     * @notice To use UUPS proxy we override this function and revert if `msg.sender` isn't authorized
     * @dev Using solhint's `no-empty-blocks` will error here, but to be a UUPS Proxy we require it this
     * and so we simply disable solhint for this function
     * 
     * @param newImplementation The new implementation contract to upgrade to.
     */
    function _authorizeUpgrade(address newImplementation) internal override {
        accessController.checkRole(GOVERNOR_ROLE, msg.sender);
    }
}
