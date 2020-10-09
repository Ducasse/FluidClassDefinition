Extension { #name : #Metaclass }

{ #category : #'*FluidClassDefinition' }
Metaclass >> definitionStringFor: aConfiguredPrinter [

	^ aConfiguredPrinter metaclassDefinitionString 
]

{ #category : #'*FluidClassDefinition' }
Metaclass >> expandedDefinitionStringFor: aPrinter [

	^ aPrinter expandedMetaclassDefinitionString
]

{ #category : #'*FluidClassDefinition' }
Metaclass >> fullyExpandedDefinitionStringInPackage: aPrinter [

	^ aPrinter for: self ; fullyExpandedMetaclassDefinitionStringInPackage: self package packageName
]
