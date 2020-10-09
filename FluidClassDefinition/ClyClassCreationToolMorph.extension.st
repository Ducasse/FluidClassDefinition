Extension { #name : #ClyClassCreationToolMorph }

{ #category : #'*FluidClassDefinition' }
ClyClassCreationToolMorph >> classTemplate [

	| template |
	template := ClassDefinitionPrinter showFluidClassDefinition
		ifTrue: [ 
			^ ClassDefinitionPrinter fluid classDefinitionTemplateInPackage:  self packageName ].
	 
template := 'Object subclass: #NameOfSubclass
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: '''.

	^ template , self packageName , '''' 
]
