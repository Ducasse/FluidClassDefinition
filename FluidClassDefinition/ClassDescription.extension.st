Extension { #name : #ClassDescription }

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionFullyExpanded [
	"This definition propose all the with an empty arguments so that the user can just type and empty elements will be ignored by the builder and parser. Should check that this is true and write tests."
	
	^ self definitionFullyExpandedButPackage: 'MyPackage'
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionPrinter [
	"Return the printer"
	^ ClassDefinitionPrinter for: self
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionString [
	"Return the string of the class definition, each of my subclass may tell the printer how to printer it. A kind of double dispatch since we have multiple printers and multiple entities to be printed."

	^ self definitionStringFor: self definitionPrinter
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionStringFor: aPrinter [

	^ self subclassResponsibility 
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> expandedDefinitionString [
	"Return the string of the class definition, each of my subclass may tell the printer how to printer it. A kind of double dispatch since we have multiple printers and multiple entities to be printed."

	^ self expandedDefinitionStringFor: self definitionPrinter
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> expandedDefinitionStringFor: aPrinter [

	^ self subclassResponsibility
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> fullyExpandedDefinitionString [
	"This definition propose all the with an empty arguments so that the user can just type and empty elements will be ignored by the builder and parser. Should check that this is true and write tests."
	
	^ self definitionPrinter fullyExpandedDefinitionStringInPackage: 'MyPackage'
]
