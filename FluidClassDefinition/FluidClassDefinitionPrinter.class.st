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
	#category : #'FluidClassDefinition-Printer-UnderDev'
}

{ #category : #running }
FluidClassDefinitionPrinter >> classDefinitionParserClass [

	^ CDFluidClassDefinitionParser
]

{ #category : #'double dispatch API' }
FluidClassDefinitionPrinter >> classDefinitionString [ 
	"Next step
		- some of the methods defined on classe will have to be moved in this class.
		- refactor to remove duplication with metaclass,...."
	
	^ String streamContents: [ :s |
		forClass superclass 
			ifNotNil: [s nextPutAll: forClass superclass name]
			ifNil: [s nextPutAll: 'nil'].
		s 
			nextPutAll: ' < #';
			nextPutAll: forClass name;
			cr.
		
		forClass classLayout isFixedLayout ifFalse: [
			s 
				tab; 
				nextPutAll: 'layout: ';
				nextPutAll: forClass classLayout class name;
				nextPutAll: ';';
				cr ].
		
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
		forClass classVariables ifNotEmpty: [  
				s 
					tab;
					nextPutAll: 'sharedVariables: ';
					nextPutAll: forClass classVariableDefinitionString;
					nextPutAll: ';';
					cr
				].
			
		forClass sharedPools ifNotEmpty: [:pools |
			s 
				tab ; 
				nextPutAll: 'sharedPools: { '.
			pools do: 	[ :p | s nextPutAll: p name ] separatedBy: [ s nextPutAll: ' . ' ].
			s	nextPutAll: ' };' ;
				cr ].	
			
		forClass tagOn: s.
				
		s 	
			tab;
			nextPutAll: 'package: '; 
			nextPut: $';
			nextPutAll: forClass package packageName;
			nextPut: $'
		]
]

{ #category : #printing }
FluidClassDefinitionPrinter >> expandedDefinitionString [
	^ forClass definitionExpanded 
]

{ #category : #printing }
FluidClassDefinitionPrinter >> fullyExpandedDefinitionString [
	^ forClass definitionFullyExpandedButPackage: forClass package packageName
]

{ #category : #'double dispatch API' }
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

{ #category : #'double dispatch API' }
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
				
		forClass tagOn: s.
		
		s 	
			tab;
			nextPutAll: 'package: '; 
			nextPut: $';
			nextPutAll: forClass package packageName;
			nextPut: $'
		]
]

{ #category : #'double dispatch API' }
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
