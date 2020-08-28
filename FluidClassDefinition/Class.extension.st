Extension { #name : #Class }

{ #category : #'*FluidClassDefinition' }
Class >> asFluidDefinitionString [
	^ String streamContents: [ :s |
		| tag poolString |
		poolString := self sharedPoolsString.
		
		superclass 
			ifNotNil: [s nextPutAll: superclass name]
			ifNil: [s nextPutAll: 'ProtoObject'].
		s 
			nextPutAll: ' < #';
			nextPutAll: name;
			cr.
		
		self classLayout isFixedLayout ifFalse: [
			s 
				tab; 
				nextPutAll: 'layout: ';
				nextPutAll: self classLayout class name;
				nextPutAll: ';';
				cr ].
		
		self hasTraitComposition ifTrue: [
			s 
				tab; 
				nextPutAll: 'uses: ';
				nextPutAll: self traitCompositionString ;
				nextPutAll: ';';
				cr ].
		
		self slots ifNotEmpty: [ 
					s tab.
					s nextPutAll: 'slots: {'. 
					self slots do: [ :each | s nextPutAll: each definitionString ]
						separatedBy: [  s nextPutAll: ' . '].
					s nextPutAll: '};'.
					s cr].
		self classVariables ifNotEmpty: [  
				s 
					tab;
					nextPutAll: 'sharedVariables: ';
					nextPutAll: self classVariableDefinitionString;
					nextPutAll: ';';
					cr
				].
				
		tag := (self package classTagForClass: self) name.
		tag = self package name
			ifFalse:  [
				s 	tab;  
				 	nextPutAll: 'tag: '; 
					nextPut: $'; 
					nextPutAll: tag asString ; 
					nextPutAll: ''';'.
				s cr
				].
			
		poolString = '' ifFalse: [
			s 
				tab ; 
				nextPutAll: 'sharedPools: ' ;
				store: poolString ;
				nextPutAll: ';' ;
				cr ].	
			
		s 	
			tab;
			nextPutAll: 'package: '; 
			nextPut: $';
			nextPutAll: self package packageName;
			nextPut: $'
		]
]
