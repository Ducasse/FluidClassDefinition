Extension { #name : #Class }

{ #category : #'*FluidClassDefinition' }
Class >> asFluidDefinitionString [
	^ String streamContents: [ :s |
		s nextPutAll: superclass name.
		s nextPutAll: ' < #'.
		s nextPutAll: name.
		s cr.
		self slots isNotEmpty
			ifTrue: [ 
					s tab.
					s nextPutAll: 'slots: {'. 
					self slots do: [ :each | s nextPutAll: each definitionString ]
						separatedBy: [  s nextPutAll: '. '].
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
