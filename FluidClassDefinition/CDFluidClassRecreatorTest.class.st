"
This test suite is about recreating a class textual representation from the class.
"
Class {
	#name : #CDFluidClassRecreatorTest,
	#superclass : #TestCase,
	#instVars : [
		'classDefinition'
	],
	#category : #'FluidClassDefinition-Parser'
}

{ #category : #tests }
CDFluidClassRecreatorTest >> testPoint [
	self skip.
	self assert: Point asFluidDefinitionString equals: 'Object < #Point
	slots: {#x . #y};
	package: ''Kernel'''
	
]

{ #category : #tests }
CDFluidClassRecreatorTest >> testPointMissingTag [
	self skip.
	self assert: Point asFluidDefinitionString equals: 'Object < #Point
	slots: { #x . #y};
	tag: ''BasicObjects'';
	package: ''Kernel'''
	
]
