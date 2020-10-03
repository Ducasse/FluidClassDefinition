"
I do not test the factory logic of ClassDefinitionPrinter because it is done in a companion test class.
Here I'm just a way to share code between all the tests.
"
Class {
	#name : #CommonClassDefinitionPrinterTest,
	#superclass : #TestCase,
	#instVars : [
		'slotuse'
	],
	#category : #'FluidClassDefinition-Printer-UnderDev'
}

{ #category : #'tests - classes' }
CommonClassDefinitionPrinterTest >> setUp [ 
	
	slotuse := ClassDefinitionPrinter showSlotClassDefinition.
	ClassDefinitionPrinter showSlotClassDefinition: true.
	super setUp.
	
]

{ #category : #'tests - classes' }
CommonClassDefinitionPrinterTest >> tearDown [ 
	
	Slot showSlotClassDefinition: slotuse.
	super tearDown.
	
]
