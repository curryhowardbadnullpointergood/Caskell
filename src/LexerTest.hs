import CaskellLexer
import Control.Exception
import System.IO
import System.Environment ( getArgs )



main :: IO ()
main = do
    catch (main' "123") noLex

main' :: String -> IO ()
main' sourceText = do
    let lexedProg = alexScanTokens sourceText
    putStrLn ("Lexed As: \n" ++ replicate 50 '-'  ++ "\n" ++ show lexedProg ++ "\n" ++ replicate 50 '-')


noLex :: ErrorCall -> IO ()
noLex e = do let err =  show e
             hPutStr stderr ("Problem with lexing: " ++ err)
             return ()
