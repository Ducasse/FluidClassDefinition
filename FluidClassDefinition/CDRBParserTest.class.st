"
I would like to understand if I can pass to the parser the RBTokens of an expression and get back the corresponding node. 


This class contains tests but it is not linked to the other test superclass as it was done in CD (class Definition package).
This class may be split later in different classes.


For example 

| tokens |
tokens := RBScanner scanTokenObjects: 'MyTrait + (AnotherTrait - {#selector} @ {#selector1 -> #selector})'
"
Class {
	#name : #CDRBParserTest,
	#superclass : #TestCase,
	#category : #'FluidClassDefinition-Parser'
}

{ #category : #tests }
CDRBParserTest >> testExample1 [

	| tokens |
	tokens := RBScanner scanTokenObjects: 'MyTrait + (AnotherTrait - {#selector} @ {#selector1 -> #selector})'.
	RBParser new 
	
]

{ #category : #tests }
CDRBParserTest >> testExample2 [

	| tokens parser |
	tokens := RBScanner scanTokenObjects: 'MyTrait + (AnotherTrait - {#selector} @ {#selector1 -> #selector})'.
	parser := CDRBParser new 
		initializeWithTokenStream: (ReadStream on: tokens).
	parser parseExpressionFromTokens	
	
]

{ #category : #tests }
CDRBParserTest >> testExample3 [

	| tokens parser |
	tokens := RBScanner scanTokenObjects: 'MyTrait + AnotherTrait'.
	parser := CDRBParser new 
		initializeWithTokenStream: (ReadStream on: tokens).
	parser parseExpressionFromTokens	
	
]
