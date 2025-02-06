{-
write a number-guessing game
the first player enters the desired number
we'll deal with generating random numbers automatically next lecture
then, the second player keeps guessing the number until correct

try to separate your code into pure and impure parts
the impure parts interact with the users
the pure parts deal with game logic
each part should be a function

-}
----- pure part
check :: Eq a => a -> a -> Bool
check p1num guess
    | guess == p1num    = True
    | otherwise         = False
----- impure part
receivenumber :: IO Int
receivenumber = do
    putStrLn "please enter your number"
    num <- getLine
    return (read num)
----- impure part
player2state :: Int -> IO ()
player2state p1num = do
    putStrLn "player 2 guess number"
    guess <- receivenumber
    if check p1num guess    
        then do
            putStrLn"you win"
            return()
        else do   
            putStrLn "in correct"
            player2state p1num
----- impure part           
main :: IO ()
main = do
    putStrLn "player 1 enter number"
    num <- receivenumber
    player2state num

{-
improve your number-guessing game to limit the number of guesses
this number should also be entered by the first player

can you reuse code from the previous version?
-}
--- reuse check receivenumber ในการเช็คและรับเลข เพิ่ม limitGuess สำหรับบอกว่าค่ามากหรือน้อย
---โดยใส่ function นี่ลงไปเพิ่ม ใน player2state และเปลี่ยนให้ main ใช้ player2state'
limitGuess :: Int -> Int -> IO ()
limitGuess p1num guess
    | p1num > guess     = putStrLn "too low"
    | p1num < guess     = putStrLn "too high"

player2state' :: Int -> IO ()
player2state' p1num = do
    putStrLn "player 2 guess number"
    guess <- receivenumber
    if check p1num guess    
        then do
            putStrLn"you win"
            return()
        else do   
            limitGuess p1num guess
            putStrLn "in correct"
            player2state' p1num

main' = do
    putStrLn "player 1 enter number"
    num <- receivenumber
    player2state' num