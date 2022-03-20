const { expect } = require("chai");
const { utils, BigNumber } = require("ethers");
const { ethers } = require("hardhat");

describe("Punkies", function () {
  it("Should return the max supply", async function () {
    const Punkies = await ethers.getContractFactory("Punkies");
    const punkies = await Punkies.deploy(100);
    await punkies.deployed();

    
    expect( await punkies.getMaxSupply() ).to.equal(100);

    // expect(await greeter.greet()).to.equal("Hello, world!");

    // const setGreetingTx = await greeter.setGreeting("Hola, mundo!");

    // wait until the transaction is mined
    //await setGreetingTx.wait();

    // expect(await greeter.greet()).to.equal("Hola, mundo!");
  });
  
  it("Should mint", async function() {
    const Punkies = await ethers.getContractFactory("Punkies");
    const punkies = await Punkies.deploy(100);
    await punkies.deployed();

    await punkies.mint();
    const tokenURI0 = await punkies.tokenURI( 0 );

    console.log(tokenURI0);
    

    await punkies.mint();
    const tokenURI1 = await punkies.tokenURI( 1 );

    console.log(tokenURI1);    
    
    
    return;

  });


  // it("Should transfer tokens for 0.1 ether", async function () {
  //   //obtengo las wallets para trabajar
  //   const [owner, w1] = await ethers.getSigners();

  //   //creo el factory para luego instanciar el contrato
  //   const Punks = await ethers.getContractFactory("PlatziPunks");
  //   //hago el deploy
  //   const punks = await Punks.deploy(100);
  //   // await punks.deployed();

  //   // obtengo balances de NTF y de ETH previo al mint
  //   // const pre_balance = await punks.balanceOf(owner.address);
  //   const pre_eth_balance = await punks.provider.getBalance(owner.address);
  //   // console.log("PRE -> Token Balance: "+ pre_balance +" / ETH Balance: "+ pre_eth_balance);

  //   // const w1_balance = await punks.provider.getBalance(w1.address);
  //   const w1_token = await punks.balanceOf(w1.address);
  //   // console.log("PRE(w1) -> Token Balance: "+ w1_token +" / ETH Balance: "+ w1_balance);

  //   // cambio de cuenta y hago el mint, le paso 0.1 eth
  //   await punks.connect(w1).mint({value: ethers.utils.parseEther("0.1")});

  //   // obtengo balances de NTF y de ETH posterior al mint
  //   // const balance = await punks.balanceOf(owner.address);
  //   const eth_balance = await punks.provider.getBalance(owner.address);
  //   // console.log("POST -> Token Balance: "+ balance +" / ETH Balance: "+ eth_balance);

  //   // const w1_balance_post = await punks.provider.getBalance(w1.address);
  //   const w1_token_post = await punks.balanceOf(w1.address);
  //   // console.log("POST(w1) -> Token Balance: "+ w1_token_post +" / ETH Balance: "+ w1_balance_post);

  //   let res = ethers.utils.formatEther(eth_balance.sub(pre_eth_balance));

  //   expect( w1_token_post ).to.equal(1);
  //   expect( res ).to.equal( "0.1" );
  // });
});
