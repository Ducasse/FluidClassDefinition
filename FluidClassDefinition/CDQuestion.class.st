"
- use latest P9
- For sharedPools why not display the SharedPool instead of a dead string?
- fix class side recreator
- fix ugly compilation hack
- install new class parser

- (Smalltalk compiler evaluate: 'Object < #MyObject22
		sharedVariables: { #A . #B };
		package: #MyPackage') build.
"
Class {
	#name : #CDQuestion,
	#superclass : #Object,
	#category : #'FluidClassDefinition-Parser'
}
