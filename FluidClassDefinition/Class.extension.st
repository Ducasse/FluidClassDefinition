Extension { #name : #Class }

{ #category : #'*FluidClassDefinition' }
Class >> definitionStringFor: aPrinter [

	^ aPrinter classDefinitionString 
]

{ #category : #'*FluidClassDefinition' }
Class >> expandedDefinitionStringFor: aPrinter [

	^ aPrinter expandedClassDefinitionString 
]

{ #category : #'*FluidClassDefinition' }
Class >> fullyExpandedDefinitionStringFor: aPrinter [

	^ aPrinter fullyExpandedClassDefinitionStringInPackage: self package packageName
]
