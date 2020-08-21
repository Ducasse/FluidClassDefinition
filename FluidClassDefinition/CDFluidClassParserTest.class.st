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
		sharedVariables: { #A. #B };
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def sharedSlots first name equals: #A. 
	self assert: def sharedSlots second name equals: #B. 
]

{ #category : #'test slots' }
CDFluidClassParserTest >> testComplexSlots [

	| parser defString def slot |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		slots: { #inst => (InstanceVariableSlot default: 5) };
		package: #MyPackage'.
	def := parser parse: defString.
	slot := def slots first.
	self assert: slot name equals: #inst. 
	self assert: slot initializationMessage selectorParts equals: #(#default:).
	self assert: (slot initializationMessage argumentParts collect: [:each | each value]) equals: #(5) asOrderedCollection
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

{ #category : #'test kinds' }
CDFluidClassParserTest >> testEphemeronSubclass [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		ephemeron;
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def classKind equals: #ephemeron
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

{ #category : #'test kinds' }
CDFluidClassParserTest >> testNormalSubclass [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		normal;
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def classKind equals: #normal
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
	self assert: def slots size equals: 2.
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

{ #category : #'test - tags' }
CDFluidClassParserTest >> testTag [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	defString := 'Object < #MyObject
		tags: { ''tag1'' . ''tag2'' };
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: (def tags statements collect: [:each | each value]) equals: #('tag1' 'tag2') asOrderedCollection
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
	self assert: def traitDefinition equals: nil
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
	defString := 'Object < #MyObject
		uses: MyTrait + (AnotherTrait - {#selector} @ {#selector1 -> #selector});
		package: #MyPackage'.

	def := parser parse: defString.
	self assert: def traitDefinition class equals: CDTraitCompositionSequenceNode. 
	self assert: def traitDefinition sequence size equals: 2.
	self assert: (def traitDefinition sequence second aliases values) equals: #(selector).
	self assert: (def traitDefinition sequence second aliases keys) equals: #(selector1).
	self assert: def traitDefinition sequence first name equals: #MyTrait. 	

]

{ #category : #'test slots' }
CDFluidClassParserTest >> testTypedSlots [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		slots: { #inst => InstanceVariableSlot };
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def slots size equals: 1.
	self assert: def slots first name equals: #inst. 
	
]

{ #category : #'test kinds' }
CDFluidClassParserTest >> testVariableByteSubclass [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		variableByte;
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def classKind equals: #variableByte
]

{ #category : #'test kinds' }
CDFluidClassParserTest >> testVariableSubclass [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		variable;
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def classKind equals: #variable
]

{ #category : #'test kinds' }
CDFluidClassParserTest >> testVariableWordSubclass [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		variableWord;
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def classKind equals: #variableWord
]

{ #category : #'test kinds' }
CDFluidClassParserTest >> testWeakSubclass [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		weak;
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def classKind equals: #weak
]

{ #category : #'just trying an idea' }
CDFluidClassParserTest >> trying [
	"self new trying"
	
	| cascadedNode messageNode |
	cascadedNode := RBParser parseExpression: 'RubTextEditor < #RubSmalltalkEditor
	slots: {#notificationStrategy . #completionEngine};
	sharedVariables: { #CompletionEngineClass };
	tag: ''Editing-Code'';
	package: ''Rubric'''.
	
	self halt.
	messageNode := RBParser parseExpression: 'RubTextEditor < #RubSmalltalkEditor
	package: ''Rubric'''.
]
