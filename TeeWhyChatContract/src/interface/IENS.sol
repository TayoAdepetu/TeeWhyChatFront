// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

interface IENS {
    function getENSRecord(
        string memory _ensName
    ) external returns (address, string memory, string memory);
}