Extension { #name : #TraitedMetaclass }

{ #category : #'*FluidClassDefinition' }
TraitedMetaclass >> definitionStringFor: aConfiguredPrinter [

	^ aConfiguredPrinter traitedMetaclassDefinitionString 
]

{ #category : #'*FluidClassDefinition' }
TraitedMetaclass >> fullyExpandedDefinitionStringInPackage: aPrinter [

	^ aPrinter for: self ; fullyExpandedTraitDefinitionStringInPackage: self package packageName
]
