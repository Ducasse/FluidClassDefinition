Extension { #name : #ClassDescription }

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionPrinter [
	"Return a configurated printer associated with the current class definition format."

	^ ClassDefinitionPrinter for: self
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionString [
	"Return the string of the class definition, each of my subclass may tell the printer how to printer it. A kind of double dispatch since we have multiple printers and multiple entities to be printed."

	^ self definitionStringFor: self definitionPrinter
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionStringFor: aConfiguredPrinter [

	^ self subclassResponsibility 
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> expandedDefinitionString [
	"Return the string of the class definition, each of my subclass may tell the printer how to printer it. A kind of double dispatch since we have multiple printers and multiple entities to be printed."

	^ self expandedDefinitionStringFor: (self definitionPrinter for: self)
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> expandedDefinitionStringFor: aPrinter [

	^ self subclassResponsibility
]
