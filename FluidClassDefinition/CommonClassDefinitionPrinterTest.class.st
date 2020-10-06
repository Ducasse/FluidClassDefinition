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
	#category : #'FluidClassDefinition-Printer'
}

{ #category : #'tests - classes' }
CommonClassDefinitionPrinterTest >> setUp [ 
	super setUp.
	slotuse := ClassDefinitionPrinter showFluidClassDefinition.
	
]

{ #category : #'tests - classes' }
CommonClassDefinitionPrinterTest >> tearDown [ 
	
	Slot showSlotClassDefinition: slotuse.
	super tearDown.
	
]
