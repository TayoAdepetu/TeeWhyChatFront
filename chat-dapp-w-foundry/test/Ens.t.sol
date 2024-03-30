// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Ens.sol";
import "../src/lib/LibEns.sol";

contract ENSTest is Test {
    ENS ensContract;

    address A = address(0xa);
    address B = address(0xb);
    address C = address(0xc);

    function setUp() public {
        ensContract = new ENS();

        A = mkaddr("user A");
        B = mkaddr("user B");
        C = mkaddr("user C");
    }

    function testSetENSRecord() public {
        switchSigner(A);
        string memory ensName = "firstens";
        string memory ensUri = "firstensuri";
        ensContract.setENSRecord(ensName, ensUri);

        // get ens record
        (
            address _owner,
            string memory _ensName,
            string memory _ensUri
        ) = ensContract.getENSRecord(ensName);

        assert(_owner == A);

        assert(
            keccak256(abi.encodePacked(_ensName)) ==
                keccak256(abi.encodePacked(ensName))
        );
        assert(
            keccak256(abi.encodePacked(_ensUri)) ==
                keccak256(abi.encodePacked(ensUri))
        );
    }

    function testDuplicateENSRecord() public {
        switchSigner(A);
        string memory ensName = "firstens";
        string memory ensUri = "firstensuri";

        ensContract.setENSRecord(ensName, ensUri);

        switchSigner(B);

        vm.expectRevert(
            abi.encodeWithSelector(LibEnsErrors.EnsRecordExists.selector)
        );

        ensContract.setENSRecord(ensName, ensUri);
    }

    function testgetENSRecord() public {
        switchSigner(A);

        string memory ensName = "firstens";
        string memory ensUri = "firstensuri";

        ensContract.setENSRecord(ensName, ensUri);

        // get ens record
        (
            address _owner,
            string memory _ensName,
            string memory _ensUri
        ) = ensContract.getENSRecord(ensName);

        assert(_owner == A);

        assert(
            keccak256(abi.encodePacked(_ensName)) ==
                keccak256(abi.encodePacked(ensName))
        );
        assert(
            keccak256(abi.encodePacked(_ensUri)) ==
                keccak256(abi.encodePacked(ensUri))
        );
    }

    function testEnsRecordDoesNotExist() public {
        vm.expectRevert(
            abi.encodeWithSelector(LibEnsErrors.EnsRecordDoesNotExist.selector)
        );

        string memory ensName = "firstens";

        ensContract.getENSRecord(ensName);
    }

    function testUpdateENSRecord() public {
        switchSigner(A);

        string memory ensName = "firstens";
        string memory ensUri = "firstensuri";

        ensContract.setENSRecord(ensName, ensUri);

        // update uri
        string memory newEnsUri = "updatedfirstensuri";

        ensContract.updateENSRecord(ensName, newEnsUri);

        // get ens record
        (, , string memory _ensUri) = ensContract.getENSRecord(ensName);

        assert(
            keccak256(abi.encodePacked(_ensUri)) ==
                keccak256(abi.encodePacked(newEnsUri))
        );
    }

    function testNotYourENSRecordWhileUpdatingRecord() public {
        switchSigner(C);

        string memory ensName = "firstens";
        string memory ensUri = "firstensuri";

        ensContract.setENSRecord(ensName, ensUri);

        switchSigner(A);

        vm.expectRevert(
            abi.encodeWithSelector(LibEnsErrors.NotEnsOwner.selector)
        );
        // update uri
        string memory newEnsUri = "updatedfirstensuri";

        ensContract.updateENSRecord(ensName, newEnsUri);
    }

    function testNotENSRecordWhileUpdatingRecord() public {
        switchSigner(A);

        vm.expectRevert(
            abi.encodeWithSelector(LibEnsErrors.EnsRecordDoesNotExist.selector)
        );
        // update uri
        string memory newEnsUri = "updatedfirstensuri";
        string memory ensName = "firstens";

        ensContract.updateENSRecord(ensName, newEnsUri);
    }

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
