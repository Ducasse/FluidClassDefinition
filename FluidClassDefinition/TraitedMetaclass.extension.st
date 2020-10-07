Extension { #name : #TraitedMetaclass }

{ #category : #'*FluidClassDefinition' }
TraitedMetaclass >> definitionStringFor: aPrinter [

	^ aPrinter for: self ; traitedMetaclassDefinitionString 
]
