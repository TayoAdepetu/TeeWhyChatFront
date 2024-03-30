// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library LibEnsEvents {
    event EnsRegistrationn(address indexed owner, string ensName);
    event UriUpdate(address indexed owner, string ensName, string ensUri);
}

library LibEnsErrors {
    error EnsRecordExists();
    error NotEnsOwner();
    error EnsRecordDoesNotExist();
}
