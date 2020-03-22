Class {
	#name : #CDRBParser,
	#superclass : #RBParser,
	#instVars : [
		'tokenStream'
	],
	#category : #'FluidClassDefinition-Parser'
}

{ #category : #parsing }
CDRBParser class >> parseUsingToken: aCollection [

	| parser aString node |
	self parseUsingTokenStream: (ReadStream on: aCollection).
	node := parser parseExpression: aString.
	^(node statements size == 1 and: [node temporaries isEmpty]) 
		ifTrue: [node statements first]
		ifFalse: [node]
]

{ #category : #parsing }
CDRBParser class >> parseUsingTokenStream: aStream [

	^ self new initializeWithTokenStream: aStream
]

{ #category : #initialization }
CDRBParser >> initializeWithTokenStream: aStream [

	tokenStream := aStream.
	self step.
]

{ #category : #parsing }
CDRBParser >> parseExpressionFromTokens [
	"Parse and return an AST corresponding to the expression parser via initializeWithTokenStream."
	
	| node |
	node := self parseStatements: false.
	^node
]

{ #category : #initialization }
CDRBParser >> scannerNext [

	^ tokenStream next
]
