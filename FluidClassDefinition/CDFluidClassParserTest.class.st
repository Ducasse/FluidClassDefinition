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

{ #category : #tests }
CDFluidClassParserTest >> className [

	^ #Point
]

{ #category : #tests }
CDFluidClassParserTest >> firstClassVariableName [

	^ 'XX'
]

{ #category : #tests }
CDFluidClassParserTest >> firstInstanceVariableName [

	^ 'x'
]

{ #category : #helpers }
CDFluidClassParserTest >> packageName [ 
	^ #'Kernel-BasicObjects'
]

{ #category : #tests }
CDFluidClassParserTest >> secondClassVariableName [

	^ 'YY'
]

{ #category : #tests }
CDFluidClassParserTest >> secondInstanceVariableName [

	^ 'y'
]

{ #category : #running }
CDFluidClassParserTest >> setUp [
	super setUp.
	classDefinition := self classDefinitionParserClass parse: self classDefinitionString.
	
]

{ #category : #tests }
CDFluidClassParserTest >> superclassName [

	^ #Object 
]

{ #category : #tests }
CDFluidClassParserTest >> testClassDefFromLegacyStringHasSlots [
	
	self assert: classDefinition slotNodes first name equals: self firstInstanceVariableName.
	self assert: classDefinition slotNodes second name equals: self secondInstanceVariableName.
]

{ #category : #helpers }
CDFluidClassParserTest >> testProperties [

	self assert: classDefinition binding equals: Point binding
]
