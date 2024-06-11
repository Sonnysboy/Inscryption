module Turn where

import Card
import Currency
import Data.Maybe (fromJust, isJust, isNothing)
import Game

newtype Turn a b = Turn
  { runTurn :: Game -> Game
  }

-- | An action performed on something. The bool on the end is if m it
newtype Action a b = Action
  { perform :: (Player -> a -> b, Game)
  }

-- | Performs an action off of two things in a row, which for now are just cards..
newtype RowAction a = RowAction {runRowAction :: Row -> a -> Row}

-- | Attack a card, given its row, an attacking card, and a victim card.
attack :: RowAction (Card, Card)
attack = RowAction $ \affectedRow (attacker, victim) -> updateRow (applyDamage (damage attacker)) (fromJust (findRowIndex victim affectedRow)) affectedRow

-- | Given a row and a card, attempt to play it on a slot.
--
-- There are a few reasons why this would return @Nothing@:
--
-- 1. The player cannot make enough blood off of sacrificing.
-- 2. That slot is taken.
playCard ::
  Row ->
  Int ->
  Card ->
  Either (String, Row) Row
playCard r at c
  | isJust (atRowIndex r at) = Left ("This slot is taken", r)
  | isNothing (costs c) = Right (updateRow (const $ Just c) at r)
  | otherwise = do
      let required = fromJust $ costs c
      let total what = sum . map fst . filter ((== what) . snd)
      let bloodRequired = total Blood required
      let boneRequired = total Bone required
      -- so far we only handle blood
      -- each card sacrificed is worth 1 blood each.
      if length (map isJust $ rowToArray r) < bloodRequired
        then
          Left ("You cannot make enough blood", r)
        else do
          Right $ updateRow (const $ Just c) at r