Extension { #name : #ClyClassCreationToolMorph }

{ #category : #'*FluidClassDefinition' }
ClyClassCreationToolMorph >> classTemplate [

	| template |
	template := ClassDefinitionPrinter showFluidClassDefinition
		ifTrue: [ 
			^ ClassDefinitionPrinter fluid fullyExpandedClassDefinitionStringInPackage:  self packageName ].
	 
template := 'Object subclass: #NameOfSubclass
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: '''.

	^ template , self packageName , '''' 
]
