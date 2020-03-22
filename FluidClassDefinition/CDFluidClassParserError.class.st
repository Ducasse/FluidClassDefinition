Class {
	#name : #CDFluidClassParserError,
	#superclass : #Error,
	#instVars : [
		'parseContext'
	],
	#category : #'FluidClassDefinition-Parser'
}

{ #category : #accessing }
CDFluidClassParserError >> parseContext [
	^ parseContext
]

{ #category : #accessing }
CDFluidClassParserError >> parseContext: anObject [
	parseContext := anObject
]
