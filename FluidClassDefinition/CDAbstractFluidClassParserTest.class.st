"
I am a copy of class CDNewPointClassParserTest. This comment is copied from there, and might not be entirely accurate

This class contains tests
"
Class {
	#name : #CDAbstractFluidClassParserTest,
	#superclass : #TestCase,
	#instVars : [
		'classDefinition'
	],
	#category : #'FluidClassDefinition-MessageBasedVersion'
}

{ #category : #running }
CDAbstractFluidClassParserTest >> classDefinitionParserClass [

	^ CDTreeBasedFluidClassDefinitionParser
]

{ #category : #running }
CDAbstractFluidClassParserTest >> classDefinitionString [

	^ self subclassResponsibility 
]

{ #category : #helpers }
CDAbstractFluidClassParserTest >> className [

	^ #Point
]

{ #category : #helpers }
CDAbstractFluidClassParserTest >> firstClassVariableName [

	^ 'XX'
]

{ #category : #helpers }
CDAbstractFluidClassParserTest >> firstInstanceVariableName [

	^ 'x'
]

{ #category : #helpers }
CDAbstractFluidClassParserTest >> packageName [ 
	^ #'Kernel-BasicObjects'
]

{ #category : #helpers }
CDAbstractFluidClassParserTest >> secondClassVariableName [

	^ 'YY'
]

{ #category : #helpers }
CDAbstractFluidClassParserTest >> secondInstanceVariableName [

	^ 'y'
]

{ #category : #running }
CDAbstractFluidClassParserTest >> setUp [
	super setUp.
	classDefinition := self classDefinitionParserClass parse: self classDefinitionString.
	
]

{ #category : #helpers }
CDAbstractFluidClassParserTest >> superclassName [

	^ #Object 
]
