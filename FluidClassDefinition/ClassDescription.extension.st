Extension { #name : #ClassDescription }

{ #category : #'*FluidClassDefinition' }
ClassDescription >> asFluidDefinitionString [
	^ self subclassResponsibility
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definition [
	"Answer a String that defines the receiver."

	Slot showSlotClassDefinition ifTrue: [ 
		^ self asFluidDefinitionString ].
	
	^ self definitionWithoutSlots
	
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionFullyExpanded [
	"This definition propose all the with an empty arguments so that the user can just type and empty elements will be ignored by the builder and parser. Should check that this is true and write tests."
	
	^ self definitionFullyExpandedButPackage: 'MyPackage'
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionFullyExpandedButPackage: aString [
	"This definition propose all the with an empty arguments so that the user can just type and empty elements will be ignored by the builder and parser. Should check that this is true and write tests. 
	"
	
	^ String streamContents: [ :s |
			s nextPutAll: 'Object < #MyClass'; crtab.
			s nextPutAll: 'layout: FixedLayout;'; crtab.
			s nextPutAll: 'uses: {};'; crtab.
			s nextPutAll: 'slots: {};'; crtab. 
			s nextPutAll: 'sharedVariables: {};'; crtab.
			s nextPutAll: 'tag: '''' ;';crtab.
			s nextPutAll: 'sharedPools: {};'; crtab.
			s nextPutAll: 'package: ''', aString, ''''.	
		]		

]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionWithSlots [
	"The class definition with a way to specify slots. Shown when the class defines special Slot"
	^ self instanceSide asFluidDefinitionString
	
	"
	| stream poolString|
	poolString := self sharedPoolsString.

	stream := (String new: 800) writeStream.
	superclass 
		ifNotNil: [stream nextPutAll: superclass name]
		ifNil: [stream nextPutAll: 'ProtoObject'].
	stream 
		nextPutAll: ' subclass: '; 
		store: self name.
	self hasTraitComposition ifTrue: [
		stream 
			crtab; 
			nextPutAll: 'uses: ';
			nextPutAll: self traitCompositionString ].
			
	self classLayout isFixedLayout ifFalse: [
		stream 
			crtab; 
			nextPutAll: 'layout: ';
			nextPutAll: self classLayout class name ].
	
	stream 
		crtab; 
		nextPutAll: 'slots: ';
		nextPutAll: self slotDefinitionString.
		
	stream 
		crtab; 
		nextPutAll: 'classVariables: ';
		nextPutAll: self classVariableDefinitionString.
	
	poolString = '' ifFalse: [
		stream 
			crtab; 
			nextPutAll: 'poolDictionaries: ';
			store: poolString ].
		
	stream 
		crtab; 
		nextPutAll: 'package: ';
		store: self category asString.

	superclass ifNil: [ 
		stream nextPutAll: '.'; cr.
		stream nextPutAll: self name.
		stream space; nextPutAll: 'superclass: nil'. ].

	^ stream contents"
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionWithoutSlots [

	| poolString stream |
	poolString := self sharedPoolsString.
	stream := (String new: 800) writeStream.
	superclass
		ifNotNil: [ stream nextPutAll: superclass name ]
		ifNil: [ stream nextPutAll: 'ProtoObject' ].
	
	stream
		nextPutAll: self kindOfSubclass;
		store: self name.
	self hasTraitComposition ifTrue: [ 
		stream
			crtab;
			nextPutAll: 'uses: ';
			nextPutAll: self traitCompositionString ].
	stream
		crtab;
		nextPutAll: 'instanceVariableNames: ';
		store: self instanceVariablesString.
	stream
		crtab;
		nextPutAll: 'classVariableNames: ';
		store: self classVariablesString.
	
	poolString = '' ifFalse: [ 
		stream 
			crtab;
			nextPutAll: 'poolDictionaries: ';
			store: poolString ].
	
	stream
		crtab;
		nextPutAll: 'package: ';
		store: self category asString.
		
	superclass ifNil: [ 
		stream
			nextPutAll: '.';
			cr.
		stream 
			nextPutAll: self name.
		stream
			space;
			nextPutAll: 'superclass: nil' ].

	^ stream contents
	
]
