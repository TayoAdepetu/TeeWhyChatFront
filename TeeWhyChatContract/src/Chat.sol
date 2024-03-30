// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "./lib/LibChat.sol";
import "./interface/IENS.sol";

contract Chat {
    uint256 chatId = 1;

    mapping(address => mapping(address => LibChat.Message[]))
        public allMessages;

    mapping(address => mapping(address => uint256)) public messages;

    mapping(uint256 => LibChat.Message[]) chatSession;

    IENS public ens;
    address public ensAddress;

    constructor(address _ens) {
        ensAddress = _ens;
        ens = IENS(_ens);
    }

    function sendMessage(
        string memory _receiver,
        string memory _userMessage
    ) external {
        // check if the receiver has an ENS record
        (address _recipient, , ) = ens.getENSRecord(_receiver);

        uint256 _chatSession = chatCheck(msg.sender, _recipient);
        if (_chatSession == 0) {
            _chatSession = chatId;
            messages[msg.sender][_recipient] = _chatSession;
            chatId++;
        }

        LibChat.Message memory _message = LibChat.Message(
            msg.sender,
            _recipient,
            _userMessage
        );

        allMessages[msg.sender][_recipient].push(
            LibChat.Message(msg.sender, _recipient, _userMessage)
        );
        allMessages[_recipient][msg.sender].push(
            LibChat.Message(msg.sender, _recipient, _userMessage)
        );
        chatSession[_chatSession].push(_message);

        emit LibChat.messageSentEvent(msg.sender, _recipient, _userMessage);
    }

    function getMessages(
        string memory _sender,
        string memory _receiver
    ) external returns (LibChat.Message[] memory) {
        // check if the receiver has an ENS record
        (address _senderAddress, , ) = ens.getENSRecord(_sender);
        (address _recipient, , ) = ens.getENSRecord(_receiver);
        uint256 _chatSession = chatCheck(_senderAddress, _recipient);
        return chatSession[_chatSession];
    }

    function getAllMsg(address to) public {
        if (allMessages[msg.sender][to].length == 0) {
            emit LibChat.messagesFetchedEvent(
                msg.sender,
                to,
                allMessages[to][msg.sender]
            );
        } else {
            emit LibChat.messagesFetchedEvent(
                msg.sender,
                to,
                allMessages[msg.sender][to]
            );
        }
    }

    function chatCheck(
        address sender,
        address receiver
    ) private view returns (uint256) {
        if (messages[sender][receiver] != 0) {
            return messages[sender][receiver];
        } else if (messages[receiver][sender] != 0) {
            return messages[receiver][sender];
        }
        return 0;
    }
}
