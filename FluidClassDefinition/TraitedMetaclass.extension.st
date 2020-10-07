Extension { #name : #TraitedMetaclass }

{ #category : #'*FluidClassDefinition' }
TraitedMetaclass >> definitionStringFor: aPrinter [

	^ aPrinter for: self ; traitedMetaclassDefinitionString 
]

{ #category : #'*FluidClassDefinition' }
TraitedMetaclass >> expandedDefinitionStringFor: aPrinter [

	^ aPrinter for: self ; expandedTraitedMetaclassDefinitionString 
]
