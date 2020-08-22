Class {
	#name : #CDFluidGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'stream'
	],
	#category : #'FluidClassDefinition-Parser'
}

{ #category : #tests }
CDFluidGeneratorTest >> testRecreateSimpleClass [
	self halt.
	CDFluidGenerator new visit: ''
]
