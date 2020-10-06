Extension { #name : #ClySlotClassDefinitionSwitchMorph }

{ #category : #'*FluidClassDefinition' }
ClySlotClassDefinitionSwitchMorph >> toggle [
	ClassDefinitionPrinter toggleShowFluidClassDefinition.
	ownerTool update
]

{ #category : #'*FluidClassDefinition' }
ClySlotClassDefinitionSwitchMorph >> usesSlotBasedDefinition [

	^ ClassDefinitionPrinter showFluidClassDefinition
]
