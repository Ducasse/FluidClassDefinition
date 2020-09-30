Class {
	#name : #LegacyClassDefinitionPrinter,
	#superclass : #ClassDefinitionPrinter,
	#category : #'FluidClassDefinition-Printer-UnderDev'
}

{ #category : #delegating }
LegacyClassDefinitionPrinter >> definitionString [
	^ forClass oldDefinition
]
