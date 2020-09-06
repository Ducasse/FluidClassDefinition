Extension { #name : #ClyClassCreationToolMorph }

{ #category : #'*FluidClassDefinition' }
ClyClassCreationToolMorph >> classTemplate [

	| template |
	
	template := Slot showSlotClassDefinition
		ifTrue: [ 
			^ ClassDescription definitionFullyExpandedButPackage: self packageName ].
	 
'Object subclass: #NameOfSubclass
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: '''.

	^ template , self packageName , '''' 
]
