const {
  time,
  loadFixture,
} = require("@nomicfoundation/hardhat-network-helpers");
const { anyValue } = require("@nomicfoundation/hardhat-chai-matchers/withArgs");
const { expect } = require("chai");

//var Web3 = require('@nomiclabs/hardhat-web3');

describe("VNFT", function () {
  // We define a fixture to reuse the same setup in every test.
  // We use loadFixture to run this setup once, snapshot that state,
  // and reset Hardhat Network to that snapshot in every test.
  const vinKey = Web3.utils.sha3("SCBZK25E1XCX61813");
  console.log(vinKey);
  const vinKey2 = Web3.utils.sha3("WBAFJ4105B7531683");

  const vehicleYear = 927309964;
  const vehicleMake = "Bentley";
  const vehicleModel = "Azuer";
  const vehicleAsset = "Instagram";

  const vehicleYear2 = 958965464;
  const vehicleMake2 = "BMW";
  const vehicleModel2 = "M5";
  const vehicleAsset2 = "Instagram";
  
  async function deployOneYearLockFixture() {

    const gatewayTokenContract = "0xF65b6396dF6B7e2D8a6270E3AB6c7BB08BAEF22E";
    const gatekeeperNetwork = "ignREusXmGrscGNUesoU9mxfds9AiYTezUKex2PsZV6";

    // Contracts are deployed using the first signer/account by default
    const [owner, minter1, minter2,servicer] = await ethers.getSigners();

    const VNFT = await ethers.getContractFactory("VNFT");
    const vnft = await VNFT.deploy("VNFT" , "Vehicle NFT");

    return { vnft, owner, minter1, minter2, servicer};
  }


  describe("Minting Vehicle Token", function () {

    it("Mint VNFT", async function() {
      const {vnft, owner, minter1, minter2} = await loadFixture(deployOneYearLockFixture);
  
      await vnft.connect(minter1).mintVehicle(vinKey,vehicleYear,vehicleMake,vehicleModel,vehicleAsset);
      await vnft.connect(minter1).mintVehicle(vinKey2,vehicleYear2,vehicleMake2,vehicleModel2,vehicleAsset2);
      
      // check minter token balance
      let tokenBalance = Number(await vnft.balanceOf(minter1.address));
      expect(tokenBalance).to.equal(2);

      // check owned vehicles 
      let ownedTokens = await vnft.getOwnedVehicles(minter1.address);
      expect(Number(ownedTokens[0])).to.equal(1);
      expect(Number(ownedTokens[1])).to.equal(2);

      // check vehicles one via get vehicle by Vin
      let vehicle = await vnft.getVehicleByVin(vinKey);
      expect(vehicle.UID).to.equal(vehicle.UID);
      expect(vehicle.year).to.equal(vehicle.year);
      expect(vehicle.make).to.equal(vehicle.make);
      expect(vehicle.model).to.equal(vehicle.model);
      expect(vehicle.assetUri).to.equal(vehicle.assetUri);

      // check vehicles two via get vehicle by tokenId
      let vehicle2 = await vnft.getVehicleByTokenId(2);
      expect(vehicle2.UID).to.equal(vehicle2.UID);
      expect(vehicle2.year).to.equal(vehicle2.year);
      expect(vehicle2.make).to.equal(vehicle2.make);
      expect(vehicle2.model).to.equal(vehicle2.model);
      expect(vehicle2.assetUri).to.equal(vehicle2.assetUri);
    });

    it("Transfer VNFT", async function() {
      const {vnft, owner, minter1, minter2} = await loadFixture(deployOneYearLockFixture);

      let tokenBalance2Balance = Number(await vnft.balanceOf(minter2.address));
      expect(Number(tokenBalance2Balance)).to.equal(0);

      // mint and transfer
      await vnft.connect(minter1).mintVehicle(vinKey,vehicleYear,vehicleMake,vehicleModel,vehicleAsset);
      await vnft.connect(minter1).mintVehicle(vinKey2,vehicleYear2,vehicleMake2,vehicleModel2,vehicleAsset2);
      
      // transfer by index 
      await vnft.connect(minter1).transferFrom(minter1.address,minter2.address,1);

      // check balances
      let tokenBalance = Number(await vnft.balanceOf(minter1.address));
      let tokenBalance2 = Number(await vnft.balanceOf(minter2.address));

      expect(tokenBalance).to.equal(1);
      expect(tokenBalance2).to.equal(1);

      // get owned vehicles tokens
      let ownedTokens = await vnft.getOwnedVehicles(minter1.address);
      let ownedTokens2 = await vnft.getOwnedVehicles(minter2.address);

      // check owned token arrays lengths and tokenIds
      expect(ownedTokens.length).to.equal(1);
      expect(ownedTokens2.length).to.equal(1);
      expect(Number(ownedTokens[0])).to.equal(1);
      expect(Number(ownedTokens2[0])).to.equal(2); 
    });
  });

  describe("Recalls", function () {

    it("Should Issue Recall", async function () {
      const { vnft, owner } = await loadFixture(deployOneYearLockFixture);
      const make = "BMW";
      const model = "M5";
      // Hash Make -> Model
      const key = Web3.utils.sha3(make,model);
      const vehicleYear = 1589922983;

      const title = "BMW Font Airbag";
      const description = "BMW is recalling its vehicles with Takata airbags warning owners not to drive 90,000 affected sedans and SUVs until the defective equipment is replaced. BMW models from 2000 through 2015 may be affected, the automaker wrote.";

      await vnft.issueReCall(make,model,vehicleYear,title,description);
      let recall = await vnft.getRecalls(make,model,vehicleYear);
      console.log(recall);

    });

  });

  describe("Service History", function () {

    it("Vehicle service", async function () {
      const { vnft, owner,servicer} = await loadFixture(deployOneYearLockFixture);

      const title = "BMW Font Airbag";
      const description = "BMW is recalling its vehicles with Takata airbags warning owners not to drive 90,000 affected sedans and SUVs until the defective equipment is replaced. BMW models from 2000 through 2015 may be affected, the automaker wrote.";

      await vnft.connect(servicer).addServicer("profile");
      await vnft.connect(servicer).vehicleService(vinKey,title,description);
      
      let serviceHistoryCount = await vnft.getVehicleServiceCount(vinKey);
      expect(Number(serviceHistoryCount)).to.equal(1);

      let serviceHistory = await vnft.getVehicleService(vinKey,0,1);

      let serivceAddress = serviceHistory[0][0];
      let serivceTitle = serviceHistory[0][1];
      let serviceDiscription = serviceHistory[0][2];

      expect(serivceAddress).to.equal(servicer.address);
      expect(serivceTitle).to.equal(serivceTitle);
      expect(serviceDiscription).to.equal(serviceDiscription);

    });
  });
});


