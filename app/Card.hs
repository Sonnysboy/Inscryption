module Card where
import Data.Char (toUpper)
import Control.Monad (join)
import Currency ( Currency(Bone) )
import Data.List ( isSubsequenceOf, transpose )


-- CARD

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
        drawCosts c = foldMap ((\x -> "|" ++ x ++ replicate ((nameTBD - length x `div` 10) - if "bone" `isSubsequenceOf` x then abs $ 9 - length x else 1) ' ' <> "|\n") . (\(i, x) -> if x == Bone then show x <> (" x" <> show i) else join $ replicate i (show x))) (costs c)
        format c = sep ++ "\n" ++ justifyLeft nameTBD ' ' ("|    " ++ map toUpper (name c)) ++ "|" ++ "\n\
       \" <> sep <> "\n" <> drawCosts c <> join (replicate 5 (justifyLeft nameTBD ' ' "|" ++ "|\n"))

justifyLeft :: Int -> a -> [a] -> [a]
justifyLeft  n c s = s ++ replicate (n - length s) c

-- render a hand of cards 
renderCards :: [Card] -> String
renderCards = unlines . map unwords . transpose . map (lines . show)

{-
 A hand of cards
-}
newtype Hand = Hand {
    cards :: [Card]
}

instance Show Hand where
    show = renderCards . cards

{-

-}
