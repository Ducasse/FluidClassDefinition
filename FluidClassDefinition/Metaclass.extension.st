Extension { #name : #Metaclass }

{ #category : #'*FluidClassDefinition' }
Metaclass >> definitionStringFor: aPrinter [

	^ aPrinter metaclassDefinitionString 
]

{ #category : #'*FluidClassDefinition' }
Metaclass >> expandedDefinitionStringFor: aPrinter [

	^ aPrinter expandedMetaclassDefinitionString
]
