// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployFundMe is Script {
    function run() external returns (FundMe) {
        //used to get the address of the price feed
        HelperConfig helperConfig = new HelperConfig();
        address ethUsdPriceFeed = helperConfig.activeNetworkConfig();

        vm.startBroadcast();
        FundMe fundMe = new FundMe(ethUsdPriceFeed);
        vm.stopBroadcast();
        return fundMe;
    }
}
/* 
- When we we deploy the contract we need to put what chain
    we are on. Like if we are on the Sepolia chain we need to put 
    SEPOLIA_RPC_URL which we get from the .env file. 

- The heplerConfig has the priceFeed address fro different chains.
    Whenever we deploy a contract we put the RPC were using, the helperConfig
    has a constuctor that checks if the RPCs chainid is 11155111, if it is
    then it returns the priceFeed address for that chain.
    We call helperConfig. by creating a new address on line 12, 
    on line 13 it connects to the helperConfig contract with dot notation 

*/
