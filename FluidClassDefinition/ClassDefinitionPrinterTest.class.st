Class {
	#name : #ClassDefinitionPrinterTest,
	#superclass : #TestCase,
	#category : #'FluidClassDefinition-Printer-UnderDev'
}

{ #category : #tests }
ClassDefinitionPrinterTest >> testFluidConfiguration [

	self 
		assert: (ClassDefinitionPrinter new 
 						fluid;
 						for: Array;
						definitionString)
		equals: 'ArrayedCollection < #Array
	layout: VariableLayout;
	tag: ''Base'';
	package: ''Collections-Sequenceable'''
]

{ #category : #tests }
ClassDefinitionPrinterTest >> testOldPharoConfiguration [

	self 
		assert: (ClassDefinitionPrinter new 
 						oldPharo;
 						for: Array;
						definitionString)
		equals: 'ArrayedCollection variableSubclass: #Array
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''Collections-Sequenceable-Base'''
]
