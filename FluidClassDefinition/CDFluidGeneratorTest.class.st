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
	self skip.
	CDFluidGenerator new visit: ''
]
