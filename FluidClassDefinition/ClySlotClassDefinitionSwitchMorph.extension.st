Extension { #name : #ClySlotClassDefinitionSwitchMorph }

{ #category : #'*FluidClassDefinition' }
ClySlotClassDefinitionSwitchMorph >> toggle [
	Slot showSlotClassDefinition: Slot showSlotClassDefinition not.
	CDFluidClassDefinitionParser setStatus: Slot showSlotClassDefinition.
	
	ownerTool update
]
