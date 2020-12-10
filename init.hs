import System.IO
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
regexLogoskell ="^\\[.*\\]$"
svg = ""++baseSVG
crayon = Crayon (Coordonnee 100 100) $ toradian 0
-- Coordonnee ajout distance crayon
newCrayon :: Crayon -> Float -> Angle-> Int-> Crayon
newCrayon (Crayon coo@(Coordonnee x y) a) dist angle action
 | action == 0 = Crayon (Coordonnee (x + dist*(cos a)) (y + dist*(sin a))) a --  pour un x vérifier les modulations de pi
 | action == 1 = Crayon coo (a+angle) -- Pour un left ou right

-- conversion de l'angle en radian 

toradian :: Float -> Float 
toradian a = a*pi/180
-- Generation d'une ligne SVG avec des coordonnées

svgLine :: Crayon -> Crayon ->String
svgLine (Crayon coo1 _) (Crayon coo2 _) = svgLinecoo coo1 coo2 

svgLinecoo :: Coordonnee -> Coordonnee ->String
svgLinecoo (Coordonnee x1 y1) (Coordonnee x2 y2) = "<line x1='"++ show x1 ++"' y1='"++ show y1 ++"' x2='"++ show x2 ++"' y2='"++ show y2 ++"' stroke='"++color++"' /> \n"


-- Verif du langage logoskell
logo2hask :: String -> Programme
logo2hask str = read str :: Programme

toCrayon :: Programme -> Crayon -> [Crayon]
toCrayon [] c = [c] 
toCrayon (x:xs) c = case x of
 (Forward v) -> c:toCrayon xs (newCrayon c v (toradian 0) 0)
 (Left a) -> c:toCrayon xs (newCrayon  c 0  (toradian a) 1)
 (Right a) -> c:toCrayon xs (newCrayon c 0 (toradian (-a)) 1)
 (Repeat n prog) ->  c:toCrayon xxs c 
  where xxs = (take (n*length prog)  (cycle prog))++xs

toCrayonrepeat :: Programme -> Int -> Crayon -> [Crayon]
toCrayonrepeat _ 0 c = [c] 
toCrayonrepeat prog n c = (toCrayon prog c) ++ toCrayonrepeat prog (n-1) c

toSVG :: [Crayon] -> String
toSVG crayons = svg ++  toSVG' crayons

toSVG' :: [Crayon] -> String
toSVG' c@(c0:c1:cs)
 | length c == 2 =  svgLine c0 c1 ++ "</svg>" 
 | otherwise = (svgLine c0 c1)++toSVG' (c1:cs)

main = do 
  content <- hGetLine stdin
  hPutStr stdout $ toSVG $ toCrayon (logo2hask content) crayon 
