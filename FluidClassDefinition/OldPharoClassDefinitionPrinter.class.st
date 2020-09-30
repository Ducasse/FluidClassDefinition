Class {
	#name : #OldPharoClassDefinitionPrinter,
	#superclass : #ClassDefinitionPrinter,
	#category : #'FluidClassDefinition-Printer-UnderDev'
}

{ #category : #delegating }
OldPharoClassDefinitionPrinter >> definitionString [

	^ forClass definitionWithoutSlots 
]
