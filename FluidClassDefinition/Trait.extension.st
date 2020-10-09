Extension { #name : #Trait }

{ #category : #'*FluidClassDefinition' }
Trait class >> << aSymbol [
	^ FluidTraitBuilder new 
		name: aSymbol;
		yourself
]

{ #category : #'*FluidClassDefinition' }
Trait >> definitionStringFor: aConfiguredPrinter [

	^ aConfiguredPrinter traitDefinitionString
]

{ #category : #'*FluidClassDefinition' }
Trait >> expandedDefinitionStringFor: aPrinter [

	^ aPrinter expandedTraitDefinitionString 
]
