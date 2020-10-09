Extension { #name : #ClySlotClassDefinitionSwitchMorph }

{ #category : #'*FluidClassDefinition' }
ClySlotClassDefinitionSwitchMorph >> toggle [
	self halt.
	ClassDefinitionPrinter toggleShowFluidClassDefinition.
	ownerTool update
]

{ #category : #'*FluidClassDefinition' }
ClySlotClassDefinitionSwitchMorph >> usesSlotBasedDefinition [

	^ ClassDefinitionPrinter showFluidClassDefinition
]
