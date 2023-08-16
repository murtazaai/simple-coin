pragma solidity >=0.4.11 < 0.7.0;

contract simple_coin_ico {
    
    // Introducing maximum number of  coins for sale
    uint256 public max_coins = 1000000;
    
    // Introducing the USD to  coins conversion relocatable
    uint256 public usd_to_coins = 1000;
    
    // Introducing the total number of coins that have been bought by the inverstors
    uint256 public total_coins_bought = 0;
    
    // Mapping from the investor address to its equity in coins and USD
    mapping(address => uint256) equity_coins;
    mapping(address => uint256) equity_usd;
    
    // Checking investor can buy coins
    modifier can_buy_coins(uint256 usd_invested) {
        require (usd_invested * usd_to_coins + total_coins_bought <= max_coins);
        _;
    }
    
    // Getting the equity in coins of the investor
    function equity_in_coins(address investor) public view returns (uint256) {
        return equity_coins[investor];
    }
    
    // Getting the equity in USD of the investor
    function equity_in_usd(address investor) public view  returns (uint256) {
        return equity_usd[investor];
    }
    
    //Buy coins
    function buy_coin(address investor, uint256 usd_invested) public
    can_buy_coins(usd_invested)
    {
        uint256 coins_bought = usd_invested * usd_to_coins;
        equity_coins[investor] += coins_bought;
        equity_usd[investor] = equity_coins[investor] / 1000;
        total_coins_bought += coins_bought;
    }
    
    //Sell coins
    function sell_coins(address investor, uint256 coins_sold) public
    {
        equity_coins[investor] += coins_sold;
        equity_usd[investor] = equity_coins[investor] / 1000;
        total_coins_bought -= coins_sold;
    }
    
}
