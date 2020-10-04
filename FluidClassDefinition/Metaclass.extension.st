Extension { #name : #Metaclass }

{ #category : #'*FluidClassDefinition' }
Metaclass >> asFluidDefinitionString [
	"to remove"
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
				self slotDefinitionStringOn: s ].
		]
]

{ #category : #'*FluidClassDefinition' }
Metaclass >> definition [
	"Refer to the comment in ClassDescription|definition."
	" to remove ?"
	Slot showSlotClassDefinition ifTrue: [ 
		^ self definitionWithSlots ].

	^ self definitionWithoutSlots
]

{ #category : #'*FluidClassDefinition' }
Metaclass >> definitionExpanded [
	"This definition presents all the receiver state also the empty one so that the user can just type and empty elements will be ignored by the builder and parser. 
	"
	"For now I will check here for Slot 
	"
	^ Slot showSlotClassDefinition 
		ifTrue: [
				String streamContents: [ :s | 
						superclass 
							ifNotNil: [ s nextPutAll: self name ]
							ifNil: [ s nextPutAll: 'ProtoObject ' ].
						
						s crtab. 
						
						self hasTraitComposition 
							ifTrue: [
								s 
									nextPutAll: 'uses: ';
									nextPutAll: self traitCompositionString;
									nextPutAll: ';']
							ifFalse: [ s nextPutAll: 'uses: {};'].
						s crtab.

						s nextPutAll: 'slots: '.
						self slotDefinitionStringOn: s. 
						]]
		ifFalse: [  self definitionWithoutSlots	]

]

{ #category : #'*FluidClassDefinition' }
Metaclass >> definitionStringFor: aPrinter [

	^ aPrinter metaclassDefinitionString 
]

{ #category : #'*FluidClassDefinition' }
Metaclass >> definitionWithSlots [
	"Refer to the comment in ClassDescription|definition."
	" to remove from the package"
	^ self asFluidDefinitionString

"	^ String streamContents: [:stream |
		stream print: self.
		stream
			crtab;
			nextPutAll: 'slots: ';
			nextPutAll: self slotDefinitionString ]"
]
