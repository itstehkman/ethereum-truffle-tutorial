pragma solidity ^0.4.11;

import 'truffle/Assert.sol';
// When running tests, truffle deploys new contract instance to tesrpc. this contract gets that deployed address
import 'truffle/DeployedAddresses.sol';
import '../contracts/Adoption.sol';

contract TestAdoption {
  Adoption adoption = Adoption(DeployedAddresses.Adoption());

  function testUserCanAdoptPet() {
    uint returnedId = adoption.adopt(8);
    Assert.equal(returnedId, 8, 'Expected pet id 8');
  }

	// Testing retrieval of a single pet's owner
	function testGetAdopterAddressByPetId() {
		// Expected owner is this contract
		address expected = this;
		address adopter = adoption.adopters(8);
		Assert.equal(adopter, expected, "Owner of pet ID 8 should be recorded.");
	}

	// Testing retrieval of all pet owners
	function testGetAdopterAddressByPetIdInArray() {
		// Expected owner is this contract
		address expected = this;
		// memory keyword: Store adopters in memory rather than contract's storage
		address[16] memory adopters = adoption.getAdopters();
		Assert.equal(adopters[8], expected, "Owner of pet ID 8 should be recorded.");
	}

}
