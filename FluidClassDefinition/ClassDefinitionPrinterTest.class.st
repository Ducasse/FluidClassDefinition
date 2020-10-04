Class {
	#name : #ClassDefinitionPrinterTest,
	#superclass : #TestCase,
	#category : #'FluidClassDefinition-Printer-UnderDev'
}

{ #category : #tests }
ClassDefinitionPrinterTest >> testFluidConfiguration [

	self 
		assert: (ClassDefinitionPrinter fluid
 						for: Array;
						definitionString)
		equals: 'ArrayedCollection < #Array
	layout: VariableLayout;
	tag: ''Base'';
	package: ''Collections-Sequenceable'''
]

{ #category : #tests }
ClassDefinitionPrinterTest >> testLegacyPharoConfiguration [

	self 
		assert: (ClassDefinitionPrinter legacy
 						for: Array;
						definitionString)
		equals: 'ArrayedCollection variableSubclass: #Array
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''''
	category: ''Collections-Sequenceable-Base'''
]

{ #category : #tests }
ClassDefinitionPrinterTest >> testOldPharoConfiguration [

	self 
		assert: (ClassDefinitionPrinter oldPharo
 						for: Array;
						definitionString)
		equals: 'ArrayedCollection variableSubclass: #Array
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''Collections-Sequenceable-Base'''
]
