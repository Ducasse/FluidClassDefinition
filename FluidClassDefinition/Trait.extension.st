Extension { #name : #Trait }

{ #category : #'*FluidClassDefinition' }
Trait class >> << aSymbol [
	^ FluidTraitBuilder new 
		name: aSymbol;
		yourself
]

{ #category : #'*FluidClassDefinition' }
Trait >> definition [
	
	(self instanceSide name == #Trait) ifTrue: [ ^ super definition ].
	^ self asFluidDefinitionString 
	"
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
"
]
