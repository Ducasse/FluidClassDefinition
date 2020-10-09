Extension { #name : #ClyClassDefinitionEditorToolMorph }

{ #category : #'*FluidClassDefinition' }
ClyClassDefinitionEditorToolMorph >> createTextContext [
	^self selectedSourceNode
		ifNil: [ ClyClassDefinitionContext for: self ]
		ifNotNil: [ :astNode | ClySourceCodeContext for: self selectedNode: astNode]
]

{ #category : #'*FluidClassDefinition' }
ClyClassDefinitionEditorToolMorph >> editingText [
	
	^ editingClass definitionString
]

{ #category : #'*FluidClassDefinition' }
ClyClassDefinitionEditorToolMorph >> parseClassDefinition [
	^ ClassDefinitionPrinter new classDefinitionParserClass parse: self editingText
]
