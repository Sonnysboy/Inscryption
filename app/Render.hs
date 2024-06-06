{-# LANGUAGE ExtendedDefaultRules #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module Render where

import Text.Printf (printf)

printTitleCard :: IO ()
printTitleCard = putStrLn $ red " ██▓ ███▄    █   ██████  ▄████▄   ██▀███ ▓██   ██▓ ██▓███  ▄▄▄█████▓ ██▓ ▒█████   ███▄    █\n▓██▒ ██ ▀█   █ ▒██    ▒ ▒██▀ ▀█  ▓██ ▒ ██▒▒██  ██▒▓██░  ██▒▓  ██▒ ▓▒▓██▒▒██▒  ██▒ ██ ▀█   █ \n▒██▒▓██  ▀█ ██▒░ ▓██▄   ▒▓█    ▄ ▓██ ░▄█ ▒ ▒██ ██░▓██░ ██▓▒▒ ▓██░ ▒░▒██▒▒██░  ██▒▓██  ▀█ ██▒\n░██░▓██▒  ▐▌██▒  ▒   ██▒▒▓▓▄ ▄██▒▒██▀▀█▄   ░ ▐██▓░▒██▄█▓▒ ▒░ ▓██▓ ░ ░██░▒██   ██░▓██▒  ▐▌██▒\n░██░▒██░   ▓██░▒██████▒▒▒ ▓███▀ ░░██▓ ▒██▒ ░ ██▒▓░▒██▒ ░  ░  ▒██▒ ░ ░██░░ ████▓▒░▒██░   ▓██░\n░▓  ░ ▒░   ▒ ▒ ▒ ▒▓▒ ▒ ░░ ░▒ ▒  ░░ ▒▓ ░▒▓░  ██▒▒▒ ▒▓▒░ ░  ░  ▒ ░░   ░▓  ░ ▒░▒░▒░ ░ ▒░   ▒ ▒ \n ▒ ░░ ░░   ░ ▒░░ ░▒  ░ ░  ░  ▒     ░▒ ░ ▒░▓██ ░▒░ ░▒ ░         ░     ▒ ░  ░ ▒ ▒░ ░ ░░   ░ ▒░\n▒ ░   ░   ░ ░ ░  ░  ░  ░          ░░   ░ ▒ ▒ ░░  ░░         ░       ▒ ░░ ░ ░ ▒     ░   ░ ░ \n ░           ░       ░  ░ ░         ░     ░ ░                        ░      ░ ░           ░ \n░                 ░ ░                                               "

black :: String -> String
black = printf "\x1b[30m%s\x1b[0m"

red :: String -> String
red = printf "\x1b[31m%s\x1b[0m"

green :: String -> String
green = printf "\x1b[32m%s\x1b[0m"

yellow :: String -> String
yellow = printf "\x1b[33m%s\x1b[0m"

blue :: String -> String
blue = printf "\x1b[34m%s\x1b[0m"

magenta :: String -> String
magenta = printf "\x1b[35m%s\x1b[0m"

cyan :: String -> String
cyan = printf "\x1b[36m%s\x1b[0m"

white :: String -> String
white = printf "\x1b[37m%s\x1b[0m"

bold :: String -> String
bold = printf "\x1b[1m%s\x1b[0m"