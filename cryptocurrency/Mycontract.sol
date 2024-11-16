// mycoin ICO
// SPDX-License-Identifier: MIT

//version of compiler
pragma solidity ^0.8.0;

contract mycoin_ico{
    
    // introducing the max number of mycoins available for sale
    uint public max_mycoins = 1000000;

    // introducing the USD to mycoin conversion rate
    uint public usd_to_mycoins = 1000;

    // introducing the total number of mycoins that have been bought by the investors
    uint public total_mycoins_bought = 0;

    // Mapping from the investor address to its equity in mycoins and USD
    mapping(address => uint) equity_mycoins;
    mapping(address => uint) equity_usd;

    //checking if investor can buy mycoins
    modifier can_buy_mycoins(uint usd_invested) {
        require(usd_invested * usd_to_mycoins + total_mycoins_bought <= max_mycoins );
        _;
    }

    //gettting equity in mycoins of an investor
    function equity_in_mycoins(address investor) external view returns(uint) {
        return equity_mycoins[investor];
    }

    //getting equity in usd of an investor
    function equity_in_usd(address investor) external view returns(uint) {
        return equity_usd[investor];
    }

    //buying mycoins
    function buy_mycoins(address investor, uint usd_invested) external 
    can_buy_mycoins(usd_invested) {
        uint mycoins_bought = usd_invested * usd_to_mycoins;
        equity_mycoins[investor] += mycoins_bought;
        equity_usd[investor] = equity_mycoins[investor] / 1000;
        total_mycoins_bought += mycoins_bought;
    }

    //selling mycoins
    function sell_mycoins(address investor, uint mycoins_sold) external {
        equity_mycoins[investor] -= mycoins_sold;
        equity_usd[investor] = equity_mycoins[investor] / 1000;
        total_mycoins_bought -= mycoins_sold;
    }

}