Class {
	#name : #CDFluidClassValidatorTest,
	#superclass : #TestCase,
	#category : #'FluidClassDefinition-Validator'
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
CDFluidClassValidatorTest >> testValidClassName [

	| validator |
	validator := self classDefinitionValidatorClass new.
	
	#( Foo Foo2 Foo3 FooBar2 Foo2Bar)
		do: [ :each | self assert: (validator validClassName: each) ].
		
	#( '2Foo' 'foo' )
		do: [ :each |  self deny: (validator validClassName: each) ].
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
	self assert: (msgReport actualTokens collect: [ :each | each value ]) equals: #('---')
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
	self assert: (msgReport actualTokens collect: [ :each | each value ]) equals: #('bla:')
]

{ #category : #'test simple definition validation' }
CDFluidClassValidatorTest >> testWrongClassDefinitionMessage3 [
	| string classDef validator msgReport |
	string := 'Object bla: #Point
			package: ''Kernel-BasicObjects'''. 
	classDef := self classDefinitionParserClass parse: string.
	validator := self validator.
	validator validate: classDef.
	self assert: validator errors isNotEmpty.
	msgReport := (validator errors detect: [:each | each class = CDMainMessageReport ]).
	self assert: (msgReport actualTokens collect: [ :each | each value ]) equals: #('bla:')
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
	self assert: (classDef tokens collect: [:each | each value]) equals: #(33 #< #Point #package: 'Kernel-BasicObjects')
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
	self assert: (classDef tokens collect: #value) equals: #('object' #< #Point #package: 'Kernel-BasicObjects')
]

{ #category : #utils }
CDFluidClassValidatorTest >> validator [ 

	^ self classDefinitionValidatorClass new
]
