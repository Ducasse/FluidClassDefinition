Extension { #name : #Trait }

{ #category : #'*FluidClassDefinition' }
Trait >> definitionStringFor: aConfiguredPrinter [

	^ aConfiguredPrinter traitDefinitionString
]

{ #category : #'*FluidClassDefinition' }
Trait >> expandedDefinitionStringFor: aPrinter [

	^ aPrinter expandedTraitDefinitionString 
]
