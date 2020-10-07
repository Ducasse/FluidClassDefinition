"
```
Object < #MyClass
	layout: FixedLayout;
	uses: {};
	slots: {};
	sharedVariables: {};
	sharedPools: {};
	tag: '' ;
	package: 'FluidClassDefinition-Printer-UnderDev'
```

is the template definition for the fluid syntax


This is the fluid definition of the current class :).

```
ClassDefinitionPrinter < #FluidClassDefinitionPrinter
	tag: 'Printer-UnderDev';
	package: 'FluidClassDefinition'
```


"
Class {
	#name : #FluidClassDefinitionPrinter,
	#superclass : #ClassDefinitionPrinter,
	#category : #'FluidClassDefinition-Printer'
}

{ #category : #running }
FluidClassDefinitionPrinter >> classDefinitionParserClass [

	^ CDFluidClassDefinitionParser
]

{ #category : #'definition double dispatch API' }
FluidClassDefinitionPrinter >> classDefinitionString [

	"Next step
		- some of the methods defined on classe will have to be moved in this class.
		- refactor to remove duplication with metaclass,...."

	^ String streamContents: [ :s | 
		  forClass superclass
			  ifNotNil: [ s nextPutAll: forClass superclass name ]
			  ifNil: [ s nextPutAll: 'nil' ].
		  s
			  nextPutAll: ' < #';
			  nextPutAll: forClass name;
			  cr.

		  forClass classLayout isFixedLayout ifFalse: [ self layoutOn: s ].

		  forClass hasTraitComposition ifTrue: [ 
			  s tab.
			  self traitCompositionOn: s.
			  s cr ].

		  forClass slots ifNotEmpty: [ self slotsOn: s ].
		  forClass classVariables ifNotEmpty: [ self sharedVariablesOn: s ].
		  forClass sharedPools ifNotEmpty: [ self sharedPoolsOn: s ].

		  self tagOn: s.
		  self packageOn: s ]
]

{ #category : #'expanded double dispatch API' }
FluidClassDefinitionPrinter >> expandedClassDefinitionString [

	^ String streamContents: [ :s | 
		  s
			  nextPutAll: 'Object < #' , forClass name asSymbol;
			  cr.
		  self layoutOn: s.
		  s tab.
		  forClass hasTraitComposition
			  ifTrue: [ self traitCompositionOn: s ]
			  ifFalse: [ s nextPutAll: 'uses: {};' ].
		  s cr.
		  self slotsOn: s.
		  self sharedVariablesOn: s.
		  forClass hasTraitComposition.
		  self sharedPoolsOn: s.
		
		(forClass package classTagForClass: forClass) ifNotNil: [ :t |
			| tag | 
			tag := t name.
			tag = forClass package name 
				ifTrue: [ s tab; nextPutAll: 'tag: '''';'; cr ]
				ifFalse: [ self tagOn: s]].
		  self packageOn: s ]
]

{ #category : #'expanded double dispatch API' }
FluidClassDefinitionPrinter >> expandedMetaclassDefinitionString [
	
	^ String streamContents: [ :s | 
						forClass  
							ifNotNil: [ s nextPutAll: forClass name ]
							ifNil: [ s nextPutAll: 'ProtoObject ' ].
						
						s crtab. 
						
						forClass hasTraitComposition 
							ifTrue: [
								s 
									nextPutAll: 'uses: ';
									nextPutAll: forClass traitCompositionString;
									nextPutAll: ';']
							ifFalse: [ s nextPutAll: 'uses: {};'].
						s crtab.

						s nextPutAll: 'slots: '.
						forClass slotDefinitionStringOn: s. 
						]
]

{ #category : #'expanded double dispatch API' }
FluidClassDefinitionPrinter >> expandedTraitDefinitionString [
	
	^ String streamContents: [ :s |		
		| tag |
		s 
			nextPutAll: 'Trait  << #';
			nextPutAll: forClass name;
			cr.

			forClass hasTraitComposition 
							ifTrue: [
								s 
									nextPutAll: 'uses: ';
									nextPutAll: forClass traitCompositionString ]
							ifFalse: [ s nextPutAll: 'uses: {};'].
						s crtab.

				s nextPutAll: 'slots: ', forClass slotDefinitionString, ';'; crtab. 
						s 	
							nextPutAll: 'sharedVariables: ';
							nextPutAll: forClass classVariableDefinitionString;
							nextPutAll: ';'; crtab.
							
						s nextPutAll: 'sharedPools: {'.
						forClass sharedPoolStringOn: s.
						s nextPutAll: '};' ; crtab.
						
						(forClass package classTagForClass: forClass) ifNotNil: [:t | 
							tag := t name.
							tag = forClass package name
								ifFalse:  [
									s nextPutAll: 'tag: '; 
					nextPut: $'; 
					nextPutAll: tag asString ; 
					nextPutAll: ''';'.
					s crtab
				]].
				
				s 
					nextPutAll: 'package: ''';
					nextPutAll: forClass package packageName;
					nextPutAll: '''' ]
]

{ #category : #printing }
FluidClassDefinitionPrinter >> fullyExpandedDefinitionString [
	^ forClass definitionFullyExpandedButPackage: forClass package packageName
]

{ #category : #'elementary operations' }
FluidClassDefinitionPrinter >> layoutOn: s [

	s
		tab;
		nextPutAll: 'layout: ';
		nextPutAll: forClass classLayout class name;
		nextPutAll: ';';
		cr
]

{ #category : #'definition double dispatch API' }
FluidClassDefinitionPrinter >> metaclassDefinitionString [ 

	^ String streamContents: [ :s |
		
		forClass superclass 
			ifNotNil: [ s nextPutAll: forClass name ]
			ifNil: [ s nextPutAll: 'ProtoObject ' ].
		
		forClass hasTraitComposition ifTrue: [
			s 
				crtab; 
				nextPutAll: 'uses: ';
				nextPutAll: forClass traitCompositionString ;
				nextPutAll: ';';
				cr ].
		
		forClass slots ifNotEmpty: 
			[ 
				s crtab.
				s nextPutAll: 'slots: '.
				forClass slotDefinitionStringOn: s ].
		]
]

{ #category : #'definition double dispatch API' }
FluidClassDefinitionPrinter >> packageOn: s [

	s
		tab;
	 	nextPutAll: 'package: ';
		nextPut: $';
		nextPutAll: forClass package packageName;
		nextPut: $'
]

{ #category : #'elementary operations' }
FluidClassDefinitionPrinter >> sharedPoolsOn: s [
	| hasPools |
	hasPools := forClass sharedPools isNotEmpty.
	s
		tab;
		nextPutAll: 'sharedPools: {'.
	hasPools ifTrue: [ s space ].
	forClass sharedPools
		do: [ :p | s nextPutAll: p name ]
		separatedBy: [ s nextPutAll: ' . ' ].
	hasPools ifTrue: [ s space ].
	s
		nextPutAll: '};';
		cr
]

{ #category : #'elementary operations' }
FluidClassDefinitionPrinter >> sharedVariablesOn: s [

	s
		tab;
		nextPutAll: 'sharedVariables: ';
		nextPutAll: forClass classVariableDefinitionString;
		nextPutAll: ';';
		cr
]

{ #category : #'elementary operations' }
FluidClassDefinitionPrinter >> slotsOn: s [

	s tab.
	s nextPutAll: 'slots: '.
	forClass slotDefinitionStringOn: s.
	s nextPutAll: ';'.
	s cr
]

{ #category : #'expanded double dispatch API' }
FluidClassDefinitionPrinter >> tagOn: s [

	| tag |
	(forClass package classTagForClass: forClass) ifNotNil: [ :t | 
		tag := t name.
		tag = forClass package name ifFalse: [ 
			s tab.
			s
				nextPutAll: 'tag: ';
				nextPut: $';
				nextPutAll: tag asString;
				nextPutAll: ''';'.
			s cr ] ]
]

{ #category : #'expanded double dispatch API' }
FluidClassDefinitionPrinter >> traitCompositionOn: s [

	s
		nextPutAll: 'uses: ';
		nextPutAll: forClass traitCompositionString;
		nextPutAll: ';'
]

{ #category : #'definition double dispatch API' }
FluidClassDefinitionPrinter >> traitDefinitionString [ 

	^ String streamContents: [ :s |		
		s 
			nextPutAll: 'Trait  << #';
			nextPutAll: forClass name;
			cr.
		
		forClass hasTraitComposition ifTrue: [
			s 
				tab; 
				nextPutAll: 'uses: ';
				nextPutAll: forClass traitCompositionString ;
				nextPutAll: ';';
				cr ].
		
		forClass slots ifNotEmpty: [ 
					s tab.
					s nextPutAll: 'slots: '.
					forClass slotDefinitionStringOn: s.
					s nextPutAll: ';'.
					s cr ].
				
		self tagOn: s.
		
		s 	
			tab;
			nextPutAll: 'package: '; 
			nextPut: $';
			nextPutAll: forClass package packageName;
			nextPut: $'
		]
]

{ #category : #'definition double dispatch API' }
FluidClassDefinitionPrinter >> traitedMetaclassDefinitionString [

	^ String streamContents: 
		[:strm |
		strm nextPutAll: forClass name.
		
		forClass hasTraitComposition ifTrue: [
			strm
				crtab;
				nextPutAll: 'uses: ';
				print: forClass traitComposition ].
		forClass slots ifNotEmpty: [  
			strm
				crtab;
				nextPutAll: 'slots: '.
			forClass slotDefinitionStringOn: strm	]]
]
