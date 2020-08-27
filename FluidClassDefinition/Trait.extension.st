Extension { #name : #Trait }

{ #category : #'*FluidClassDefinition' }
Trait class >> << aSymbol [
	^ FluidClassBuilder new 
		traitToBuild: aSymbol;
		yourself
]
