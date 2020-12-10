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

-- Generation d'une ligne SVG avec des coordonnées
svgLine :: Coordonnee -> Coordonnee ->String
svgLine (Coordonnee x1 y1) (Coordonnee x2 y2) = "<line x1='"++ show x1 ++"' y1='"++ show y1 ++"' x2='"++ show x2 ++"' y2='"++ show y2 ++"' stroke='"++color++"' /> \n"


-- toSVG :: String -> String


-- decodeInstruction :: String -> [Instruction]
-- decodeInstruction  = 

-- outputStrLst :: [String] -> IO()
