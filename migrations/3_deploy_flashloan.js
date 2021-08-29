const PostFlashLoan = artifacts.require("PostFlashLoan.sol");

module.exports = function (deployer) {
  deployer.deploy(
    PostFlashLoan,
        '0x54D851C39fE28b2E24e354B5E8c0f09EfC65B51A',//     address _bakeryRouterAddr,
        '0x447DdE468Fb3B185d395D8D43D82D6636d69d481',// address _bakeryFactoryAddr,
        '0x9c7c1C79812a4570919E7d928aAbF6C4f31ac748',// address _wbnb_busd_pancakeLPAddr,
        
        '0xa93F69529826918A38127a76c366cA1445Fc1158', // address _pancakeRouterAddr // FoodcourtRouter,
        '0xec9c39e283a7956b3ee22816648824b9df783283', // address _pancakeFactoryAddr // FoodcourtFactory,
        '0xED7B8606270295d1b3b60b99c051de4D7D2f7ff2',// address _busd, // kDAI
        '0xDa91a1aee4d7829c118cD6218CDA2cB2C56dd010'// address _wbnb // WKUB
  );
};

// VONDER Factory: 0x447DdE468Fb3B185d395D8D43D82D6636d69d481
// VONDER Router: 0x54D851C39fE28b2E24e354B5E8c0f09EfC65B51A

// kDAI-WKUB LP: 0x9c7c1C79812a4570919E7d928aAbF6C4f31ac748
// FoodcourtRouter: 0xa93F69529826918A38127a76c366cA1445Fc1158
// FoodcourtFactory: 0xec9c39e283a7956b3ee22816648824b9df783283

// TUK: 0xAAD64d9b17f86b3ba803369b0d59392b3744ab13
// VON: 0x19dade57B0BBCE7D5E859ba02846820f5c0c2b09
// MVP: 0xDD7847deD760a8e7FB882B4A9B0e990323415ed9
// kDAI: 0xED7B8606270295d1b3b60b99c051de4D7D2f7ff2
// KKUB: 0x67eBD850304c70d983B2d1b93ea79c7CD6c3F6b5
// WKUB: 0xDa91a1aee4d7829c118cD6218CDA2cB2C56dd010