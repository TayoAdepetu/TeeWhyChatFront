// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {LibEnsEvents, LibEnsErrors} from "./lib/LibEns.sol";

contract ENS {
    struct ensRecord {
        address owner;
        string ensName;
        string ensUri;
    }

    mapping(string => ensRecord) public ensRecords;

    function setENSRecord(
        string memory _ensName,
        string memory _ensUri
    ) public {
        if (ensRecords[_ensName].owner != address(0))
            revert LibEnsErrors.EnsRecordExists();

        ensRecords[_ensName] = ensRecord(msg.sender, _ensName, _ensUri);
        emit LibEnsEvents.EnsRegistrationn(msg.sender, _ensName);
    }

    function getENSRecord(
        string memory _ensName
    ) public view returns (address, string memory, string memory) {
        if (ensRecords[_ensName].owner == address(0))
            revert LibEnsErrors.EnsRecordDoesNotExist();

        return (
            ensRecords[_ensName].owner,
            ensRecords[_ensName].ensName,
            ensRecords[_ensName].ensUri
        );
    }

    function updateENSRecord(
        string memory _ensName,
        string memory _ensUri
    ) public {
        if (ensRecords[_ensName].owner == address(0))
            revert LibEnsErrors.EnsRecordDoesNotExist();

        if (ensRecords[_ensName].owner != msg.sender)
            revert LibEnsErrors.NotEnsOwner();

        ensRecords[_ensName] = ensRecord(msg.sender, _ensName, _ensUri);
        emit LibEnsEvents.UriUpdate(msg.sender, _ensName, _ensUri);
    }
}
