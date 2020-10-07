Extension { #name : #Trait }

{ #category : #'*FluidClassDefinition' }
Trait class >> << aSymbol [
	^ FluidTraitBuilder new 
		name: aSymbol;
		yourself
]

{ #category : #'*FluidClassDefinition' }
Trait class >> definitionFullyExpandedButPackage: aString [
	"This definition propose all the with an empty arguments so that the user can just type and empty elements will be ignored by the builder and parser. Should check that this is true and write tests. 
	"
	"For now I will check here for Slot 
	"
	^ Slot showSlotClassDefinition 
		ifTrue: [
				String streamContents: [ :s |
						s nextPutAll: 'Trait << #TMyTrait'; crtab.
						s nextPutAll: 'uses: {};'; crtab.
						s nextPutAll: 'slots: {};'; crtab. 
						s nextPutAll: 'tag: '''' ;';crtab.
						s nextPutAll: 'package: ''', aString, '''' ] 
					]
		ifFalse: [  
				self definitionWithoutSlots		
				]

]

{ #category : #'*FluidClassDefinition' }
Trait >> definitionStringFor: aPrinter [

	^ aPrinter for: self; traitDefinitionString
]

{ #category : #'*FluidClassDefinition' }
Trait >> expandedDefinitionStringFor: aPrinter [

	^ aPrinter for: self ; expandedTraitDefinitionString 
]
