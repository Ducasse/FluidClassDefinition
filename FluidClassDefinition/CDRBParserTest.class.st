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

	| tokens parser node |
	tokens := RBScanner scanTokenObjects: '1 + 2'.
	tokens := tokens asOrderedCollection. 
	tokens addLast: RBToken new.
	parser := CDRBParser new initializeWithTokenStream: (ReadStream on: tokens).
	node := parser parseExpressionFromTokens.	
	self assert: node class = RBSequenceNode
]

{ #category : #tests }
CDRBParserTest >> testExample2 [

	| tokens parser node |
	tokens := RBScanner scanTokenObjects: 'MyTrait + (AnotherTrait - {#selector} @ {#selector1 -> #selector})'.
	tokens := tokens asOrderedCollection. 
	tokens addLast: RBToken new.
	parser := CDRBParser new 
		initializeWithTokenStream: (ReadStream on: tokens).
	node := parser parseExpressionFromTokens.
	self assert: node class equals: RBSequenceNode.

	
]

{ #category : #tests }
CDRBParserTest >> testExample3 [

	| tokens parser node |
	tokens := RBScanner scanTokenObjects: 'MyTrait + AnotherTrait'.
	tokens := tokens asOrderedCollection. 
	tokens addLast: RBToken new.
	parser := CDRBParser new 
		initializeWithTokenStream: (ReadStream on: tokens).
	node := parser parseExpressionFromTokens.
	self assert: node class equals: RBSequenceNode.

]

{ #category : #tests }
CDRBParserTest >> testExampleTageProblem [

	| tokens parser node |
	tokens := RBScanner scanTokenObjects: ' #(Core)'.
	tokens := tokens asOrderedCollection. 
	tokens addLast: RBToken new.
	parser := CDRBParser new initializeWithTokenStream: (ReadStream on: tokens).
	node := parser parseExpressionFromTokens.	
	self assert: node class = RBSequenceNode.
	self assert: node statements first value equals: #(#Core)
]

{ #category : #tests }
CDRBParserTest >> testExampleTageProblem2 [

	| tokens parser node |
	tokens := RBScanner scanTokenObjects: ' #(''Core'')'.
	tokens := tokens asOrderedCollection. 
	tokens addLast: RBToken new.
	parser := CDRBParser new initializeWithTokenStream: (ReadStream on: tokens).
	node := parser parseExpressionFromTokens.	
	self assert: node class = RBSequenceNode
]

{ #category : #tests }
CDRBParserTest >> testExampleTageProblem3 [

	| tokens parser node |
	tokens := RBScanner scanTokenObjects: ' #(#Core)'.
	tokens := tokens asOrderedCollection. 
	tokens addLast: RBToken new.
	parser := CDRBParser new initializeWithTokenStream: (ReadStream on: tokens).
	node := parser parseExpressionFromTokens.	
	self assert: node class = RBSequenceNode
]
