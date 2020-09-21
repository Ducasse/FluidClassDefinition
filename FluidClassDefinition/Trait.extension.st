Extension { #name : #Trait }

{ #category : #'*FluidClassDefinition' }
Trait class >> << aSymbol [
	^ FluidTraitBuilder new 
		name: aSymbol;
		yourself
]

{ #category : #'*FluidClassDefinition' }
Trait >> asFluidDefinitionString [ 

	^ String streamContents: [ :s |		
		s 
			nextPutAll: 'Trait  << #';
			nextPutAll: name;
			cr.
		
		self hasTraitComposition ifTrue: [
			s 
				tab; 
				nextPutAll: 'uses: ';
				nextPutAll: self traitCompositionString ;
				nextPutAll: ';';
				cr ].
		
		self slots ifNotEmpty: [ 
					s tab.
					s nextPutAll: 'slots: '.
					s nextPutAll: self slotDefinitionString.
					s nextPutAll: ';'.
					s cr ].
				
		self tagOn: s.
		
		s 	
			tab;
			nextPutAll: 'package: '; 
			nextPut: $';
			nextPutAll: self package packageName;
			nextPut: $'
		]
]

{ #category : #'*FluidClassDefinition' }
Trait >> definition [
	
	^ Slot showSlotClassDefinition
		ifTrue: [ self asFluidDefinitionString ]
		ifFalse: [ self definitionWithoutSlots ]
	
]

{ #category : #'*FluidClassDefinition' }
Trait >> definitionWithoutSlots [

	(self instanceSide name == #Trait) ifTrue: [ ^ super definition ].

	^ String streamContents: [ :s | 
		s 
			nextPutAll: 'Trait named: ';
			nextPutAll:	self name printString;
			cr; tab; 
			nextPutAll: ' uses: ';
			nextPutAll: self traitComposition traitCompositionExpression; 
			cr.
		self classLayout visibleSlots ifNotEmpty: [ 
			s tab; nextPutAll: ' slots: ';
			nextPutAll: self slotDefinitionString; cr. ].
		s tab; nextPutAll: ' package: ';
			nextPutAll: self category asString printString
	]
]
