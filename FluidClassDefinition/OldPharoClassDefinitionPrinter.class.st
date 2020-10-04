Class {
	#name : #OldPharoClassDefinitionPrinter,
	#superclass : #ClassDefinitionPrinter,
	#category : #'FluidClassDefinition-Printer-UnderDev'
}

{ #category : #delegating }
OldPharoClassDefinitionPrinter >> definitionString [

	| poolString stream |
	poolString := forClass sharedPoolsString.
	stream := (String new: 800) writeStream.
	forClass superclass
		ifNotNil: [ stream nextPutAll: forClass superclass name ]
		ifNil: [ stream nextPutAll: 'ProtoObject' ].
	
	stream
		nextPutAll: forClass kindOfSubclass;
		store: forClass name.
		
	forClass hasTraitComposition ifTrue: [ 
		stream
			crtab;
			nextPutAll: 'uses: ';
			nextPutAll: forClass traitCompositionString ].
	
	stream
		crtab;
		nextPutAll: 'instanceVariableNames: '''.
	forClass instanceVariablesOn: stream.
	stream nextPut: $'.
	
	stream
		crtab;
		nextPutAll: 'classVariableNames: '''.
	forClass classVariablesOn: stream.
	stream nextPut: $'.
	
	poolString = '' ifFalse: [ 
		stream 
			crtab;
			nextPutAll: 'poolDictionaries: ';
			store: poolString ].
	
	stream
		crtab;
		nextPutAll: 'package: ';
		store: forClass category asString.
		
	forClass superclass ifNil: [ 
		stream
			nextPutAll: '.';
			cr.
		stream 
			nextPutAll: forClass name.
		stream
			space;
			nextPutAll: 'superclass: nil' ].

	^ stream contents
]

{ #category : #delegating }
OldPharoClassDefinitionPrinter >> metaclassDefinitionString [ 
	"Next step
		- some of the methods defined on classe will have to be moved in this class.
		- refactor to remove duplication with metaclass,...."

	^ String streamContents: [:stream |
		stream print: forClass.
		stream
			crtab;
			nextPutAll: 'instanceVariableNames: '''.
		forClass instanceVariablesOn: stream.
		stream nextPut: $' ]
]
