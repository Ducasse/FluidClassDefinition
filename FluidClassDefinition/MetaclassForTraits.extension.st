Extension { #name : #MetaclassForTraits }

{ #category : #'*FluidClassDefinition' }
MetaclassForTraits >> definition [
	^ Slot showSlotClassDefinition
		ifTrue: [ self asFluidDefinitionString ]
		ifFalse: [ self definitionWithoutSlots ]
]

{ #category : #'*FluidClassDefinition' }
MetaclassForTraits >> definitionwithoutSlots [
	^ String streamContents: [ :s | 
		s nextPutAll: self instanceSide name;
			nextPutAll: ' classTrait';
			cr; tab;
			nextPutAll: 'uses: ';
			nextPutAll: composition traitCompositionExpression.
			
		self localSlots ifNotEmpty: [ 
				s crtab;
					nextPutAll: 'slots: ';
					nextPutAll: self slotDefinitionString]]
]
