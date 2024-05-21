module Util (shuffle) where
import System.Random
import Data.Array.IO
    ( newListArray, readArray, writeArray, IOArray )
import Control.Monad (forM)

-- shuffle array
shuffle :: [a] -> IO [a]
shuffle xs = do
        ar <- newArray n xs
        forM [1..n] $ \i -> do
            j <- randomRIO (i,n)
            vi <- readArray ar i
            vj <- readArray ar j
            writeArray ar j vi
            return vj
  where
    n = length xs
    newArray :: Int -> [a] -> IO (IOArray Int a)
    newArray =  newListArray . (,)1 