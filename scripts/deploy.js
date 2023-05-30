// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
  const gateKeeperNetwork = "ignREusXmGrscGNUesoU9mxfds9AiYTezUKex2PsZV6"
  const gatewayTokenContract = "0xF65b6396dF6B7e2D8a6270E3AB6c7BB08BAEF22E"

  const VNFT = await hre.ethers.getContractFactory("VNFT");
  const vnft = await VNFT.deploy(gatewayTokenContract,4, "VNFT" , "Vehicle NFT");

  console.log(`VNFT deployed to ${vnft.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
