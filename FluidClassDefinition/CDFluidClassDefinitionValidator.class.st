Class {
	#name : #CDFluidClassDefinitionValidator,
	#superclass : #Object,
	#instVars : [
		'errors'
	],
	#category : #'FluidClassDefinition-NewApproach'
}

{ #category : #initialization }
CDFluidClassDefinitionValidator >> addError: anError [

	errors add: anError
]

{ #category : #accessing }
CDFluidClassDefinitionValidator >> errors [
	^ errors
]

{ #category : #initialization }
CDFluidClassDefinitionValidator >> initialize [

	super initialize.
	errors := OrderedCollection new. 
]

{ #category : #utils }
CDFluidClassDefinitionValidator >> isValidClassName: aString [ 

	^ aString first isLetter and: [ aString first isUppercase and: [ aString isAllAlphaNumerics ]]
]

{ #category : #utils }
CDFluidClassDefinitionValidator >> validClassName: aString [ 

	^ aString first isLetter and: [ aString first isUppercase and: [ aString isAllAlphaNumerics ]]
]

{ #category : #operations }
CDFluidClassDefinitionValidator >> validate: aCDClassDefinitionNode [ 
	self validateSuperclass: aCDClassDefinitionNode.
	self validateClassName: aCDClassDefinitionNode.
	self validateCreationMessage: aCDClassDefinitionNode.
]

{ #category : #operations }
CDFluidClassDefinitionValidator >> validateClassName: aCDClassDefinitionNode [ 

	| aString |
	aString := aCDClassDefinitionNode className.
	(aString isSymbol and: [ self validClassName: aString ])	
		ifFalse: [ self addError: 
						(CDValidationReport new 
							message: 'A class name should start with an uppercase, followed by letter or digits';
							actualTokens: {aString})
							].

]

{ #category : #operations }
CDFluidClassDefinitionValidator >> validateCreationMessage: aCDClassDefinitionNode [

	| aSelector |
	aSelector := aCDClassDefinitionNode selector.
	( aSelector = #< )
		ifFalse: [ self addError: (CDMainMessageReport new actualTokens: { aSelector }; fullTokens: aCDClassDefinitionNode tokens) ].
]

{ #category : #operations }
CDFluidClassDefinitionValidator >> validateSuperclass: aCDClassDefinitionNode [
	"We do not check that the class exist because a class definition can be about classes elsewhere than in the image."
	
	| aString |
	aString := aCDClassDefinitionNode superclassName.
	(aString isString and: [ self validClassName: aString ])
		ifFalse: [ self addError: (CDSuperclassReport new actualTokens: { aString }; fullTokens: aCDClassDefinitionNode tokens) ].
]
