import Graphics.UI.GLUT
import System.Exit ( exitWith, ExitCode(ExitSuccess) )

main = do
  _ <- getArgsAndInitialize
  _ <- createWindow "Red Triangle"
  displayCallback $= display
  keyboardMouseCallback $= Just keyboard
  reshapeCallback $= Just reshape
  mainLoop

display :: DisplayCallback
display = do
  clear [ColorBuffer]
  currentColor $= Color4 1 0 0 1
  renderPrimitive Triangles $ do
    vertex $ Vertex3 (0 :: GLfloat) 0.5 0
    vertex $ Vertex3 (0.5 :: GLfloat) (-0.5) 0
    vertex $ Vertex3 (-0.5 :: GLfloat) (-0.5) 0
  flush

keyboard :: KeyboardMouseCallback
keyboard (Char '\27') Down _ _ = exitWith ExitSuccess
keyboard _            _    _ _ = return ()

reshape :: ReshapeCallback
reshape size = do
  viewport $= (Position 0 0, size)
  postRedisplay Nothing
