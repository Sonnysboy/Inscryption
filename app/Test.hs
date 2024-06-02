module Test where
import Card (Card (..))


testCard = Card 1 2 "Monkey" Nothing
testCard2 = Card 1 2 "Monkey Two" Nothing

testDeck = replicate 20 testCard


