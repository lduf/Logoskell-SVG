import Prelude hiding (Left, Right)
-- Datas
-- -- Datas pour gérer le logoskell
data Instruction = Forward Float | Left Float | Right Float | Repeat Int [Instruction] deriving(Show, Read)
type Programme = [Instruction]

-- -- Datas pour gérer le dessing / le svg
data Coordonnee = Coordonnee Float Float deriving(Show, Read, Eq, Ord)
type Angle = Float
data Crayon  = Crayon Coordonnee Angle deriving(Show, Read, Eq, Ord)

-- Variables
color = "red"
title = "Title"
baseSVG = "<?xml version='1.0' encoding='utf-8'?> \n <svg xmlns='http://www.w3.org/2000/svg' version='1.1' width='400' height='400'> \n <title>"++title++"</title> \n"
svgLineEX = "<line x1='100.00' y1='100.00' x2='200.00' y2='100.00' stroke='"++color++"' />"
regexLogoskell ="^\\[.*\\]$"
svg = ""
crayon = Crayon (Coordonnee 0 0) 0
-- Coordonnee ajout distance crayon
newCrayon :: Crayon -> Float -> Angle-> Crayon
newCrayon (Crayon (Coordonnee x y) a) dist 0 = Crayon (Coordonnee (x + dist*(cos a)) (y + dist*(sin a))) a --  pour un x vérifier les modulations de pi
newCrayon (Crayon coo a) 0 angle = Crayon coo (a+angle) -- Pour un left ou right

-- Generation d'une ligne SVG avec des coordonnées

svgLine :: Crayon -> Crayon ->String
svgLine (Crayon coo1 _) (Crayon coo2 _) = svgLinecoo coo1 coo2 

svgLinecoo :: Coordonnee -> Coordonnee ->String
svgLinecoo (Coordonnee x1 y1) (Coordonnee x2 y2) = "<line x1='"++ show x1 ++"' y1='"++ show y1 ++"' x2='"++ show x2 ++"' y2='"++ show y2 ++"' stroke='"++color++"' /> \n"


-- Verif du langage logoskell
logo2hask :: String -> Programme
logo2hask str = read str :: Programme

toSVG :: Programme -> String
toSVG [] = svg++""
toSVG (x:xs) = case x of 
 (Forward v) -> (svgLine crayon $ newCrayon crayon v 0)++toSVG xs
 (Left a) -> (svgLine crayon $ newCrayon crayon 0 a)++toSVG xs
 (Right a) -> (svgLine crayon $ newCrayon crayon 0 (-a))++toSVG xs
 (Repeat n prog) -> toSVGrepeat prog n

toSVGrepeat :: Programme -> Int -> String
toSVGrepeat _ 0 = ""
toSVGrepeat prog n = (toSVG prog)++toSVGrepeat prog (n-1)
