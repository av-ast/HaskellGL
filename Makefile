all: compile

compile:
	ghc HelloWorld
	ghc RedTriangle
	ghc Light
	cd FlyingCubes && make
	cd ..

.PHONY: compile
