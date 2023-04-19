// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { ERC721 } from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import { IZNSDomainToken } from "./IZNSDomainToken.sol";

/**
 * @title A contract for tokenizing domains under the ZNS Architecture
*/
contract ZNSDomainToken is ERC721, IZNSDomainToken {
  // solhint-disable-next-line no-empty-blocks
  constructor() ERC721("ZNSDomainToken", "ZDT") {}

  /**
   * @notice Mints a token with a specified tokenId, using _safeMint, and sends it to the given address
   * @dev TODO: Add Access Control
   * @param to The address that will recieve the newly minted domain token
   * @param tokenId The TokenId that the caller wishes to mint/register
   */
  function register(address to, uint256 tokenId) external override {
    _safeMint(to, tokenId);
  }

  /**
   * @notice Burns the token with the specified tokenId
   * @dev TODO: Add Access Control, replace require to also other specific contracts to revoke
   * @param tokenId The tokenId that the caller wishes to burn/revoke
   */
  function revoke(uint256 tokenId) external override {
    require(
      msg.sender == ownerOf(tokenId),
      "ZNSDomainToken: Only token owner can burn a token"
    );
    _burn(tokenId);
  }
}
