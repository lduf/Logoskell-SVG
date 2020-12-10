-- import Text.Regex
-- Datas
-- -- Datas pour gérer le logoskell
data Instruction = Forward Int | Left Int | Right Int | Repeat Int [Instruction] deriving(Show, Read)
type Programme = [Instruction]

-- -- Datas pour gérer le dessing / le svg
data Coordonnee = Coordonnee Float Float deriving(Show, Read, Eq, Ord)
type Angle = Float
data Crayon  = Crayon Coordonnee Angle deriving(Show, Read, Eq, Ord)

-- Variables
color = "red"
baseSVG = "<?xml version='1.0' encoding='utf-8'?> \n <svg xmlns='http://www.w3.org/2000/svg' version='1.1' width='400' height='400'> \n <title>Title</title> \n"
svgLineEX = "<line x1='100.00' y1='100.00' x2='200.00' y2='100.00' stroke='"++color++"' />"
regexLogoskell ="^\\[.*\\]$"
svg = ""

-- Coordonnee ajout distance crayon
newCrayon :: Crayon -> Float -> Float-> Crayon
newCrayon (Crayon (Coordonnee x y) (Angle a)) dist 0 = Crayon (Coordonnee (x + dist*(cos a)) (y + dist*(sin a))) Angle a
newCrayon (Crayon coo (Angle a)) 0 angle = Crayon coo (Angle (a+angle))

-- Generation d'une ligne SVG avec des coordonnées

svgLine :: Crayon -> Crayon ->String
svgLine (coo1 (Angle _)) (coo2 (Angle _)) = svgLinecoo coo1 coo2 


svgLinecoo :: Coordonnee -> Coordonnee ->String
svgLinecoo (Coordonnee x1 y1) (Coordonnee x2 y2) = "<line x1='"++ show x1 ++"' y1='"++ show y1 ++"' x2='"++ show x2 ++"' y2='"++ show y2 ++"' stroke='"++color++"' /> \n"

svgLinecoo :: Coordonnee -> Coordonnee ->String
svgLinecoo (Coordonnee x1 y1) (Coordonnee x2 y2) = "<line x1='"++ show x1 ++"' y1='"++ show y1 ++"' x2='"++ show x2 ++"' y2='"++ show y2 ++"' stroke='"++color++"' /> \n"

logo2hask :: String -> Programme
logo2hask str = read str :: Programme

toSVG :: Programme -> String
toSVG [] = ""
toSVG (x:xs) = case x of (Forward v) -> svgLine Crayon NewCrayon

-- decodeInstruction :: String -> [Instruction]
-- decodeInstruction  = 

-- outputStrLst :: [String] -> IO()
