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

{ #category : #testing }
CDFluidClassDefinitionValidator >> isValidClassName: aString [ 

	^ aString first isLetter and: [ aString first isUppercase and: [ aString isAllAlphaNumerics ]]
]

{ #category : #testing }
CDFluidClassDefinitionValidator >> treeIsValid: aCDClassDefinitionNode [ 
	self shouldBeImplemented.
]

{ #category : #testing }
CDFluidClassDefinitionValidator >> validClassName: aString [ 

	^ aString first isLetter and: [ aString first isUppercase and: [ aString isAllAlphaNumerics ]]
]

{ #category : #operations }
CDFluidClassDefinitionValidator >> validate: aCDClassDefinitionNode [ 
	self validateClassName: aCDClassDefinitionNode.
]

{ #category : #testing }
CDFluidClassDefinitionValidator >> validateClassName: aCDClassDefinitionNode [ 
	| aString |
	aString := aCDClassDefinitionNode className.
	(aString isSymbol and: [ self validClassName: aString ])	
		ifFalse: [ self addError: (CDValidationReport new 
							message: 'A class name should start with an uppercase, followed by letter or digits';
							actualTokens: {aString})
							].

]
