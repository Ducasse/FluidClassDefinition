"
The idea is that we want to have a printer


ClassDefinitionPrinter 
	should be able to return either a specific printer
	or the default one shared globally.
	By default this ithe one we want to use. 

```	
ClassDefinitionPrinter useFluid.

(ClassDefinitionPrinter for: Array) definitionString
```
should return

```
ArrayedCollection < #Array
	layout: VariableLayout;
	tag: ''Base'';
	package: ''Collections-Sequenceable'''
```
	

```
ClassDefinitionPrinter new 
	oldPharo;
	for: Array;
	definitionString
	
ClassDefinitionPrinter new 
	fluid;
	for: Array;
	definitionString
	
ClassDefinitionPrinter new 
	legacy;
	for: Array;
	definitionString
```	

In addition the printer should support 
	- templateDefinitionString
	
	- expandedDefinitionString is the same as definitionString on OldPharo and Legacy.








"
Class {
	#name : #ClassDefinitionPrinter,
	#superclass : #Object,
	#instVars : [
		'printer',
		'forClass'
	],
	#classVars : [
		'Printer'
	],
	#classInstVars : [
		'slotClassDefinition'
	],
	#category : #'FluidClassDefinition-Printer-UnderDev'
}

{ #category : #'instance creation' }
ClassDefinitionPrinter class >> for: aClass [ 
	^ self new for: aClass; yourself
]

{ #category : #configure }
ClassDefinitionPrinter class >> showSlotClassDefinition [
	^slotClassDefinition ifNil: [ slotClassDefinition := false ]
]

{ #category : #configure }
ClassDefinitionPrinter class >> showSlotClassDefinition: aBoolean [ 
	slotClassDefinition := aBoolean
]

{ #category : #delegating }
ClassDefinitionPrinter >> definitionString [

	^ (printer for: forClass) definitionString
]

{ #category : #configuration }
ClassDefinitionPrinter >> fluid [

	printer := FluidClassDefinitionPrinter new
]

{ #category : #accessing }
ClassDefinitionPrinter >> for: aClass [ 
	forClass := aClass
]

{ #category : #configuration }
ClassDefinitionPrinter >> legacy [

	printer := LegacyClassDefinitionPrinter new
]

{ #category : #configuration }
ClassDefinitionPrinter >> oldPharo [

	printer := OldPharoClassDefinitionPrinter new
]
