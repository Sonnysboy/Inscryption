module Util (shuffle, chunks) where
import System.Random ( randomRIO )
import Data.Array.IO
    ( newListArray, readArray, writeArray, IOArray )
import Control.Monad (forM)
import Data.List ( unfoldr )

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

chunks :: Int -> [a] -> [[a]]
chunks n xs = takeWhile (not . null) $ unfoldr (Just . splitAt n) xs