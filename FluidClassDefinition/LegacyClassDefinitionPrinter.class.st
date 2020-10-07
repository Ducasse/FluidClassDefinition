Class {
	#name : #LegacyClassDefinitionPrinter,
	#superclass : #ClassDefinitionPrinter,
	#category : #'FluidClassDefinition-Printer'
}

{ #category : #delegating }
LegacyClassDefinitionPrinter >> definitionString [
	^ forClass oldDefinition
]

{ #category : #delegating }
LegacyClassDefinitionPrinter >> expandedDefinitionString [
	"We do not support expansion on legacy syntax"
	^ self definitionString
]
