// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library LibChat {
    struct Message {
        address sender;
        address receiver;
        string content;
    }

    event messageSentEvent(
        address indexed from,
        address indexed to,
        string message
    );

    event messagesFetchedEvent(
        address indexed from,
        address indexed to,
        Message[] messages
    );
}
