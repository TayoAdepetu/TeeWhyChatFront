// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/Chat.sol";
import "../src/Ens.sol";

contract DeployScript is Script {
    function setUp() public {}

    function run() external {
        vm.startBroadcast();

        ENS ens = new ENS();

        Chat chat = new Chat(address(ens));

        console.log("Chat Contract has beend deployed to  => ", address(chat));

        vm.stopBroadcast();
    }
}
