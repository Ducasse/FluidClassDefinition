Extension { #name : #Class }

{ #category : #'*FluidClassDefinition' }
Class >> definitionStringFor: aConfiguredPrinter [

	^ aConfiguredPrinter classDefinitionString 
]

{ #category : #'*FluidClassDefinition' }
Class >> expandedDefinitionStringFor: aPrinter [

	^ aPrinter expandedClassDefinitionString 
]

{ #category : #'*FluidClassDefinition' }
Class >> fullyExpandedDefinitionStringFor: aPrinter [

	^ aPrinter for: self ;  fullyExpandedClassDefinitionStringInPackage: self package packageName
]
