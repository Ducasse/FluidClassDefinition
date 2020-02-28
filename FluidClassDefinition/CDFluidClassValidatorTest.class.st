Class {
	#name : #CDFluidClassValidatorTest,
	#superclass : #TestCase,
	#category : #'FluidClassDefinition-NewApproach'
}

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> classDefinitionParserClass [

	^ CDFluidClassDefinitionParser
]

{ #category : #utils }
CDFluidClassValidatorTest >> classDefinitionValidatorClass [

	^ CDFluidClassDefinitionValidator
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testGoodClassNameShouldNotRaiseError [
	| string tree |
	string := 'Object < #Foo2
			package: ''Kernel-BasicObjects'''. 
	tree := self classDefinitionParserClass parse: string.
	self assert: (self validator treeIsValid: tree)
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testGoodClassNameShouldNotRaiseError2 [
	| string |
	string := 'Object < #Foo2Bar44
			package: ''Kernel-BasicObjects'''. 
			
	self shouldnt: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testNotSymbolClassNameShouldRaiseError [
	| string classDef validator |
	string := 'Object < Foo2
			package: ''Kernel-BasicObjects'''. 
	classDef := self classDefinitionParserClass parse: string.
	validator := self validator.
	validator validate: classDef.
	self assert: validator errors isNotEmpty
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testWrongClassNameShouldRaiseError [
	| string |
	string := 'Object < #point
			package: ''Kernel-BasicObjects'''. 
			
	self should: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	[ self classDefinitionParserClass parse: string ] on: CDFluidClassParserError do: [ :ex | self assert: ex parseContext actualTokens equals: { #point } ]
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testWrongClassNameShouldRaiseError2 [
	| string |
	string := 'Object < point
			package: ''Kernel-BasicObjects'''. 
			
	self should: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	[ self classDefinitionParserClass parse: string ] 
		on: CDFluidClassParserError 
		do: [ :ex | self assert: ex parseContext actualTokens equals: { 'point' } ]
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testWrongClassNameShouldRaiseError3 [
	| string |
	string := 'Object < 3Foo
			package: ''Kernel-BasicObjects'''. 
			
	self should: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	[ self classDefinitionParserClass parse: string ] 
		on: CDFluidClassParserError 
		do: [ :ex | 
		self assert: ex parseContext actualTokens equals: { 3 }.
		self assert: ex parseContext fullTokens equals: #(#Object #< 3 #Foo #package: 'Kernel-BasicObjects')		 ]
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testWrongClassNameShouldRaiseError4 [
	| string |
	string := 'Object < true
			package: ''Kernel-BasicObjects'''. 
			
	self should: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	[ self classDefinitionParserClass parse: string ] 
		on: CDFluidClassParserError 
		do: [ :ex | self assert: ex parseContext actualTokens equals: { true } ]
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testWrongMessageShouldRaiseError [
	
	| defString |
	defString := 'Object --- #Point
			package: ''Kernel-BasicObjects'''.
			
	self should: [ self classDefinitionParserClass parse: defString ] raise: CDFluidClassParserError.
		
	[ self classDefinitionParserClass parse: defString ] 
			on: CDFluidClassParserError 
			do: [ :ex | 
					self assert: ex parseContext actualTokens equals: { '---' }.
					self assert: ex parseContext fullTokens equals: #(#Object #'---' #Point #package: 'Kernel-BasicObjects')	]

]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testWrongMessageShouldRaiseError2 [
	
	| defString |
	defString := 'Object bla: #Point
			package: ''Kernel-BasicObjects'''.
			
	self should: [ self classDefinitionParserClass parse: defString ] raise: CDFluidClassParserError.
		
	[ self classDefinitionParserClass parse: defString ] 
			on: CDFluidClassParserError 
			do: [ :ex | 
					self assert: ex parseContext actualTokens equals: { 'bla:' }.
					self assert: ex parseContext fullTokens equals: #(#Object #'bla:' #Point #package: 'Kernel-BasicObjects')	]

]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testWrongSuperclassShouldRaiseError [

	| defString |
	defString := '33 < #Point
			package: ''Kernel-BasicObjects'''.
			
	self should: [ self classDefinitionParserClass parse: defString ] raise: CDFluidClassParserError.

	[ self classDefinitionParserClass parse: defString ] 
		on: CDFluidClassParserError 
		do: [ :ex | 
				self assert: ex parseContext actualTokens equals: { 33 }.
				self assert: ex parseContext fullTokens equals: #(33 #< #Point #package: 'Kernel-BasicObjects') ]
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testWrongSuperclassShouldRaiseError2 [

	| defString |
	defString := 'point < #Point
			package: ''Kernel-BasicObjects'''.
			
	self should: [ self classDefinitionParserClass parse: defString ] raise: CDFluidClassParserError.

	[ self classDefinitionParserClass parse: defString ] 
		on: CDFluidClassParserError 
		do: [ :ex | 
				self assert: ex parseContext actualTokens equals: { 'point' }.
				self assert: ex parseContext fullTokens equals: #(point #< #Point #package: 'Kernel-BasicObjects') ]
]

{ #category : #utils }
CDFluidClassValidatorTest >> validator [ 

	^ self classDefinitionValidatorClass new
]
