import Control.Arrow ((&&&))
import Data.Function
import Data.List
import System.IO

main = do
    line <- getLine
    let fish = map (read::String->Int) $ split line
    let groups = map (head &&& length) . group . sort $ fish
    print $ answer $ loop 256 groups

split str = case break (== ',') str of
    (a, ',':b) -> a : split b
    (a, "") -> [a]

tick (h:[]) = tick' h
tick (h:xs) = (tick' h) ++ (tick xs)

tick' (0, c) = [(6, c), (8, c)]
tick' (i, c) = [(i-1, c)]

loop 0 xs = grp xs
loop c xs = loop (c-1) $ grp $ tick xs

grp xs = grp' $ sortBy (compare `on` fst) $ xs

grp' [] = []
grp' ((i, c):[]) = [(i, c)]
grp' ((i1, c1):(i2, c2):xs)
    | i1 == i2 = (i1, (c1 + c2)):grp xs
    | otherwise = (i1, c1):(i2, c2):grp xs

answer [] = 0
answer ((i, c):[]) = c
answer ((i1, c1):(i2, c2):xs) = (c1 + c2) + (answer xs)
