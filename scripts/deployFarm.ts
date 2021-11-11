import {ethers} from 'hardhat';


const main = async()=>{
    const [deployer] = await ethers.getSigners();
    console.log(`Deploying contracts with ${deployer.address}`);

    const MockERC20 = await ethers.getContractFactory("MockERC20");
    const mockDai = await MockERC20.deploy("MockDai", "mDai");
    console.log(`MockDai address is: ${mockDai.address}`);

    const CrtFarm = await ethers.getContractFactory("CarrotFarm");
    const crtFarm = await CrtFarm.deploy();
    console.log(`CarrotFarm address is: ${crtFarm.address}`);
    

}

main()
    .then(()=> process.exit(0))
    .catch(error=>{
        console.log(error)
        process.exit(1)
})