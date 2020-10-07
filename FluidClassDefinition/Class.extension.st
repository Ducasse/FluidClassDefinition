Extension { #name : #Class }

{ #category : #'*FluidClassDefinition' }
Class >> definitionStringFor: aPrinter [

	^ aPrinter classDefinitionString 
]

{ #category : #'*FluidClassDefinition' }
Class >> expandedDefinitionStringFor: aPrinter [

	^ aPrinter expandedClassDefinitionString 
]
