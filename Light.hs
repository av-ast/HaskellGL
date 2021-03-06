import System.Exit ( exitWith, ExitCode(ExitSuccess) )
import Graphics.UI.GLUT

myInit :: IO ()
myInit = do
   clearColor $= Color4 0 0 0 0
   shadeModel $= Smooth

   materialSpecular Front $= Color4 1 1 1 1
   materialShininess Front $= 50
   position (Light 0) $= Vertex4 1 1 1 0

   lighting $= Enabled
   light (Light 0) $= Enabled
   depthFunc $= Just Less

display :: DisplayCallback
display = do
   clear [ ColorBuffer, DepthBuffer ]
   renderObject Solid (Sphere' 1 20 16)
   flush

reshape :: ReshapeCallback
reshape size@(Size w h) = do
   viewport $= (Position 0 0, size)
   matrixMode $= Projection
   loadIdentity
   let wf = fromIntegral w
       hf = fromIntegral h
   if w <= h
      then ortho (-1.5) 1.5 (-1.5 * hf/wf) (1.5 * hf/wf) (-10) 10
      else ortho (-1.5 * wf/hf) (1.5 * wf/hf) (-1.5) 1.5 (-10) 10
   matrixMode $= Modelview 0
   loadIdentity

keyboard :: KeyboardMouseCallback
keyboard (Char '\27') Down _ _ = exitWith ExitSuccess
keyboard _            _    _ _ = return ()

main :: IO ()
main = do
   (progName, _args) <- getArgsAndInitialize
   initialDisplayMode $= [ SingleBuffered, RGBMode, WithDepthBuffer ]
   initialWindowSize $= Size 500 500
   initialWindowPosition $= Position 100 100
   createWindow progName
   myInit
   displayCallback $= display
   reshapeCallback $= Just reshape
   keyboardMouseCallback $= Just keyboard
   mainLoop
