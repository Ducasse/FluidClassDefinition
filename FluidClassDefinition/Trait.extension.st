Extension { #name : #Trait }

{ #category : #'*FluidClassDefinition' }
Trait class >> << aSymbol [
	^ FluidTraitBuilder new 
		name: aSymbol;
		yourself
]

{ #category : #'*FluidClassDefinition' }
Trait >> definitionStringFor: aPrinter [

	^ aPrinter for: self; traitDefinitionString
]

{ #category : #'*FluidClassDefinition' }
Trait >> expandedDefinitionStringFor: aPrinter [

	^ aPrinter for: self ; expandedTraitDefinitionString 
]
