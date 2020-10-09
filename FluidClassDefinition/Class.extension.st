Extension { #name : #Class }

{ #category : #'*FluidClassDefinition' }
Class >> definitionStringFor: aConfiguredPrinter [

	^ aConfiguredPrinter classDefinitionString 
]

{ #category : #'*FluidClassDefinition' }
Class >> expandedDefinitionStringFor: aPrinter [

	^ aPrinter expandedClassDefinitionString 
]
