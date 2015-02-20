all: compile

deps:
	cabal install cabal-install
	cabal install glut

compile: deps
	ghc HelloWorld
	ghc RedTriangle
	ghc Light
	cd FlyingCubes && make
	cd ..

.PHONY: compile deps
