const deploy = async () => {
    const [deployer] = await ethers.getSigners(); // Signers contiene la informacion de configuracion (llaves)

    console.log("Deploying contract with the account: ", deployer.address);
    
    const Punkies = await ethers.getContractFactory("Punkies"); //contiene informacion del contracto
    const deployed = await Punkies.deploy(100);

    console.log("Punkies is deployed at: ", deployed.address); // direccion del contrato
}

deploy()
    .then(() => process.exit(0) )
    .catch((err) => {
        console.log(err);
        process.exit(1);
    });
