{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# OPTIONS_GHC -Wno-unused-top-binds #-}

module Game where

import Card (Card (Card), Deck (..), Hand (..), modifyHand, next, renderCards)
import Data.List (elemIndex)
import Data.Maybe (fromMaybe)

data Player = Player
  { -- | The cards in the player's hand.
    hand :: Hand,
    -- | The deck of cards the player is drawing from.
    deck :: Deck,
    -- | The player's row.
    row :: Row
  }
  deriving (Show)

-- | Draw a card on a player.
drawCard :: Player -> (Maybe Card, Player)
drawCard p = case next $ deck p of
  Just (rest, drawn) -> (Just drawn, p {hand = modifyHand (drawn :) (hand p), deck = rest})
  Nothing -> (Nothing, p)

data Game = Game
  { players :: (Player, Player),
    -- | goes from -4 to 4
    scale :: Int,
    -- | The board the game is being played on. Equal to Board (row playerOne, row playerTwo)
    board :: Board
  }

playerOne, playerTwo :: Game -> Player
playerOne = fst . players
playerTwo = snd . players

data Row = Row
  { slot1 :: Maybe Card,
    slot2 :: Maybe Card,
    slot3 :: Maybe Card,
    slot4 :: Maybe Card
  }

-- | returns the four slots in an array
rowToArray :: Row -> [Maybe Card]
rowToArray r = [slot1 r, slot2 r, slot3 r, slot4 r]

blankCard :: Card
blankCard = Card 0 0 "    " Nothing -- this is just a placeholder thing i should probably replace

instance Show Row where
  show me =
    renderCards $
      map
        (fromMaybe blankCard)
        [slot1 me, slot2 me, slot3 me, slot4 me]

-- | Set a slot in a row to a card, regardless of if it's taken.
set :: Card -> Int -> Row -> Row
set c 1 r = r {slot1 = Just c}
set c 2 r = r {slot2 = Just c}
set c 3 r = r {slot3 = Just c}
set c 4 r = r {slot4 = Just c}
set _ _ _ = error "Invalid"

-- | Update a row's card at a given slot given an index and a row, applying the transformation function to it.
updateRow :: (Card -> Maybe Card) -> Int -> Row -> Row
updateRow f 1 r = r {slot1 = f =<< slot1 r}
updateRow f 2 r = r {slot2 = f =<< slot2 r}
updateRow f 3 r = r {slot3 = f =<< slot3 r}
updateRow f 4 r = r {slot4 = f =<< slot4 r}
updateRow _ _ _ = error "Invalid"

atRowIndex :: Row -> Int -> Maybe Card
atRowIndex r 1 = slot1 r
atRowIndex r 2 = slot2 r
atRowIndex r 3 = slot3 r
atRowIndex r 4 = slot4 r
atRowIndex _ _ = error "Invalid"

findRowIndex :: Card -> Row -> Maybe Int
findRowIndex what r = elemIndex (Just what) [slot1 r, slot2 r, slot3 r, slot4 r]

-- | A board, Having two rows, each having four slots that can be taken by cards.
data Board = Board
  { row1 :: Row,
    row2 :: Row
  }

instance Show Board where
  show b = show (row1 b) ++ "\n" ++ show (row2 b)

-- | Update a card on a board.
updateBoard :: (Card -> Maybe Card) -> Int -> Int -> Board -> Board
updateBoard f 1 i b = b {row1 = updateRow f i (row1 b)}
updateBoard f 2 i b = b {row2 = updateRow f i (row2 b)}
updateBoard _ _ _ _ = error "Invalid Parameters"
