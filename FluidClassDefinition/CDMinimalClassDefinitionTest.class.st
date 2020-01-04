Class {
	#name : #CDMinimalClassDefinitionTest,
	#superclass : #CDFluidClassParserTest,
	#category : #'FluidClassDefinition-MessageBasedVersion'
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
