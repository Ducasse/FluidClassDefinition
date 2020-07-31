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

	self assert: ByteString asFluidDefinitionString equals: 'String < #ByteString
	layout: ByteLayout;
	sharedVariables: { #NonAsciiMap };
	tag: ''Base'';
	package: ''Collections-Strings'''  
]

{ #category : #tests }
CDFluidClassRecreatorTest >> testMetaclass [
	
	self assert: Metaclass asFluidDefinitionString equals: 'ClassDescription < #Metaclass
	slots: {#thisClass};
	tag: ''Classes'';
	package: ''Kernel''' 
]

{ #category : #tests }
CDFluidClassRecreatorTest >> testMetaclassClass [
	
	self assert: RubScrolledTextModel class asFluidDefinitionString equals:  'Object class < #RubScrolledTextModel
	uses: TViewModel classTrait;
	package: ''Rubric'''
]

{ #category : #tests }
CDFluidClassRecreatorTest >> testPoint [
	
	self assert: Point asFluidDefinitionString equals: 'Object < #Point
	slots: {#x . #y};
	tag: ''BasicObjects'';
	package: ''Kernel'''
	
]

{ #category : #tests }
CDFluidClassRecreatorTest >> testText [

	self assert: Text asFluidDefinitionString equals: 
 'ArrayedCollection < #Text
	slots: {#string . #runs};
	tag: ''Base'';
	poolDictionaries: ''TextConstants'';
	package: ''Text-Core''' 
]
