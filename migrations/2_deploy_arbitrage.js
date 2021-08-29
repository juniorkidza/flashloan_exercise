const Arbitrage = artifacts.require("Arbitrage.sol");

module.exports = function (deployer) {
  deployer.deploy(
    Arbitrage,
    '0x447DdE468Fb3B185d395D8D43D82D6636d69d481', //VONDER factory
    '0xa93F69529826918A38127a76c366cA1445Fc1158', //TUKTUK router
  );
};

// MVP: 0xDD7847deD760a8e7FB882B4A9B0e990323415ed9
// kDAI: 0xED7B8606270295d1b3b60b99c051de4D7D2f7ff2
// 