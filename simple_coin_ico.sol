pragma solidity >=0.4.11 < 0.7.0;

contract simple_coin_ico {
    
    // Introducing maximum number of python coins for sale
    uint256 public max_pythoncoins = 1000000;
    
    // Introducing the USD to python coins conversion relocatable
    uint256 public usd_to_pythoncoins = 1000;
    
    // Introducing the total number of pythoncoins that have been bought by the inverstors
    uint256 public total_pythoncoins_bought = 0;
    
    // Mapping from the investor address to its equity in pythoncoins and USD
    mapping(address => uint256) equity_pythoncoins;
    mapping(address => uint256) equity_usd;
    
    // Checking investor can buy pythoncoins
    modifier can_buy_pythoncoins(uint256 usd_invested) {
        require (usd_invested * usd_to_pythoncoins + total_pythoncoins_bought <= max_pythoncoins);
        _;
    }
    
    // Getting the equity in pythoncoins of the investor
    function equity_in_pythoncoins(address investor) public view returns (uint256) {
        return equity_pythoncoins[investor];
    }
    
    // Getting the equity in USD of the investor
    function equity_in_usd(address investor) public view  returns (uint256) {
        return equity_usd[investor];
    }
    
    //Buy pythoncoins
    function buy_pythoncoin(address investor, uint256 usd_invested) public
    can_buy_pythoncoins(usd_invested)
    {
        uint256 pythoncoins_bought = usd_invested * usd_to_pythoncoins;
        equity_pythoncoins[investor] += pythoncoins_bought;
        equity_usd[investor] = equity_pythoncoins[investor] / 1000;
        total_pythoncoins_bought += pythoncoins_bought;
    }
    
    //Sell pythoncoins
    function sell_pythoncoins(address investor, uint256 pythoncoins_sold) public
    {
        equity_pythoncoins[investor] += pythoncoins_sold;
        equity_usd[investor] = equity_pythoncoins[investor] / 1000;
        total_pythoncoins_bought -= pythoncoins_sold;
    }
    
}
