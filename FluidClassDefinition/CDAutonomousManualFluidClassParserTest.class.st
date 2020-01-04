"
This class contains tests but it is not linked to the other test superclass as it was done in CD (class Definition package).
"
Class {
	#name : #CDAutonomousManualFluidClassParserTest,
	#superclass : #TestCase,
	#instVars : [
		'classDefinition'
	],
	#category : #'FluidClassDefinition-NewApproach'
}

{ #category : #running }
CDAutonomousManualFluidClassParserTest >> classDefinitionParserClass [

	^ CDManualFluidClassDefinitionParser
]

{ #category : #'test  <' }
CDAutonomousManualFluidClassParserTest >> testClassSideDefinitionIsClassSide [

	| def |
	def := self classDefinitionParserClass parse: 'Object class < #Point
			package: ''Kernel-BasicObjects'''.

	self assert: def isClassSideDefinition 
]

{ #category : #'test - < validation' }
CDAutonomousManualFluidClassParserTest >> testGoodClassNameShouldNotRaiseError [
	| string |
	string := 'Object < Foo2
			package: ''Kernel-BasicObjects'''. 
			
	self shouldnt: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	
]

{ #category : #'test - < validation' }
CDAutonomousManualFluidClassParserTest >> testGoodClassNameShouldNotRaiseError2 [
	| string |
	string := 'Object < Foo2Bar44
			package: ''Kernel-BasicObjects'''. 
			
	self shouldnt: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	
]

{ #category : #'test  <' }
CDAutonomousManualFluidClassParserTest >> testInstanceDefinitionIsInstanceSide [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.

	self assert: def isInstanceSideDefinition 
]

{ #category : #'test  <' }
CDAutonomousManualFluidClassParserTest >> testSimpleDefinitionClassName [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.
			
	self assert: def className equals: #Point.

]

{ #category : #'test package' }
CDAutonomousManualFluidClassParserTest >> testSimpleDefinitionPackageIsCorrect [
	
	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.
	self assert: def packageName equals: 'Kernel-BasicObjects'
]

{ #category : #'test  <' }
CDAutonomousManualFluidClassParserTest >> testSimpleDefinitionSuperclassName [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.
			
	self assert: def superclassName equals: 'Object'
	
]

{ #category : #'test low-level' }
CDAutonomousManualFluidClassParserTest >> testSplittingTokens [

	self 
		assert: (RBParser parseLiterals: 
	'Object < #CDAbstractClassDefinitionParser
		slots: { #classDefinition. #subclass => BooleanSlot };
		classVariables: {  };
		package: ''FluidClassDefinition''') 
		equals: #(#Object #< #CDAbstractClassDefinitionParser #slots: #'{' #classDefinition #'.' #subclass #'=>' #BooleanSlot #'}' #';' #classVariables: #'{' #'}' #';' #package: 'FluidClassDefinition')
]

{ #category : #'test low-level' }
CDAutonomousManualFluidClassParserTest >> testValidClassName [

	| parser |
	parser := self classDefinitionParserClass new.
	
	#( Foo Foo2 Foo3 FooBar2 Foo2Bar)
		do: [ :each | self assert: (parser validClassName: each) ].
		
	#( '2Foo' 'foo' )
		do: [ :each | self deny: (parser validClassName: each) ].
]

{ #category : #'test - < validation' }
CDAutonomousManualFluidClassParserTest >> testWrongClassNameShouldRaiseError [
	| string |
	string := 'Object < #point
			package: ''Kernel-BasicObjects'''. 
			
	self should: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	[ self classDefinitionParserClass parse: string ] on: CDFluidClassParserError do: [ :ex | self assert: ex parseContext actualTokens equals: { #point } ]
]

{ #category : #'test - < validation' }
CDAutonomousManualFluidClassParserTest >> testWrongClassNameShouldRaiseError2 [
	| string |
	string := 'Object < point
			package: ''Kernel-BasicObjects'''. 
			
	self should: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	[ self classDefinitionParserClass parse: string ] 
		on: CDFluidClassParserError 
		do: [ :ex | self assert: ex parseContext actualTokens equals: { 'point' } ]
]

{ #category : #'test - < validation' }
CDAutonomousManualFluidClassParserTest >> testWrongClassNameShouldRaiseError3 [
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

{ #category : #'test - < validation' }
CDAutonomousManualFluidClassParserTest >> testWrongClassNameShouldRaiseError4 [
	| string |
	string := 'Object < true
			package: ''Kernel-BasicObjects'''. 
			
	self should: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	[ self classDefinitionParserClass parse: string ] 
		on: CDFluidClassParserError 
		do: [ :ex | self assert: ex parseContext actualTokens equals: { true } ]
]

{ #category : #'test - < validation' }
CDAutonomousManualFluidClassParserTest >> testWrongMessageShouldRaiseError [
	
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

{ #category : #'test - < validation' }
CDAutonomousManualFluidClassParserTest >> testWrongMessageShouldRaiseError2 [
	
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

{ #category : #'test - < validation' }
CDAutonomousManualFluidClassParserTest >> testWrongSuperclassShouldRaiseError [

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

{ #category : #'test - < validation' }
CDAutonomousManualFluidClassParserTest >> testWrongSuperclassShouldRaiseError2 [

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
