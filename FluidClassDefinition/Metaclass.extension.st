Extension { #name : #Metaclass }

{ #category : #'*FluidClassDefinition' }
Metaclass >> asFluidDefinitionString [
	
	^ String streamContents: [ :s |
		
		superclass 
			ifNotNil: [ s nextPutAll: self name ]
			ifNil: [ s nextPutAll: 'ProtoObject ' ].
		
		self hasTraitComposition ifTrue: [
			s 
				crtab; 
				nextPutAll: 'uses: ';
				nextPutAll: self traitCompositionString ;
				nextPutAll: ';';
				cr ].
		
		self slots ifNotEmpty: 
			[ 
				s crtab.
				s nextPutAll: 'slots: '. 
				s nextPutAll: self slotDefinitionString ].
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
