Extension { #name : #Class }

{ #category : #'*FluidClassDefinition' }
Class >> classVariableDefinitionString [
	"Answer a string that evaluates to the definition of the class Variables"
	
	^String streamContents: [ :str | | fullDef |
		self classVariables 
			ifEmpty: [ str nextPutAll: '{}' ]
			ifNotEmpty:[  :clsVars|
		str nextPutAll: '{ '.
		clsVars do: [:global |
				str nextPutAll: global definitionString.
				fullDef := global needsFullDefinition]				
			separatedBy: [ 
				str nextPutAll: ' . '.  
				fullDef ifTrue: [ str cr;tab;tab;tab;tab ]].
		str nextPutAll: ' }'. ]]
]

{ #category : #'*FluidClassDefinition' }
Class >> definitionStringFor: aPrinter [

	^ aPrinter classDefinitionString 
]

{ #category : #'*FluidClassDefinition' }
Class >> expandedDefinitionStringFor: aPrinter [

	^ aPrinter expandedClassDefinitionString 
]

{ #category : #'*FluidClassDefinition' }
Class >> tagOn: str [
	| tag |
	(self package classTagForClass: self) 
			ifNotNil: [:t | 	
					tag := t name.
					tag = self package name
						ifFalse:  [
					str 	tab;  
					 	nextPutAll: 'tag: '; 
						nextPut: $'; 
						nextPutAll: tag asString ; 
						nextPutAll: ''';'.
					str cr
				]].
]
