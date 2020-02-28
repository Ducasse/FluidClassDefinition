Class {
	#name : #CDFluidClassDefinitionValidator,
	#superclass : #Object,
	#category : #'FluidClassDefinition-NewApproach'
}

{ #category : #testing }
CDFluidClassDefinitionValidator >> isValidClassName: aString [ 

	^ aString first isLetter and: [ aString first isUppercase and: [ aString isAllAlphaNumerics ]]
]

{ #category : #testing }
CDFluidClassDefinitionValidator >> treeIsValid: aCDClassDefinitionNode [ 
	self shouldBeImplemented.
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
		ifFalse: [ CDValidationReport new 
							message: 'A class name should start with an uppercase, followed by letter or digits';
							actualTokens: {aString}
							].

]
