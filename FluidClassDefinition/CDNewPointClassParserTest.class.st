Class {
	#name : #CDNewPointClassParserTest,
	#superclass : #CDClassDefinitionParserTest,
	#category : #'FluidClassDefinition-MessageBasedVersion'
}

{ #category : #running }
CDNewPointClassParserTest >> classDefinitionParserClass [
	^ CDFluidClassDefinitionParser
]

{ #category : #helpers }
CDNewPointClassParserTest >> classDefinitionString [

	^ 'Object <<< #Point
			slots: {#x . #y};
			classVariables: { #XX . #YY};
			package: #''Kernel-BasicObjects'''
]

{ #category : #tests }
CDNewPointClassParserTest >> className [

	^ #Point
]

{ #category : #tests }
CDNewPointClassParserTest >> firstClassVariableName [

	^ 'XX'
]

{ #category : #tests }
CDNewPointClassParserTest >> firstInstanceVariableName [

	^ 'x'
]

{ #category : #helpers }
CDNewPointClassParserTest >> packageName [ 
	^ #'Kernel-BasicObjects'
]

{ #category : #tests }
CDNewPointClassParserTest >> secondClassVariableName [

	^ 'YY'
]

{ #category : #tests }
CDNewPointClassParserTest >> secondInstanceVariableName [

	^ 'y'
]

{ #category : #running }
CDNewPointClassParserTest >> setUp [

	super setUp.
	classDefinition := CDFluidClassDefinitionParser parse: self classDefinitionString.
]

{ #category : #tests }
CDNewPointClassParserTest >> superclassName [

	^ #Object 
]

{ #category : #tests }
CDNewPointClassParserTest >> testClassDefFromLegacyStringHasSlots [
	
	self assert: classDefinition slotNodes first name equals: self firstInstanceVariableName.
	self assert: classDefinition slotNodes second name equals: self secondInstanceVariableName.
]

{ #category : #helpers }
CDNewPointClassParserTest >> testProperties [

	self assert: classDefinition binding equals: Point binding
]
