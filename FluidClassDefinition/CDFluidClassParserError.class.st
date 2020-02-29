Class {
	#name : #CDFluidClassParserError,
	#superclass : #Error,
	#instVars : [
		'parseContext'
	],
	#category : #'FluidClassDefinition-NewApproach'
}

{ #category : #accessing }
CDFluidClassParserError >> parseContext [
	^ parseContext
]

{ #category : #accessing }
CDFluidClassParserError >> parseContext: anObject [
	parseContext := anObject
]
