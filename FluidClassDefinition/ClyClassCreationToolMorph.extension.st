Extension { #name : #ClyClassCreationToolMorph }

{ #category : #'*FluidClassDefinition' }
ClyClassCreationToolMorph >> classTemplate [

	| template |
	template := ClassDefinitionPrinter showFluidClassDefinition
		ifTrue: [ 
			^ ClassDescription definitionFullyExpandedButPackage: self packageName ].
	 
template := 'Object subclass: #NameOfSubclass
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: '''.

	^ template , self packageName , '''' 
]
