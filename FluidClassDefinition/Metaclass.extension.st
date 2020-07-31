Extension { #name : #Metaclass }

{ #category : #'*FluidClassDefinition' }
Metaclass >> asFluidDefinitionString [
	^ String streamContents: [ :s |
		
		superclass 
			ifNotNil: [s nextPutAll: superclass name]
			ifNil: [s nextPutAll: 'ProtoObject'].
		s 
			nextPutAll: ' < #';
			nextPutAll: thisClass name;
			cr.
		
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
			
		s 	
			tab;
			nextPutAll: 'package: '; 
			nextPut: $';
			nextPutAll: self package packageName;
			nextPut: $'
		]
]
