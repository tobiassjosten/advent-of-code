import Data.List
import System.IO

main = do
    z <- getLine
    let xs = map (read::String->Int) $ split z
    print $ loop 80 xs

split str = case break (== ',') str of
    (a, ',':b) -> a : split b
    (a, "") -> [a]

tick xs = concat $ map (tick') xs

tick' 0 = [6, 8]
tick' x = [x-1]

loop :: Int -> [Int] -> Int
loop 0 xs = length xs
loop c xs = loop (c-1) $ tick xs
