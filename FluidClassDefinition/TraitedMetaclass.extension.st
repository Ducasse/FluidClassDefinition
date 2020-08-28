Extension { #name : #TraitedMetaclass }

{ #category : #'*FluidClassDefinition' }
TraitedMetaclass >> asFluidDefinitionString [


	^ String streamContents: 
		[:strm |
		strm nextPutAll: self name.
		strm nextPutAll: ' '.
		
		self hasTraitComposition ifTrue: [
			strm
				crtab;
				nextPutAll: 'uses: ';
				print: self traitComposition ].
		self slots ifNotEmpty: [  
			strm
				crtab;
				nextPutAll: 'slots: ';
				nextPutAll: self slotDefinitionString]]
]

{ #category : #'*FluidClassDefinition' }
TraitedMetaclass >> definition [
	"Refer to the comment in ClassDescription|definition."
	^ self asFluidDefinitionString 
	"^ String streamContents: 
		[:strm |
		strm print: self.
		self hasTraitComposition ifTrue: [
			strm
				crtab;
				nextPutAll: 'uses: ';
				print: self traitComposition ].
		
		(self slotsNeedFullDefinition or: [ Slot showSlotClassDefinition ])
			ifFalse: [  
						strm
							crtab;
							nextPutAll: 'instanceVariableNames: ';
							store: self instanceVariablesString]
			ifTrue: [ 
						strm
							crtab;
							nextPutAll: 'slots: ';
							nextPutAll: self slotDefinitionString]]"
]
