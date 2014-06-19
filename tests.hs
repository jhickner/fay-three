{-# LANGUAGE NoImplicitPrelude #-}

module Tests where

import Language.Fay.FFI
import Language.Fay.Prelude
import Language.Fay.Three
import Language.Fay.JQuery

main :: Fay ()
main = ready $ do
  w <- getWindowWidth
  h <- getWindowHeight
  cam <- mkPerspectiveCamera 75 (w/h) 1 10000
  scene <- mkScene
  r <- mkCanvasRenderer
  geo <- mkCubeGeometry 500 500 500
  mat <- mkMeshBasicMaterial 0xff0000 False
  mesh <- mkMesh geo mat
  setZ cam 1000
  addObject3D scene mesh
  setRendererSize r w h
  addRenderer r
  animate r scene cam mesh

animate :: Renderer -> Object3D -> Object3D -> Object3D -> Fay ()
animate r scene cam mesh = f
  where f = do
          requestAnimationFrame f
          incRotationX mesh 0.01
          incRotationY mesh 0.02
          render r scene cam

addRenderer :: Renderer -> Fay ()
addRenderer = ffi "document.body.appendChild(%1.domElement)"

getWindowWidth :: Fay Double
getWindowWidth = ffi "window.innerWidth"

getWindowHeight :: Fay Double
getWindowHeight = ffi "window.innerHeight"

log :: Foreign a => a -> Fay ()
log = ffi "console.log(%1)"

logS :: String -> Fay ()
logS = ffi "console.log(%1)"
