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
CDRBParser >> patchLiteralArrayToken [
	
	(currentToken isIdentifier and: 
			[self nextToken isAssignment 
				and: [currentToken stop + 1 = self nextToken start]]) 
		ifTrue: 
			[currentToken := RBLiteralToken 
						value: (currentToken value , ':') asSymbol
						start: currentToken start
						stop: self nextToken start.
			nextToken := RBLiteralToken 
						value: #=
						start: nextToken stop
						stop: nextToken stop.
			^self].
	currentToken isAssignment 
		ifTrue: 
			[currentToken := RBLiteralToken 
						value: #':'
						start: currentToken start
						stop: currentToken start.
			nextToken := RBLiteralToken 
						value: #=
						start: currentToken stop
						stop: currentToken stop.
			^self].
	currentToken isSpecial 
		ifTrue: 
			[currentToken := RBLiteralToken 
						value: (String with: currentToken value) asSymbol
						start: currentToken start
						stop: currentToken stop.
			^self].
	(currentToken isIdentifier and: [currentToken value includes: $.]) 
		ifTrue: 
			[currentToken := RBLiteralToken 
						value: currentToken value
						start: currentToken start
						stop: currentToken stop.
			^self].
	(currentToken isIdentifier 
		or: [currentToken isBinary or: [currentToken isKeyword]]) 
			ifFalse: [^self parserError: 'Invalid token'].
	currentToken := RBLiteralToken 
				value: currentToken value asSymbol
				start: currentToken start
				stop: currentToken stop
				source: currentToken value asSymbol printString.
]

{ #category : #initialization }
CDRBParser >> scannerNext [

	^ tokenStream next
]
