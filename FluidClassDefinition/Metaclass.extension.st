Extension { #name : #Metaclass }

{ #category : #'*FluidClassDefinition' }
Metaclass >> asFluidDefinitionString [
	


	^ String streamContents: [ :s |
		
		superclass 
			ifNotNil: [ s nextPutAll: self name ]
			ifNil: [ s nextPutAll: 'ProtoObject ' ].
		
		self hasTraitComposition ifTrue: [
			s 
				tab; 
				nextPutAll: 'uses: ';
				nextPutAll: self traitCompositionString ;
				nextPutAll: ';';
				cr ].
		
		self slots ifNotEmpty: 
			[ 
					s tab.
					s nextPutAll: 'slots: {'. 
					self slots do: [ :each | s nextPutAll: each definitionString ]
						separatedBy: [  s nextPutAll: ' . '].
					s nextPutAll: '};'.
					s cr].
		]
]

{ #category : #'*FluidClassDefinition' }
Metaclass >> definition [
	"Refer to the comment in ClassDescription|definition."

	Slot showSlotClassDefinition ifTrue: [ 
		^ self definitionWithSlots ].

	^ self definitionWithoutSlots
]

{ #category : #'*FluidClassDefinition' }
Metaclass >> definitionWithSlots [
	"Refer to the comment in ClassDescription|definition."
	^ self asFluidDefinitionString

"	^ String streamContents: [:stream |
		stream print: self.
		stream
			crtab;
			nextPutAll: 'slots: ';
			nextPutAll: self slotDefinitionString ]"
]
