"
```
Object < #MyClass
	layout: FixedLayout;
	uses: {};
	slots: {};
	sharedVariables: {};
	sharedPools: {};
	tag: '' ;
	package: 'FluidClassDefinition-Printer-UnderDev'
```

is the template definition for the fluid syntax


This is the fluid definition of the current class :).

```
ClassDefinitionPrinter < #FluidClassDefinitionPrinter
	tag: 'Printer-UnderDev';
	package: 'FluidClassDefinition'
```


"
Class {
	#name : #FluidClassDefinitionPrinter,
	#superclass : #ClassDefinitionPrinter,
	#category : #'FluidClassDefinition-Printer-UnderDev'
}

{ #category : #printing }
FluidClassDefinitionPrinter >> definitionString [
	^ forClass asFluidDefinitionString 
]

{ #category : #printing }
FluidClassDefinitionPrinter >> expandedDefinitionString [
	^ forClass definitionExpanded 
]

{ #category : #printing }
FluidClassDefinitionPrinter >> fullyExpandedDefinitionString [
	^ forClass definitionFullyExpandedButPackage: forClass package packageName
]
