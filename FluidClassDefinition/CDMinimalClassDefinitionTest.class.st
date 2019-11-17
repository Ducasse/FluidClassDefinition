Class {
	#name : #CDMinimalClassDefinitionTest,
	#superclass : #CDFluidClassParserTest,
	#category : #FluidClassDefinition
}

{ #category : #running }
CDMinimalClassDefinitionTest >> classDefinitionString [

	^ 'Object < #Point
			package: #''Kernel-BasicObjects'''
]

{ #category : #running }
CDMinimalClassDefinitionTest >> testClassDefIsInstanceSide [
	self assert: classDefinition isInstanceSideDefinition 
]

{ #category : #running }
CDMinimalClassDefinitionTest >> testClassDefPackageIsCorrect [
	self assert: classDefinition packageName equals: self packageName

]

{ #category : #running }
CDMinimalClassDefinitionTest >> testClassDefSuperclassIsCorrect [
	self assert: classDefinition superclassName equals: self superclassName

]

{ #category : #'standalone tests' }
CDMinimalClassDefinitionTest >> testInstanceClassDefinitionIsInstanceSide [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: #''Kernel-BasicObjects'''.

	self assert: def isInstanceSideDefinition 
]

{ #category : #'standalone tests' }
CDMinimalClassDefinitionTest >> testWrongClassDefShouldNotBeClassSide [

	self should: [ self classDefinitionParserClass parse: 'Object --- #Point
			package: #''Kernel-BasicObjects'''] raise: CDFluidClassParserError.

]

{ #category : #'standalone tests' }
CDMinimalClassDefinitionTest >> testWrongClassDefShouldNotBeClassSide2 [

	self should: [ self classDefinitionParserClass parse: 'Object blbl: #Point
			package: #''Kernel-BasicObjects'''] raise: CDFluidClassParserError 

]
