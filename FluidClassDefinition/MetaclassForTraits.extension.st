Extension { #name : #MetaclassForTraits }

{ #category : #'*FluidClassDefinition' }
MetaclassForTraits >> definition [
	^ self asFluidDefinitionString 
	
	"^ String streamContents: [ :s | 
		s nextPutAll: self instanceSide name;
			nextPutAll: ' classTrait';
			cr; tab;
			nextPutAll: 'uses: ';
			nextPutAll: composition traitCompositionExpression.
			
		self localSlots ifNotEmpty: [ 
				s crtab;
					nextPutAll: 'slots: ';
					nextPutAll: self slotDefinitionString]]"
]
