module Currency where
import Render (red, white)
data Currency = Bone | Blood deriving (Eq)


instance Show Currency where
    show Blood = red "❃"
    show Bone  = white "bone"
