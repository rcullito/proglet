module Main where

import MyLib (Stock(..), topPick')
import Control.Monad.Writer

type Budget = Float

swensen =
    [
        Stock "total" 216 0.3 0,
        Stock "international" 17.84 0.15 0,
        Stock "emerging" 40.50 0.05 0,
        Stock "treasury" 9.93 0.15 0,
        Stock "tips" 47.53 0.15 0,
        Stock "reits" 83.23 0.2 0
    ]

whoop :: [Stock] -> Budget -> Writer [String] [Stock]
whoop stocks budget
    | price (topPick' stocks budget) > budget = do
        tell ["Remaining budget is: " ++ show budget]
        return stocks
    | otherwise =
    let tp = topPick' stocks budget
        tpNewShares = 1 + shares tp
        oldStocks = [s | s <- stocks, s /= tp]
        newStocks = tp {shares = tpNewShares}:oldStocks
    in do
        tell ["Top pick is: " ++ show tp]
        whoop newStocks (budget - price tp)


main = print (whoop swensen 300)
