import Data.List (isInfixOf, tails, find)
import Data.Maybe (fromJust, listToMaybe)
import Data.Array (Array, listArray, (!))
import System.Environment (getArgs)
import System.Exit (exitSuccess)
import Control.Exception (handle, AsyncException(UserInterrupt))

readGenome :: FilePath -> IO String
readGenome path = do
    content <- readFile path
    return $ filter (`elem` "ACGT") content

allSubstrings :: Int -> String -> [String]
allSubstrings k genome 
    | length genome < k = []
    | otherwise = take k genome : allSubstrings k (tail genome)

isUnique :: String -> [String] -> Bool
isUnique sub genomes = not $ any (sub `isInfixOf`) genomes

findMinUniqueSub :: String -> [String] -> Maybe String
findMinUniqueSub genome targets = 
    listToMaybe $ concat [ filter (\sub -> isUnique sub targets) (allSubstrings k genome) 
                       | k <- [1..] ]

lcsDP :: String -> String -> String
lcsDP s1 s2 = reconstruct (length s1) (length s2)
  where
    n = length s1
    m = length s2
    
    dp :: Array (Int, Int) Int
    dp = listArray ((0, 0), (n, m)) [ f i j | i <- [0..n], j <- [0..m] ]
    
    f i j
      | i == 0 || j == 0 = 0
      | s1 !! (i-1) == s2 !! (j-1) = dp ! (i-1, j-1) + 1
      | otherwise = max (dp ! (i-1, j)) (dp ! (i, j-1))
    
    reconstruct i j
      | i == 0 || j == 0 = []
      | s1 !! (i-1) == s2 !! (j-1) = s1 !! (i-1) : reconstruct (i-1) (j-1)
      | otherwise = if dp ! (i-1, j) > dp ! (i, j-1)
                    then reconstruct (i-1) j
                    else reconstruct i (j-1)

main :: IO ()
main = handle (\UserInterrupt -> putStrLn "Завершение..." >> exitSuccess) $ do
    args <- getArgs
    if length args < 3 
       then putStrLn "Использование: ./virus_analysis геном1.txt геном2.txt геном3.txt"
       else do
            let [file1, file2, file3] = take 3 args
            
            putStrLn "Чтение геномов..."
            genome1 <- readGenome file1
            genome2 <- readGenome file2
            genome3 <- readGenome file3
            
            putStrLn $ "Длины геномов: " ++ show (length genome1) ++ ", " ++ 
                      show (length genome2) ++ ", " ++ show (length genome3)
            
            putStrLn "\n1. Поиск уникальной для (1), отсутствующей в (2)..."
            let unique1to2 = fromJust $ findMinUniqueSub genome1 [genome2]
            putStrLn $ "Результат: " ++ unique1to2
            
            putStrLn "\n2. Поиск уникальной для (2), отсутствующей в (1)..."
            let unique2to1 = fromJust $ findMinUniqueSub genome2 [genome1]
            putStrLn $ "Результат: " ++ unique2to1
            
            putStrLn "\n3. Поиск общей последовательности для (1) и (2)..."
            let common1and2 = fromJust $ findMinUniqueSub genome1 [genome2]
            putStrLn $ "Результат: " ++ common1and2
            
            putStrLn "\n4. Поиск уникальной для (1), отсутствующей в (2) и (3)..."
            let unique1to23 = fromJust $ findMinUniqueSub genome1 [genome2, genome3]
            putStrLn $ "Результат: " ++ unique1to23
            
            putStrLn "\n5. Поиск уникальной для (3), отсутствующей в (1) и (2)..."
            let unique3to12 = fromJust $ findMinUniqueSub genome3 [genome1, genome2]
            putStrLn $ "Результат: " ++ unique3to12
            
            putStrLn "\n6. Поиск LCS для (1) и (3)..."
            let lcs1and3 = lcsDP genome1 genome3
            let ratio = fromIntegral (length lcs1and3) / fromIntegral (length genome1)
            putStrLn $ "Длина LCS: " ++ show (length lcs1and3)
            putStrLn $ "Соотношение: " ++ show ratio
            putStrLn $ "Начало LCS: " ++ take 100 lcs1and3 ++ "..."