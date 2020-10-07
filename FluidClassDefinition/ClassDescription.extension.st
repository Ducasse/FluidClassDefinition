Extension { #name : #ClassDescription }

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definition [
	"Answer a String that defines the receiver."
	
	^ self definitionString
	
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionExpanded [
	"This definition presents all the receiver state also the empty one so that the user can just type and empty elements will be ignored by the builder and parser. 
	"
	"For now I will check here for Slot 
	"
	^ Slot showSlotClassDefinition 
		ifTrue: [
				String streamContents: [ :s | 
						| tag |
						s nextPutAll: 'Object < #', self name asSymbol; crtab.
						
						s 
							nextPutAll: 'layout: ';
							nextPutAll: self classLayout class name; 
							nextPutAll: ';';
							crtab. 
						
						self hasTraitComposition 
							ifTrue: [
								s 
									nextPutAll: 'uses: ';
									nextPutAll: self traitCompositionString ]
							ifFalse: [ s nextPutAll: 'uses: {};'].
						s crtab.

						s nextPutAll: 'slots: ', self slotDefinitionString, ';'; crtab. 
						s 	
							nextPutAll: 'sharedVariables: ';
							nextPutAll: self classVariableDefinitionString;
							nextPutAll: ';'; crtab.
							
						s nextPutAll: 'sharedPools: {'.
						self sharedPoolStringOn: s.
						s nextPutAll: '};' ; crtab.
						
						(self package classTagForClass: self) ifNotNil: [:t | 
							tag := t name.
							tag = self package name
								ifFalse:  [
									s nextPutAll: 'tag: '; 
					nextPut: $'; 
					nextPutAll: tag asString ; 
					nextPutAll: ''';'.
					s crtab
				]].
				
				s 
					nextPutAll: 'package: ''';
					nextPutAll: self package packageName;
					nextPutAll: '''' ]]
		ifFalse: [  self definitionWithoutSlots	]

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
	"For now I will check here for Slot 
	"
	^ Slot showSlotClassDefinition 
		ifTrue: [
				String streamContents: [ :s |
						s nextPutAll: 'Object < #MyClass'; crtab.
						s nextPutAll: 'layout: FixedLayout;'; crtab.
						s nextPutAll: 'uses: {};'; crtab.
						s nextPutAll: 'slots: {};'; crtab. 
						s nextPutAll: 'sharedVariables: {};'; crtab.
						s nextPutAll: 'sharedPools: {};'; crtab.
						s nextPutAll: 'tag: '''' ;';crtab.
						s nextPutAll: 'package: ''', aString, '''' ] 
					]
		ifFalse: [  
				String streamContents: [ :s |
						s nextPutAll: 'Object subclass: #MyClass' ; crtab.
						s nextPutAll: 'instanceVariableNames: '''' '; crtab. 
						s nextPutAll: 'classVariableNames: '''''; crtab.
						s nextPutAll: 'package: ''', aString, '''' ] 				
				]

]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionPrinter [
	"Return the printer"
	^ ClassDefinitionPrinter for: self
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionString [
	"Return the string of the class definition, each of my subclass may tell the printer how to printer it. A kind of double dispatch since we have multiple printers and multiple entities to be printed."

	^ self definitionStringFor: self definitionPrinter
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionStringFor: aPrinter [

	^ self subclassResponsibility 
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> expandedDefinitionString [
	"Return the string of the class definition, each of my subclass may tell the printer how to printer it. A kind of double dispatch since we have multiple printers and multiple entities to be printed."

	^ self expandedDefinitionStringFor: self definitionPrinter
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> expandedDefinitionStringFor: aPrinter [

	^ self subclassResponsibility
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> sharedPoolString [
	"Answer a string of my shared pools separated by spaces."

	^String streamContents: [ :stream | 
		self sharedPoolStringOn: stream ]
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> sharedPoolStringOn: aStream [
	"Answer a string of my shared pools separated by spaces."

		self sharedPools 
			do:  [ :p | aStream space. 
							aStream nextPutAll: p name.
							aStream space ] 
			separatedBy: [ aStream nextPutAll: '.' ]
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> slotDefinitionString [
	"Answer a string that contains an executable description of my Slots"
	
	^String streamContents: [ :str | self slotDefinitionStringOn: str]
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> slotDefinitionStringOn: aStream [
	"Write on the arg aStream an executable description of my Slots"

	| useFull |
	aStream nextPutAll: '{'.
	self localSlots
		do: [ :slot | 
			aStream space.
			aStream nextPutAll: slot definitionString.
			useFull := slot needsFullDefinition.
			aStream space ]
		separatedBy: [ 
			aStream nextPutAll: '.'.
			useFull ifTrue: [ 
				aStream
					cr;
					tab;
					tab;
					tab;
					tab ] ].
	aStream nextPutAll: '}'
]
