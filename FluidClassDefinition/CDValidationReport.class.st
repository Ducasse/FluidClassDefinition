Class {
	#name : #CDValidationReport,
	#superclass : #Object,
	#instVars : [
		'fullTokens',
		'expectedTokens',
		'actualTokens',
		'message'
	],
	#category : #'FluidClassDefinition-NewApproach'
}

{ #category : #accessing }
CDValidationReport >> actualTokens [
	^ actualTokens
]

{ #category : #accessing }
CDValidationReport >> actualTokens: anObject [
	actualTokens := anObject
]

{ #category : #accessing }
CDValidationReport >> expectedTokens [
	^ expectedTokens
]

{ #category : #accessing }
CDValidationReport >> expectedTokens: anObject [
	expectedTokens := anObject
]

{ #category : #accessing }
CDValidationReport >> fullTokens [
	^ fullTokens
]

{ #category : #accessing }
CDValidationReport >> fullTokens: anObject [
	fullTokens := anObject
]

{ #category : #accessing }
CDValidationReport >> message: aString [

	message := aString
]
