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

{ #category : #'test package' }
CDAutonomousManualFluidClassParserTest >> testClassDefPackageIsCorrect [
	
	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.
	self assert: def packageName equals: 'Kernel-BasicObjects'
]

{ #category : #'test  <' }
CDAutonomousManualFluidClassParserTest >> testClassSideDefinitionIsClassSide [

	| def |
	def := self classDefinitionParserClass parse: 'Object class < #Point
			package: #''Kernel-BasicObjects'''.

	self assert: def isClassSideDefinition 
]

{ #category : #'test  <' }
CDAutonomousManualFluidClassParserTest >> testInstanceClassDefinitionIsInstanceSide [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: #''Kernel-BasicObjects'''.

	self assert: def isInstanceSideDefinition 
]

{ #category : #'test package' }
CDAutonomousManualFluidClassParserTest >> testSplittingTokens [

	self assert: (RBParser parseLiterals: 
	'Object < #CDAbstractClassDefinitionParser
	slots: { #classDefinition. #subclass => BooleanSlot };
	classVariables: {  };
	package: ''FluidClassDefinition''') equals: #(#Object #< #CDAbstractClassDefinitionParser #slots: #'{' #classDefinition #'.' #subclass #'=>' #BooleanSlot #'}' #';' #classVariables: #'{' #'}' #';' #package: 'FluidClassDefinition')
]

{ #category : #'test  <' }
CDAutonomousManualFluidClassParserTest >> testWrongClassDefShouldNotBeClassSide [

	self should: [ self classDefinitionParserClass parse: 'Object --- #Point
			package: #''Kernel-BasicObjects'''] raise: CDFluidClassParserError.

]

{ #category : #'test  <' }
CDAutonomousManualFluidClassParserTest >> testWrongClassDefShouldNotBeClassSide2 [

	self should: [ self classDefinitionParserClass parse: 'Object blbl: #Point
			package: #''Kernel-BasicObjects'''] raise: CDFluidClassParserError 

]
