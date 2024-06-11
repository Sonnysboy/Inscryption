{-# LANGUAGE TypeApplications #-}

-- | This module defines ways of the user interacting with the console.
module Interface where

import Control.Monad.IO.Class (MonadIO (liftIO))
import Data.Array ( Ix(inRange) )
import Data.Functor ( (<&>) )


-- | Returns the option as well , or Nothing if the user didn't pick one
pickFromOptions :: [(String, a)] -> IO (Maybe a)
pickFromOptions options = do
  putStrLn "\n ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░ ░▒▓██████▓▒░ ░▒▓███████▓▒░▒▓████████▓▒░                      \n░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░                             \n░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░                             \n░▒▓█▓▒░      ░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓██████▓▒░                        \n░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░                             \n░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░      ░▒▓█▓▒░▒▓█▓▒░      ░▒▓██▓▒░▒▓██▓▒░▒▓██▓▒░ \n ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓███████▓▒░░▒▓████████▓▒░▒▓██▓▒░▒▓██▓▒░▒▓██▓▒░ \n                                                                                                     \n                                                                                                     \n"
  let prompt = unlines $ zipWith (\n o -> show @Int n <> ". " <> fst o) [1 ..] options
  putStr prompt
  -- ok this isnt really readable but it's cool
  liftIO getLine <&> (\y -> if inRange (1, length options) y then Just $ snd $ options !! y else Nothing) . read