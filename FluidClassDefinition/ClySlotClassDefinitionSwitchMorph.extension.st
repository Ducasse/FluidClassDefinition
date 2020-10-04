Extension { #name : #ClySlotClassDefinitionSwitchMorph }

{ #category : #'*FluidClassDefinition' }
ClySlotClassDefinitionSwitchMorph >> toggle [

	ClassDefinitionPrinter showSlotClassDefinition: ClassDefinitionPrinter showSlotClassDefinition not.
	ownerTool update
]
