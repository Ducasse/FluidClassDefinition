Class {
	#name : #CDAutonomousManualFluidClassParserTest,
	#superclass : #TestCase,
	#instVars : [
		'classDefinition'
	],
	#category : #FluidClassDefinition
}

{ #category : #running }
CDAutonomousManualFluidClassParserTest >> classDefinitionParserClass [

	^ CDManualFluidClassDefinitionParser
]

{ #category : #tests }
CDAutonomousManualFluidClassParserTest >> testClassSideDefinitionIsClassSide [

	| def |
	def := self classDefinitionParserClass parse: 'Object class < #Point
			package: #''Kernel-BasicObjects'''.

	self assert: def isClassSideDefinition 
]

{ #category : #tests }
CDAutonomousManualFluidClassParserTest >> testInstanceClassDefinitionIsInstanceSide [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: #''Kernel-BasicObjects'''.

	self assert: def isInstanceSideDefinition 
]

{ #category : #tests }
CDAutonomousManualFluidClassParserTest >> testWrongClassDefShouldNotBeClassSide [

	self should: [ self classDefinitionParserClass parse: 'Object --- #Point
			package: #''Kernel-BasicObjects'''] raise: CDFluidClassParserError.

]

{ #category : #tests }
CDAutonomousManualFluidClassParserTest >> testWrongClassDefShouldNotBeClassSide2 [

	self should: [ self classDefinitionParserClass parse: 'Object blbl: #Point
			package: #''Kernel-BasicObjects'''] raise: CDFluidClassParserError 

]
