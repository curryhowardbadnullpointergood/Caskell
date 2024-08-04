{ 
module CaskellLexer where 
}

%wrapper "posn" 
$integer = [0-9]
$character = [a-zA-Z]
$special = [\!\"\#\%\&\'\(\)\*\+\,\-\.\/\:\;\<\=\>\?\[\]\\\^\_\{\|\}\~]
$spacing = [] -- TO BE DONE

tokens :-
    $white+                 ;
    "//" .*                 ; -- single line comment
    "/*" [a[^a]\n]* "*/"    ; -- multi line comment

    \:      { \p s -> Tok p TokenColon }  
    \{      { \p s -> Tok p TokenLParen } 
    \}      { \p s -> Tok p TokenRParen } 
    \(      { \p s -> Tok p TokenLBrack } 
    \)      { \p s -> Tok p TokenRBrack } 
    \[      { \p s -> Tok p TokenLBrace } 
    \]      { \p s -> Tok p TokenRBrace } 
    \*      { \p s -> Tok p TokenStar } 
    \&      { \p s -> Tok p TokenAmpersand } 
    \,      { \p s -> Tok p TokenComma } 
    \;      { \p s -> Tok p TokenSemiColon } 
    \.      { \p s -> Tok p TokenPeriod } 
    \-\>    { \p s -> Tok p TokenArrow } 
    \~      { \p s -> Tok p TokenTilda } 
    \!      { \p s -> Tok p TokenExclamation } 
    \#      { \p s -> Tok p TokenHash } 
    \$      { \p s -> Tok p TokenDollar } 
    \%      { \p s -> Tok p TokenPercent } 
    \^      { \p s -> Tok p TokenExponent } 
    \<      { \p s -> Tok p TokenLessThan } 
    \>      { \p s -> Tok p TokenGreaterThan } 
    \?      { \p s -> Tok p TokenQuestion } 
    \=      { \p s -> Tok p TokenEqual } 
    \\      { \p s -> Tok p TokenBSlash } 
    \`      { \p s -> Tok p TokenBackTick } 
    \-      { \p s -> Tok p TokenMinus } 
    \/      { \p s -> Tok p TokenFSlash } 
    \|      { \p s -> Tok p TokenBar } 
    \_      { \p s -> Tok p TokenUnderscore } 
    \+      { \p s -> Tok p TokenPlus } 


    -- Data types and their possible modifiers
    int         { \p s -> Tok p TokenInt }
    short       { \p s -> Tok p TokenShort }
    long        { \p s -> Tok p TokenLong }
    signed      { \p s -> Tok p TokenSigned }
    unsigned    { \p s -> Tok p TokenUnsigned }
    
    char        { \p s -> Tok p TokenChar }
    signed      { \p s -> Tok p TokenSigned }
    unsigned    { \p s -> Tok p TokenUnsigned }

    float       { \p s -> Tok p TokenFloat }

    double      { \p s -> Tok p TokenDouble }
    long        { \p s -> Tok p TokenLong }

    bool        { \p s -> Tok p TokenBool }





    -- String/Char Values
    \'[$integer$character$special$spacing]\'    { \p s -> Tok p (TokenCharVal (tail $ init s)) }
    \"[$integer$character$special$spacing]+\"   { \p s -> Tok p (TokenStringVal (tail $ init s)) }

    -- Number Values
    $integer+           { \p s -> Tok p (TokenIntVal (read s :: Int)) }
    $integer+.$integer+ { \p s -> Tok p (TokenDecimalVal (read s :: Double))}

    -- Boolean Values
    true    { \p s -> Tok p (TokenBoolVal True) }
    false   { \p s -> Tok p (TokenBoolVal False) }


{


data Token
    = Tok AlexPosn LangToken
    deriving (Eq, Show)
    
data LangToken
    = TokenColon
    | TokenLParen
    | TokenRParen
    | TokenLBrack
    | TokenRBrack
    | TokenLBrace
    | TokenRBrace
    | TokenStar
    | TokenAmpersand
    | TokenComma
    | TokenSemiColon
    | TokenPeriod
    | TokenArrow
    | TokenTilda
    | TokenExclamation
    | TokenHash
    | TokenDollar
    | TokenPercent
    | TokenExponent
    | TokenLessThan
    | TokenGreaterThan
    | TokenQuestion
    | TokenEqual
    | TokenBSlash
    | TokenBackTick
    | TokenMinus
    | TokenFSlash
    | TokenBar
    | TokenUnderscore
    | TokenPlus
    | TokenInt
    | TokenShort
    | TokenLong
    | TokenSigned
    | TokenUnsigned
    | TokenChar
    | TokenFloat
    | TokenDouble
    | TokenBool

    | TokenCharVal String
    | TokenStringVal String
    | TokenIntVal Int
    | TokenDecimalVal Double 
    | TokenBoolVal Bool
    
    deriving (Eq, Show)
}