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

{ #category : #'test low-level' }
CDAutonomousManualFluidClassParserTest >> testChopMiddleLines [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		uses: #MyTrait;
		slots: { #a. #b };
		classVariables: { #A . #B };
  		tags: #(Core Others) ;
		package: #MyPackage'.
		
	def := parser parse: defString.
	self assert: parser fluidLines first equals: #(#uses: #MyTrait).
	self assert: parser fluidLines second equals: #(#slots: ${ #a $. #b $}).
	self assert: parser fluidLines third equals: #(#classVariables: ${ #A $. #B $}).
	
]

{ #category : #'test  simple definition creation' }
CDAutonomousManualFluidClassParserTest >> testClassSideDefinitionIsClassSide [

	| def |
	def := self classDefinitionParserClass parse: 'Object class < #Point
			package: ''Kernel-BasicObjects'''.

	self assert: def isClassSideDefinition 
]

{ #category : #'test low-level' }
CDAutonomousManualFluidClassParserTest >> testExpressionStringFrom [

	self 
		assert: (self classDefinitionParserClass new expressionStringFrom: #(#uses: #MyTrait))
		equals: 'self uses: MyTrait'
]

{ #category : #'test low-level' }
CDAutonomousManualFluidClassParserTest >> testExpressionStringFromWithParentheses [

	self 
		assert: (self classDefinitionParserClass new expressionStringFrom: #('Object' #< #MyObject 'uses:' 'MyTrait' #+ $( 'AnotherTrait' #- ${ #selector $} #@ ${ #selector1 #'->' #selector $} $) $; 'package:' #MyPackage))
		equals:
 'self Object < MyObject uses: MyTrait + ( AnotherTrait - { selector } @ { selector1 -> selector } ) ; package: MyPackage'
]

{ #category : #'test simple definition validation' }
CDAutonomousManualFluidClassParserTest >> testGoodClassNameShouldNotRaiseError [
	| string |
	string := 'Object < #Foo2
			package: ''Kernel-BasicObjects'''. 
			
	self shouldnt: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	
]

{ #category : #'test simple definition validation' }
CDAutonomousManualFluidClassParserTest >> testGoodClassNameShouldNotRaiseError2 [
	| string |
	string := 'Object < #Foo2Bar44
			package: ''Kernel-BasicObjects'''. 
			
	self shouldnt: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	
]

{ #category : #'test low-level' }
CDAutonomousManualFluidClassParserTest >> testHasFluidPart [

	| parser |
	parser := self classDefinitionParserClass new.
	parser array: (RBParser parseLiterals: 'Object < #CDAbstractClassDefinitionParser
		slots: { #classDefinition. #subclass => BooleanSlot };
		package: ''FluidClassDefinition''').
	self assert: parser hasFluidPart.
]

{ #category : #'test  simple definition creation' }
CDAutonomousManualFluidClassParserTest >> testInstanceDefinitionIsInstanceSide [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.

	self assert: def isInstanceSideDefinition 
]

{ #category : #'test simple definition validation' }
CDAutonomousManualFluidClassParserTest >> testNotSymbolClassNameShouldRaiseError [
	| string |
	string := 'Object < Foo2
			package: ''Kernel-BasicObjects'''. 
			
	self should: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	
]

{ #category : #'test  simple definition creation' }
CDAutonomousManualFluidClassParserTest >> testSimpleDefinitionClassName [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.
			
	self assert: def className equals: #Point.

]

{ #category : #'test  simple definition creation' }
CDAutonomousManualFluidClassParserTest >> testSimpleDefinitionClassNode [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.

	self assert: def classNameNode className equals: #Point.
	
	"The following cannot work 
	
	self assert: def classNameNode binding value equals: Point. 
	
	because binding is defined as 
	
	existingBindingIfAbsent: aBlock

		| binding |
		binding := originalNode methodNode compilationContext environment bindingOf: className.
		^ binding ifNil: aBlock
	
	"

]

{ #category : #'test package' }
CDAutonomousManualFluidClassParserTest >> testSimpleDefinitionPackageIsCorrect [
	
	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.
	self assert: def packageName equals: 'Kernel-BasicObjects'
]

{ #category : #'test  simple definition creation' }
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
CDAutonomousManualFluidClassParserTest >> testTokensOf [

	self 
		assert: (self classDefinitionParserClass new tokensOf: 
	'Object < #MyObject
		uses: MyTrait + (AnotherTrait - {#selector} @ {#selector1 -> #selector});
		package: #MyPackage')
		equals: 
 #('Object' #< #MyObject 'uses:' 'MyTrait' #+ $( 'AnotherTrait' #- ${ #selector $} #@ ${ #selector1 #'->' #selector $} $) $; 'package:' #MyPackage)		
]

{ #category : #'test traits' }
CDAutonomousManualFluidClassParserTest >> testTraitAlias [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		uses: MyTrait @ {#foo -> #bar};
		package: #MyPackage'.
	
	def := parser parse: defString.
	self assert: def traitDefinition class equals: CDTraitAliasNode. 
	self assert: (def traitDefinition aliases values collect: #name) equals: #(bar).
	self assert: (def traitDefinition aliases keys collect: #name) equals: #(foo).
	self assert: def traitDefinition subject name equals: #MyTrait. 	

]

{ #category : #'test traits' }
CDAutonomousManualFluidClassParserTest >> testTraitEmpty [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		uses: {};
		package: #MyPackage'.
		
	def := parser parse: defString.
	self assert: def traitDefinition class equals: CDTraitCompositionSequenceNode
]

{ #category : #'test traits' }
CDAutonomousManualFluidClassParserTest >> testTraitPlainSimple [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		uses: MyTrait;
		package: #MyPackage'.
		
	def := parser parse: defString.
	self assert: def traitDefinition name equals: #MyTrait.
]

{ #category : #'test traits' }
CDAutonomousManualFluidClassParserTest >> testTraitSequence [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	self skip.
	self flag: #here. 
	"do not get why not working while invoking the same and in the ClassDefinitionParser"
	defString := 'Object < #MyObject
		uses: MyTrait + (AnotherTrait - {#selector} @ {#selector1 -> #selector});
		package: #MyPackage'.

	self halt.
	def := parser parse: defString.
	self assert: def traitDefinition class equals: CDTraitAliasNode. 
	self assert: (def traitDefinition aliases values collect: #name) equals: #(bar).
	self assert: (def traitDefinition aliases keys collect: #name) equals: #(foo).
	self assert: def traitDefinition subject name equals: #MyTrait. 	

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

{ #category : #'test simple definition validation' }
CDAutonomousManualFluidClassParserTest >> testWrongClassNameShouldRaiseError [
	| string |
	string := 'Object < #point
			package: ''Kernel-BasicObjects'''. 
			
	self should: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	[ self classDefinitionParserClass parse: string ] on: CDFluidClassParserError do: [ :ex | self assert: ex parseContext actualTokens equals: { #point } ]
]

{ #category : #'test simple definition validation' }
CDAutonomousManualFluidClassParserTest >> testWrongClassNameShouldRaiseError2 [
	| string |
	string := 'Object < point
			package: ''Kernel-BasicObjects'''. 
			
	self should: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	[ self classDefinitionParserClass parse: string ] 
		on: CDFluidClassParserError 
		do: [ :ex | self assert: ex parseContext actualTokens equals: { 'point' } ]
]

{ #category : #'test simple definition validation' }
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

{ #category : #'test simple definition validation' }
CDAutonomousManualFluidClassParserTest >> testWrongClassNameShouldRaiseError4 [
	| string |
	string := 'Object < true
			package: ''Kernel-BasicObjects'''. 
			
	self should: [ self classDefinitionParserClass parse: string ] raise: CDFluidClassParserError.

	[ self classDefinitionParserClass parse: string ] 
		on: CDFluidClassParserError 
		do: [ :ex | self assert: ex parseContext actualTokens equals: { true } ]
]

{ #category : #'test simple definition validation' }
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

{ #category : #'test simple definition validation' }
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

{ #category : #'test simple definition validation' }
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

{ #category : #'test simple definition validation' }
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
