Class {
	#name : #CDFluidClassParserError,
	#superclass : #Error,
	#instVars : [
		'parseContext'
	],
	#category : #'FluidClassDefinition-Core'
}

{ #category : #accessing }
CDFluidClassParserError >> parseContext [
	^ parseContext
]

{ #category : #accessing }
CDFluidClassParserError >> parseContext: anObject [
	parseContext := anObject
]
