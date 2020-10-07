Extension { #name : #MetaclassForTraits }

{ #category : #'*FluidClassDefinition' }
MetaclassForTraits >> definitionExpanded [
	^ String streamContents: [ :s | 
		s nextPutAll: self instanceSide name;
			nextPutAll: ' classTrait';
			cr; tab.
		self hasTraitComposition 
			ifTrue: [ s 
						nextPutAll: 'uses: ';
						nextPutAll: self traitCompositionString;
						nextPutAll: ';' ]
			ifFalse: [ s nextPutAll: 'uses: {};'].
		s crtab.
		s nextPutAll: 'slots: ', self slotDefinitionString ]
]
