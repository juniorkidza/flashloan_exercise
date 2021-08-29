pragma solidity ^0.6.0;


import './interfaces/IERC20.sol';
import './interfaces/IUniswapV2Factory.sol';
import './interfaces/IUniswapV2Pair.sol';
import './interfaces/IUniswapV2Router01.sol';
import './UniswapV2Library.sol';
import './interfaces/IUniswapV2Router02.sol';

contract PostFlashLoan{
    address public owner;
    
    //token
    address public wbnbAddr;
    address public busdAddr;
    
    //Pancake
    address public wbnb_busd_pancakeLPAddr;
    address public pancakeRouterAddr;
    address public pancakeFactoryAddr;
    IUniswapV2Router01 public  pancakeRouter;
    
    //Bakery
    address public wbnb_busd_bakeryLPAddr;
    address public bakeryRouterAddr;
    address public bakeryFactoryAddr;
    
    event Log(uint amout);
    
    constructor(
        address _bakeryRouterAddr,
        address _bakeryFactoryAddr,
        address _wbnb_busd_pancakeLPAddr,
        address _pancakeRouterAddr,
        address _pancakeFactoryAddr,
        address _busd,
        address _wbnb
        ) public {
        //me
        owner = msg.sender;
        
        //Bakery
        //wbnb_busd_bakeryLPAddr = ;
        bakeryRouterAddr = _bakeryRouterAddr;
        bakeryFactoryAddr = _bakeryFactoryAddr;
        
        //Pancake
        wbnb_busd_pancakeLPAddr = _wbnb_busd_pancakeLPAddr;
        pancakeRouterAddr = _pancakeRouterAddr;
        pancakeFactoryAddr = _pancakeFactoryAddr;
        
        //token
        busdAddr = _busd;
        wbnbAddr = _wbnb;
    }
    
    // flash swap for busd, busd is amount1, wbnb is amount0
    function pancakeFlashLoan(
        uint amount0,
        uint amount1,
        address lpAddress
    ) external {
        IUniswapV2Pair(lpAddress).swap(
            amount0,
            amount1,
            address(this),
            bytes("something")
        );
    }
    
    function foodcourtCall(
        address _sender,
        uint _amount0,
        uint _amount1,
        bytes calldata _data
    ) external {
        uint amountToken = _amount0 == 0 ? _amount1 : _amount0;
        address[] memory path = new address[](2);
        path[0] = busdAddr;
        path[1] = wbnbAddr;
        
        //need to swap on another router (e.g. flash loan on Pancake need to swap on Bakeryswap), otherwise, PANCAKE: Locked will be thrown
        uint amountOutMin = IUniswapV2Router02(bakeryRouterAddr).getAmountsOut(
            amountToken,
            path
        )[1];
        // define deadline to be automatically renew to prevent "Expired" error
        uint deadline = now + 20 minutes;
        IERC20 busd = IERC20(busdAddr);
        busd.approve(address(bakeryRouterAddr), amountToken);
        //TO FIX: on BakerySwap, WBNB == 0x094616f0bdfb0b526bd735bf66eca0ad254ca81f, otherwise, INVALID_PATH is thrown
        uint amountReceived = IUniswapV2Router02(bakeryRouterAddr).swapExactTokensForTokens(
            amountToken,
            amountOutMin,
            path,
            address(this),
            deadline
        )[1];
        
        //repay WBNB to Pancake LP
        address[] memory pathRepay = new address[](2);
        pathRepay[0] = wbnbAddr; //y
        pathRepay[1] = busdAddr; //x
        uint amountRepay = UniswapV2Library.getAmountsIn(
            pancakeFactoryAddr,
            amountToken,
            pathRepay
        )[0];
        
        IERC20 otherToken = IERC20(wbnbAddr);
        otherToken.transfer(wbnb_busd_pancakeLPAddr, amountRepay);
        // payable(address(msg.sender)).transfer(getBalance());
    }
    
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    function getBalance(address _token) public view returns (uint) {
        return IERC20(_token).balanceOf(address(this));
    }
    
    function _transFer(address _to, address _token) public {
        uint _balance = IERC20(_token).balanceOf(address(this));
        IERC20(_token).transfer(_to, _balance);
    }
    
    function _transFer(address _addr) public {
        payable(address(_addr)).transfer(address(this).balance);
    }
    
    fallback() payable external {
        
    }
    
    receive() payable external {
        
    }
    
}