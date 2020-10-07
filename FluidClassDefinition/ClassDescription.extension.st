Extension { #name : #ClassDescription }

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionFullyExpanded [
	"This definition propose all the with an empty arguments so that the user can just type and empty elements will be ignored by the builder and parser. Should check that this is true and write tests."
	
	^ self definitionFullyExpandedButPackage: 'MyPackage'
]

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionFullyExpandedButPackage: aString [
	"This definition propose all the with an empty arguments so that the user can just type and empty elements will be ignored by the builder and parser. Should check that this is true and write tests. 
	"
	"For now I will check here for Slot 
	"
	^ Slot showSlotClassDefinition 
		ifTrue: [
				String streamContents: [ :s |
						s nextPutAll: 'Object < #MyClass'; crtab.
						s nextPutAll: 'layout: FixedLayout;'; crtab.
						s nextPutAll: 'uses: {};'; crtab.
						s nextPutAll: 'slots: {};'; crtab. 
						s nextPutAll: 'sharedVariables: {};'; crtab.
						s nextPutAll: 'sharedPools: {};'; crtab.
						s nextPutAll: 'tag: '''' ;';crtab.
						s nextPutAll: 'package: ''', aString, '''' ] 
					]
		ifFalse: [  
				String streamContents: [ :s |
						s nextPutAll: 'Object subclass: #MyClass' ; crtab.
						s nextPutAll: 'instanceVariableNames: '''' '; crtab. 
						s nextPutAll: 'classVariableNames: '''''; crtab.
						s nextPutAll: 'package: ''', aString, '''' ] 				
				]

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
