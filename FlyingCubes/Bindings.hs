module Bindings (idle, display, reshape, keyboardMouse) where

import System.Exit ( exitWith, ExitCode(ExitSuccess) )
import Graphics.UI.GLUT
import Data.IORef
import Display

reshape :: ReshapeCallback
reshape size = do
  viewport $= (Position 0 0, size)

keyboardMouse :: IORef GLfloat -> IORef (GLfloat, GLfloat) -> KeyboardMouseCallback
keyboardMouse a p key Down _ _ = case key of
  (Char '\27') -> exitWith ExitSuccess
  (Char ' ') -> a $~! negate
  (Char '+') -> a $~! (* 2)
  (Char '-') -> a $~! (/ 2)
  (SpecialKey KeyLeft ) -> p $~! \(x,y) -> (x-0.1,y)
  (SpecialKey KeyRight) -> p $~! \(x,y) -> (x+0.1,y)
  (SpecialKey KeyUp   ) -> p $~! \(x,y) -> (x,y+0.1)
  (SpecialKey KeyDown ) -> p $~! \(x,y) -> (x,y-0.1)
  _ -> return ()
keyboardMouse _angle _pos _key _state _modifiers _position =
  return ()
