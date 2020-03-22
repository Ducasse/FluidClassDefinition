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
CDFluidClassValidatorTest >> testGoodNameDoNotReportError [
	| string classDef validator |
	string := 'Object < #Foo2
			package: ''Kernel-BasicObjects'''. 
	classDef := self classDefinitionParserClass parse: string.
	validator := self validator.
	validator validate: classDef.
	self assert: validator errors isEmpty.
	
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testGoodNameDoNotReportError2 [
	| string classDef validator |
	string := 'Object < #Foo2Bar44
			package: ''Kernel-BasicObjects'''. 
	classDef := self classDefinitionParserClass parse: string.
	validator := self validator.
	validator validate: classDef.
	self assert: validator errors isEmpty.
	
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testNotSymbolClassNameShouldRenameError [
	| string classDef validator |
	string := 'Object < Foo2
			package: ''Kernel-BasicObjects'''. 
	classDef := self classDefinitionParserClass parse: string.
	validator := self validator.
	validator validate: classDef.
	self assert: validator errors isNotEmpty.
	self assert: validator errors first actualTokens equals: #('Foo2')
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testNotUppercaseClassNameShouldReportError [
	| string classDef validator |
	string := 'Object < #point
			package: ''Kernel-BasicObjects'''. 
	classDef := self classDefinitionParserClass parse: string.
	validator := self validator.
	validator validate: classDef.
	self assert: validator errors isNotEmpty.
	self assert: validator errors first actualTokens equals: #(#point)
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testNotUppercaseStringClassNameShouldReportError [
	| string classDef validator |
	string := 'Object < point
			package: ''Kernel-BasicObjects'''. 
	classDef := self classDefinitionParserClass parse: string.
	validator := self validator.
	validator validate: classDef.
	self assert: validator errors isNotEmpty.
	self assert: validator errors first actualTokens equals: #(#point)
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testStartingNumberStringClassNameShouldReportError [
	| string classDef validator |
	string := 'Object < 3Foo
			package: ''Kernel-BasicObjects'''. 
	classDef := self classDefinitionParserClass parse: string.
	validator := self validator.
	validator validate: classDef.
	self assert: validator errors isNotEmpty.
	self assert: validator errors first actualTokens equals: #(3)
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testTrueAsClassNameShouldReportError [
	| string classDef validator |
	string := 'Object < true
			package: ''Kernel-BasicObjects'''. 
	classDef := self classDefinitionParserClass parse: string.
	validator := self validator.
	validator validate: classDef.
	self assert: validator errors isNotEmpty.
	self assert: validator errors first actualTokens equals: #(true)
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testWrongClassDefinitionMessage [
	| string classDef validator msgReport |
	string := 'Object --- true
			package: ''Kernel-BasicObjects'''. 
	classDef := self classDefinitionParserClass parse: string.
	validator := self validator.
	validator validate: classDef.
	self assert: validator errors isNotEmpty.
	msgReport := (validator errors detect: [:each | each class = CDMainMessageReport ]).
	self assert: msgReport actualTokens equals: #('---')
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testWrongClassDefinitionMessage2 [
	| string classDef validator msgReport |
	string := 'Object bla: true
			package: ''Kernel-BasicObjects'''. 
	classDef := self classDefinitionParserClass parse: string.
	validator := self validator.
	validator validate: classDef.
	self assert: validator errors isNotEmpty.
	msgReport := (validator errors detect: [:each | each class = CDMainMessageReport ]).
	self assert: msgReport actualTokens equals: #('bla:')
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
CDFluidClassValidatorTest >> testWrongSuperclass [
	| string classDef validator |
	string := '33 < #Point
			package: ''Kernel-BasicObjects'''. 
	classDef := self classDefinitionParserClass parse: string.
	validator := self validator.
	validator validate: classDef.
	self assert: validator errors isNotEmpty.
	self assert: validator errors first actualTokens equals: #(33).
	self assert: classDef tokens equals: #(33 #< #Point #package: 'Kernel-BasicObjects')
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testWrongSuperclass2 [
	| string classDef validator |
	string := 'object < #Point
			package: ''Kernel-BasicObjects'''. 
	classDef := self classDefinitionParserClass parse: string.
	validator := self validator.
	validator validate: classDef.
	self assert: validator errors isNotEmpty.
	self assert: validator errors first actualTokens equals: #(object).
	self assert: classDef tokens equals: #('object' #< #Point #package: 'Kernel-BasicObjects')
]

{ #category : #utils }
CDFluidClassValidatorTest >> validator [ 

	^ self classDefinitionValidatorClass new
]
