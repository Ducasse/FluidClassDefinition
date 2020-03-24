Class {
	#name : #CDFluidClassParserTest,
	#superclass : #TestCase,
	#instVars : [
		'classDefinition'
	],
	#category : #'FluidClassDefinition-Parser'
}

{ #category : #running }
CDFluidClassParserTest >> classDefinitionParserClass [

	^ CDFluidClassDefinitionParser
]

{ #category : #'scanner to text tests' }
CDFluidClassParserTest >> testCharacterScannerToText [

	self assert: ${ scannerToText equals: '{'
]

{ #category : #'test low-level' }
CDFluidClassParserTest >> testChopMiddleLines [

	| parser defString |
	parser := self classDefinitionParserClass new.
	defString := 'Object < #MyObject
		uses: #MyTrait;
		slots: { #a. #b };
		classVariables: { #A . #B };
  		tags: #(Core Others) ;
		package: #MyPackage'.
	
	parser setString: defString.
	parser chopLinesFrom: 3.
	
	self assert: (parser fluidLines first collect: [ :each | each value ]) equals: #(#uses: #MyTrait).
	self assert: (parser fluidLines second collect: [ :each | each value ]) equals: #(#slots: ${ a $. b $}).
	self assert: (parser fluidLines third collect: [ :each | each value ]) equals: #(#classVariables: ${ A $. B $}).
	self assert: (parser fluidLines fourth collect: [ :each | each value ]) equals: #(#tags: '#(' #Core #Others $)).

]

{ #category : #'test  simple definition creation' }
CDFluidClassParserTest >> testClassSideDefinitionIsClassSide [

	| def |
	def := self classDefinitionParserClass parse: 'Object class < #Point
			package: ''Kernel-BasicObjects'''.

	self assert: def isClassSideDefinition 
]

{ #category : #'test class variables' }
CDFluidClassParserTest >> testClassVariables [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		classVariables: { #A. #B };
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def sharedSlots first name equals: #A. 
	self assert: def sharedSlots second name equals: #B. 
]

{ #category : #'test slots' }
CDFluidClassParserTest >> testComplexSlots [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		slots: { #inst => (InstanceVariableSlot default: 5) };
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def slots first name equals: #inst. 
	
]

{ #category : #'test slots' }
CDFluidClassParserTest >> testEmptySlots [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		slots: {};
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def slots isEmpty

]

{ #category : #'test low-level to remove' }
CDFluidClassParserTest >> testExpressionStringFrom [

	self 
		assert: (self classDefinitionParserClass new expressionStringFrom: #('uses:' 'MyTrait'))
		equals: 'self uses: MyTrait'
]

{ #category : #'test low-level to remove' }
CDFluidClassParserTest >> testExpressionStringFromClassVariables [

	self 
		assert: (self classDefinitionParserClass new expressionStringFrom: #('Object' #< #MyObject 'classVariables:' ${ #AnotherTrait $. #ClassVar $} $; 'package:' #MyPackage))
		equals:
 'self Object < #MyObject classVariables: { #AnotherTrait . #ClassVar } ; package: #MyPackage'
]

{ #category : #'test low-level to remove' }
CDFluidClassParserTest >> testExpressionStringFromWithParentheses [

	self 
		assert: (self classDefinitionParserClass new expressionStringFrom: #('Object' #< #MyObject 'uses:' 'MyTrait' #+ $( 'AnotherTrait' #- ${ #selector $} #@ ${ #selector1 #'->' #selector $} $) $; 'package:' #MyPackage))
		equals:
 'self Object < #MyObject uses: MyTrait + ( AnotherTrait - { #selector } @ { #selector1 -> #selector } ) ; package: #MyPackage'
]

{ #category : #'test low-level' }
CDFluidClassParserTest >> testHasFluidPart [

	| parser |
	parser := self classDefinitionParserClass new.
	parser array: (RBParser parseLiterals: 'Object < #CDAbstractClassDefinitionParser
		slots: { #classDefinition. #subclass => BooleanSlot };
		package: ''FluidClassDefinition''').
	self assert: parser hasFluidPart.
]

{ #category : #'test  simple definition creation' }
CDFluidClassParserTest >> testInstanceDefinitionIsInstanceSide [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.

	self assert: def isInstanceSideDefinition 
]

{ #category : #'scanner to text tests' }
CDFluidClassParserTest >> testIntegerScannerToText [

	self assert: 1 scannerToText equals: '1'
]

{ #category : #'test  simple definition creation' }
CDFluidClassParserTest >> testSimpleDefinitionClassName [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.
			
	self assert: def className equals: #Point.

]

{ #category : #'test  simple definition creation' }
CDFluidClassParserTest >> testSimpleDefinitionClassNode [

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
CDFluidClassParserTest >> testSimpleDefinitionPackageIsCorrect [
	
	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.
	self assert: def packageName equals: 'Kernel-BasicObjects'
]

{ #category : #'test  simple definition creation' }
CDFluidClassParserTest >> testSimpleDefinitionSuperclassName [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.
			
	self assert: def superclassName equals: 'Object'
	
]

{ #category : #'test slots' }
CDFluidClassParserTest >> testSimpleSlots [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		slots: { #a. #b };
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def slots first name equals: #a. 
	self assert: def slots second name equals: #b. 
]

{ #category : #'test low-level' }
CDFluidClassParserTest >> testSplittingTokens [

	self 
		assert: (RBParser parseLiterals: 
	'Object < #CDAbstractClassDefinitionParser
		slots: { #classDefinition. #subclass => BooleanSlot };
		classVariables: {  };
		package: ''FluidClassDefinition''') 
		equals: #(#Object #< #CDAbstractClassDefinitionParser #slots: #'{' #classDefinition #'.' #subclass #'=>' #BooleanSlot #'}' #';' #classVariables: #'{' #'}' #';' #package: 'FluidClassDefinition')
]

{ #category : #'scanner to text tests' }
CDFluidClassParserTest >> testStringScannerToText [

	self assert: 'classVariables:' scannerToText equals: 'classVariables:'
]

{ #category : #'scanner to text tests' }
CDFluidClassParserTest >> testSymbolScannerToText [

	self assert: #A scannerToText equals: '#A'
]

{ #category : #'test low-level' }
CDFluidClassParserTest >> testTokensOf [

	self 
		assert: (((self classDefinitionParserClass new tokensOf: 
	'Object < #MyObject
		uses: MyTrait + (AnotherTrait - {#selector} @ {#selector1 -> #selector});
		package: #MyPackage')) collect: [ :each | each value ])
		equals: 
 #('Object' #< #MyObject 'uses:' 'MyTrait' #+ $( 'AnotherTrait' #- ${ #selector $} #@ ${ #selector1 #'->' #selector $} $) $; 'package:' #MyPackage)		
]

{ #category : #'test traits' }
CDFluidClassParserTest >> testTraitAlias [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		uses: MyTrait @ {#foo -> #bar};
		package: #MyPackage'.
	
	def := parser parse: defString.
	self assert: def traitDefinition class equals: CDTraitAliasNode. 
	self assert: (def traitDefinition aliases values) equals: #(bar).
	self assert: (def traitDefinition aliases keys) equals: #(foo).
	self assert: def traitDefinition subject name equals: #MyTrait. 	

]

{ #category : #'test traits' }
CDFluidClassParserTest >> testTraitEmpty [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		uses: {};
		package: #MyPackage'.
		
	def := parser parse: defString.
	self assert: def traitDefinition class equals: CDTraitCompositionSequenceNode
]

{ #category : #'test traits' }
CDFluidClassParserTest >> testTraitPlainSimple [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		uses: MyTrait;
		package: #MyPackage'.
		
	def := parser parse: defString.
	self assert: def traitDefinition name equals: #MyTrait.
]

{ #category : #'test traits' }
CDFluidClassParserTest >> testTraitSequence [

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

{ #category : #'test slots' }
CDFluidClassParserTest >> testTypedSlots [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		slots: { #inst => InstanceVariableSlot };
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def slots first name equals: #inst. 
	
]
