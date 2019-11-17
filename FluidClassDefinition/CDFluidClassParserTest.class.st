"
I am a copy of class CDNewPointClassParserTest. This comment is copied from there, and might not be entirely accurate

This class contains tests
"
Class {
	#name : #CDFluidClassParserTest,
	#superclass : #TestCase,
	#instVars : [
		'classDefinition'
	],
	#category : #FluidClassDefinition
}

{ #category : #running }
CDFluidClassParserTest >> classDefinitionParserClass [

	^ CDFluidClassDefinitionParser
]

{ #category : #running }
CDFluidClassParserTest >> classDefinitionString [

	^ self subclassResponsibility 
]

{ #category : #helpers }
CDFluidClassParserTest >> className [

	^ #Point
]

{ #category : #helpers }
CDFluidClassParserTest >> firstClassVariableName [

	^ 'XX'
]

{ #category : #helpers }
CDFluidClassParserTest >> firstInstanceVariableName [

	^ 'x'
]

{ #category : #helpers }
CDFluidClassParserTest >> packageName [ 
	^ #'Kernel-BasicObjects'
]

{ #category : #helpers }
CDFluidClassParserTest >> secondClassVariableName [

	^ 'YY'
]

{ #category : #helpers }
CDFluidClassParserTest >> secondInstanceVariableName [

	^ 'y'
]

{ #category : #running }
CDFluidClassParserTest >> setUp [
	super setUp.
	classDefinition := self classDefinitionParserClass parse: self classDefinitionString.
	
]

{ #category : #helpers }
CDFluidClassParserTest >> superclassName [

	^ #Object 
]
