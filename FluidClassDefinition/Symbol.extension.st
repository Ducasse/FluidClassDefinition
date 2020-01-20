Extension { #name : #Symbol }

{ #category : #'*FluidClassDefinition' }
Symbol >> scannerToText [
	^ self isBinary ifTrue: [ self asString ] ifFalse: [ self  printString] 
]
