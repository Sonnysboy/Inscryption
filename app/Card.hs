module Inscryption.Card where
-- todo we need the thingy
newtype CardEffect a b = CardEffect (a -> b)

data Card b = Card {
    damage :: Int,
    health :: Int,
    effects :: Maybe [CardEffect]
}