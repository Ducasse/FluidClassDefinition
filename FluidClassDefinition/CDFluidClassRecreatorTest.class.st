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
CDFluidClassRecreatorTest >> testArray [

	self assert: Array asFluidDefinitionString equals: 'ArrayedCollection < #Array
	layout: VariableLayout;
	tag: ''Base'';
	package: ''Collections-Sequenceable'''
]

{ #category : #tests }
CDFluidClassRecreatorTest >> testByteString [
	self skip. 
	self assert: ByteString asFluidDefinitionString equals: 'String subclass: #ByteString
	layout: ByteLayout
	slots: {  }
	classVariables: { #NonAsciiMap }
	package: ''Collections-Strings-Base'''
]

{ #category : #tests }
CDFluidClassRecreatorTest >> testPoint [
	
	self assert: Point asFluidDefinitionString equals: 'Object < #Point
	slots: {#x . #y};
	tag: ''BasicObjects'';
	package: ''Kernel'''
	
]
