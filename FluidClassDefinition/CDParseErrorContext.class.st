Class {
	#name : #CDParseErrorContext,
	#superclass : #Object,
	#instVars : [
		'fullTokens',
		'expectedTokens',
		'actualTokens'
	],
	#category : #'FluidClassDefinition-Core'
}

{ #category : #accessing }
CDParseErrorContext >> actualTokens [
	^ actualTokens
]

{ #category : #accessing }
CDParseErrorContext >> actualTokens: anObject [
	actualTokens := anObject
]

{ #category : #accessing }
CDParseErrorContext >> expectedTokens [
	^ expectedTokens
]

{ #category : #accessing }
CDParseErrorContext >> expectedTokens: anObject [
	expectedTokens := anObject
]

{ #category : #accessing }
CDParseErrorContext >> fullTokens [
	^ fullTokens
]

{ #category : #accessing }
CDParseErrorContext >> fullTokens: anObject [
	fullTokens := anObject
]

{ #category : #accessing }
CDParseErrorContext >> printOn: aStream [

	aStream 
		<< 'We got ' 
		<< actualTokens asString 
		<< ' instead of ' 
		<< expectedTokens asString 
		<< ' in '
		<< fullTokens asString
]
