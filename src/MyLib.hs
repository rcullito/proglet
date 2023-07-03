module MyLib (Stock(..), topPick') where
import Data.List

data Stock =
    Stock {
        name :: String,
        price :: Float,
        perc :: Float,
        shares :: Float
    } deriving (Show, Eq)

type Budget = Float

alreadyAllocated :: Stock -> Float
alreadyAllocated = (*) <$> shares <*> price

calcDiff :: Budget -> Stock -> Float
calcDiff budget stock  = perc stock - (alreadyAllocated stock / budget)

vietname = Stock "emerging" 40.50 0.05 3

topPick' :: [Stock] -> Budget -> Stock
topPick' stocks b =
    let alreadyAllocated = sum (map (\x -> price x * shares x) stocks)
        total = alreadyAllocated + b
        compareDiffs x y =
            compare (calcDiff total x) (calcDiff total y)
    in maximumBy compareDiffs stocks
