{-# LANGUAGE DerivingVia #-}
module Card (Card (..), CardEffect, Hand (..), renderCards, squirrel, Deck (Deck), next, chunks, contents) where

import Control.Arrow (Arrow ((&&&)))
import Control.Monad (join)
import Currency (Currency (Bone))
import Data.Char (toUpper)
import Data.List (intercalate, isSubsequenceOf, transpose)
import Render (bold, red)
import Util (chunks)

-- CARD

-- todo we need the thingy
newtype CardEffect a b = CardEffect (a -> b)

data Card = Card
  { damage :: Int,
    health :: Int,
    name :: String,
    costs :: Maybe [(Int, Currency)]
    -- effects :: Maybe [CardEffect]
  }

instance Show Card where
  show card = format card
    where
      nameTBD = (10 +) $ length $ name card
      sep = replicate (nameTBD + 1) '-'
      drawCosts c = maybe "" (foldMap ((\x -> "|" ++ x ++ replicate ((nameTBD - length x `div` 10) - if "bone" `isSubsequenceOf` x then abs $ 9 - length x else 1) ' ' <> "|\n") . (\(i, x) -> if x == Bone then show x <> (" x" <> show i) else join $ replicate i (show x)))) (costs c)
      format c =
        sep -- bro I swear to god i did not format it like this.
          ++ "\n"
          ++ justifyLeft (nameTBD + 8) ' ' ("|    " <> bold (map toUpper (name c)))
          ++ "|"
          ++ "\n\
             \"
            <> sep
            <> "\n"
            <> drawCosts c
            <> join (replicate 3 (justifyLeft nameTBD ' ' "|" ++ "|\n"))
            <> sep
            <> "\n"
            <> "| "
          ++ justifyLeft (nameTBD + 2) ' ' (bold $ show $ damage c) <> "" <> bold (show (health c) <> red " ❦ ") <> "|"

justifyLeft :: Int -> a -> [a] -> [a]
justifyLeft n c s = s ++ replicate (n - length s) c

-- render a hand of cards
renderCards :: [Card] -> String
renderCards = unlines . map unwords . transpose . map (lines . show)

{-
 A hand of cards
-}
newtype Hand = Hand
  { cards :: [Card]
  }

instance Monoid Hand where
  mempty = Hand mempty

instance Semigroup Hand where
  (Hand one) <> (Hand two) = Hand $ one <> two

instance Show Hand where
  show = intercalate "\n" . map renderCards . chunks 6 . cards

{-
    DECKS AND SQUIRRELS
-}
squirrel :: Card
squirrel = Card 0 0 "Squirrel" Nothing -- squirrels cost nothing

--- This is different from a Hand. This is where you draw cards from.
newtype Deck = Deck
  { contents :: [Card]
  }

instance Show Deck where -- dont *really* need this but
  show = intercalate "\n" . map renderCards . chunks 6 . contents

-- returns Nothing if the deck is empty. Otherwise, draws the next card from the deck and returns the new Deck and also the card.
next :: Deck -> Maybe (Deck, Card)
next (Deck []) = Nothing
next (Deck cs) = Just $ ((Deck . tail) &&& head) cs
