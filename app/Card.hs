module Card where
import Data.Char (toUpper)
import Control.Monad (join)
import Currency
-- todo we need the thingy
newtype CardEffect a b = CardEffect (a -> b)

data Card = Card {
    damage :: Int,
    health :: Int,
    name :: String,
    costs :: [(Int, Currency)]
    -- effects :: Maybe [CardEffect]
}

instance Show Card where
  show card = format card
    where
        nameTBD = (10+) $ length $ name card
        sep = replicate (nameTBD+1) '-'
        format c = sep ++ "\n" ++ justifyLeft nameTBD ' ' ("|    " ++ map toUpper (name c)) ++ "|" ++ "\n\
        \" <> sep <> "\n" <> join (replicate 5 (justifyLeft nameTBD ' ' "|" ++ "|\n"))
justifyLeft, justifyRight :: Int -> a -> [a] -> [a]
justifyLeft  n c s = s ++ replicate (n - length s) c
justifyRight n c s = replicate (n - length s) c ++ s