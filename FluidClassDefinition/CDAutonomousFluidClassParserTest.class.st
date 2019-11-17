Class {
	#name : #CDAutonomousFluidClassParserTest,
	#superclass : #TestCase,
	#instVars : [
		'classDefinition'
	],
	#category : #FluidClassDefinition
}

{ #category : #running }
CDAutonomousFluidClassParserTest >> classDefinitionParserClass [

	^ CDFluidClassDefinitionParser
]

{ #category : #'standalone tests' }
CDAutonomousFluidClassParserTest >> testClassSideDefinitionIsClassSide [

	| def |
	def := self classDefinitionParserClass parse: 'Object class < #Point
			package: #''Kernel-BasicObjects'''.

	self assert: def isClassSideDefinition 
]

{ #category : #'standalone tests' }
CDAutonomousFluidClassParserTest >> testInstanceClassDefinitionIsInstanceSide [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: #''Kernel-BasicObjects'''.

	self assert: def isInstanceSideDefinition 
]

{ #category : #'standalone tests' }
CDAutonomousFluidClassParserTest >> testWrongClassDefShouldNotBeClassSide [

	self should: [ self classDefinitionParserClass parse: 'Object --- #Point
			package: #''Kernel-BasicObjects'''] raise: CDFluidClassParserError.

]

{ #category : #'standalone tests' }
CDAutonomousFluidClassParserTest >> testWrongClassDefShouldNotBeClassSide2 [

	self should: [ self classDefinitionParserClass parse: 'Object blbl: #Point
			package: #''Kernel-BasicObjects'''] raise: CDFluidClassParserError 

]
