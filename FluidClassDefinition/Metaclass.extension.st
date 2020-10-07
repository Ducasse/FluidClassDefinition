Extension { #name : #Metaclass }

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
Metaclass >> expandedDefinitionStringFor: aPrinter [

	^ aPrinter for: self ; expandedMetaclassDefinitionString
]
