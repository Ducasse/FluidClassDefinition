Extension { #name : #ClyClassDefinitionEditorToolMorph }

{ #category : #'*FluidClassDefinition' }
ClyClassDefinitionEditorToolMorph >> parseClassDefinition [
	^ ClassDefinitionPrinter new classDefinitionParserClass parse: self editingText
]
