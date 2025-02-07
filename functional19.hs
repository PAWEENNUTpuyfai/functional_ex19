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
check p1num guess = guess == p1num

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
            putStrLn "Incorrect."
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
--- reuse check receivenumber ในการเช็คและรับเลข เพิ่ม countAttempt สำหรับนับว่ามีการทายมาแล้วกี่ครั้ง
---โดยใส่ function countAttempt นี่ลงไปเพิ่ม และเรียกใช้ player2stateง และให้มีการ recursive ที่countAttempt แทน
-- เปลี่ยนให้ main รับค่าเลขของการจำกัดการนับเพิ่ม และเรียกใช้ countAttempt
player2state' :: Int -> IO ()
player2state' p1num = do
    putStrLn "player 2 guess number"
    guess <- receivenumber
    if check p1num guess    
        then do
            putStrLn"you win"
            return()
        else do   
            putStrLn "Incorrect."

countAttempt :: (Eq t, Num t, Show t) => Int -> t -> IO ()
countAttempt p1num attempt
    |attempt == 0 = putStrLn "Out of guesses! You lose."
    |otherwise = do
        putStrLn $ "You have " ++ show attempt ++ " attempts left."
        player2state' p1num 
        countAttempt p1num (attempt -1)

main' :: IO ()
main' = do
    putStrLn "player 1 enter number"
    num <- receivenumber
    putStrLn "Player 1 enter the number of attempts for Player 2"
    attempt <- receivenumber
    countAttempt num attempt
