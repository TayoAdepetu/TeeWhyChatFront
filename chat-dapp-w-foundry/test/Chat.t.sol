// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Chat.sol";
import "../src/lib/LibChat.sol";
import "../src/interface/IENS.sol";
import "../src/Ens.sol";

contract ChatTest is Test {
    Chat chatContract;
    ENS ensContract;

    address A = address(0xa);
    address B = address(0xb);
    address C = address(0xc);

    string aens = "aens";
    string aensuri = "aensuri";
    string bens = "bens";
    string bensuri = "bensuri";
    string cens = "cens";
    string censuri = "censuri";

    function setUp() public {
        ensContract = new ENS();
        chatContract = new Chat(address(ensContract));

        A = mkaddr("user A");
        B = mkaddr("user B");
        C = mkaddr("user C");

        switchSigner(A);
        ensContract.setENSRecord(aens, aensuri);

        switchSigner(B);
        ensContract.setENSRecord(bens, bensuri);

        switchSigner(C);
        ensContract.setENSRecord(cens, censuri);
    }

    function testSendMessage() public {
        switchSigner(A);
        chatContract.sendMessage(bens, "Hello bro b");

        switchSigner(B);
        chatContract.sendMessage(aens, "Hello bro A");

        LibChat.Message[] memory _message = chatContract.getMessages(
            aens,
            bens
        );

        LibChat.Message[] memory _message2 = chatContract.getMessages(
            bens,
            aens
        );

        assert(_message.length == 2);
        assert(_message2.length == 2);
    }

    // function testGetAllMsg() public {
    //     switchSigner(A);
    //     chatContract.sendMessage(bens, "Hello bro b");

    //     switchSigner(B);
    //     chatContract.sendMessage(aens, "Hello bro A");

    //     switchSigner(A);
    //     vm.expectEmit();
    //     // chatContract.getAllMsg(B);
    // }

    function switchSigner(address _newSigner) public {
        address foundrySigner = 0x1804c8AB1F12E6bbf3894d4083f33e07309d1f38;
        if (msg.sender == foundrySigner) {
            vm.startPrank(_newSigner);
        } else {
            vm.stopPrank();
            vm.startPrank(_newSigner);
        }
    }

    function mkaddr(string memory name) public returns (address) {
        address addr = address(
            uint160(uint256(keccak256(abi.encodePacked(name))))
        );
        vm.label(addr, name);
        return addr;
    }
}
