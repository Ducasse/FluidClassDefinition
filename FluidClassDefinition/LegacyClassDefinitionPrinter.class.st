Class {
	#name : #LegacyClassDefinitionPrinter,
	#superclass : #ClassDefinitionPrinter,
	#category : #'FluidClassDefinition-Printer'
}

{ #category : #delegating }
LegacyClassDefinitionPrinter >> definitionString [
	^ forClass oldDefinition
]
