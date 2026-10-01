module Main where

import Parser

main :: IO ()
main = do
    putStrLn "Voer JSON in:"
    input <- getLine
    print (parseJson input)