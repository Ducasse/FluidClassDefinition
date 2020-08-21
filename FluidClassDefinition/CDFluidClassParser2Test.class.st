Class {
	#name : #CDFluidClassParser2Test,
	#superclass : #TestCase,
	#instVars : [
		'classDefinition'
	],
	#category : #'FluidClassDefinition-Parser'
}

{ #category : #running }
CDFluidClassParser2Test >> classDefinitionParserClass [

	^ CDFluidClassDefinitionParser2
]

{ #category : #'tests - (r) simple class definition' }
CDFluidClassParser2Test >> testClassSideDefinitionIsClassSide [

	| def |
	def := self classDefinitionParserClass parse: 'Object class < #Point
			package: ''Kernel-BasicObjects'''.

	self assert: def isClassSideDefinition 
]

{ #category : #'test class variables' }
CDFluidClassParser2Test >> testClassVariables [

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
CDFluidClassParser2Test >> testComplexSlots [

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
CDFluidClassParser2Test >> testEmptySlots [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		slots: {};
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def slots isEmpty

]

{ #category : #'test kinds' }
CDFluidClassParser2Test >> testEphemeronSubclass [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		ephemeron;
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def classKind equals: #ephemeron
]

{ #category : #'tests - (r) simple class definition' }
CDFluidClassParser2Test >> testInstanceDefinitionIsInstanceSide [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.

	self assert: def isInstanceSideDefinition 
]

{ #category : #'test kinds' }
CDFluidClassParser2Test >> testNormalSubclass [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		normal;
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def classKind equals: #normal
]

{ #category : #'tests - (r) simple class definition' }
CDFluidClassParser2Test >> testSimpleDefinitionClassName [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.
			
	self assert: def className equals: #Point.

]

{ #category : #'tests - (r) simple class definition' }
CDFluidClassParser2Test >> testSimpleDefinitionClassNode [

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

{ #category : #'tests - (r) simple class definition' }
CDFluidClassParser2Test >> testSimpleDefinitionPackageIsCorrect [
	
	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.
	self assert: def packageName equals: 'Kernel-BasicObjects'
]

{ #category : #'tests - (r) simple class definition' }
CDFluidClassParser2Test >> testSimpleDefinitionSuperclassName [

	| def |
	def := self classDefinitionParserClass parse: 'Object < #Point
			package: ''Kernel-BasicObjects'''.
			
	self assert: def superclassName equals: 'Object'
	
]

{ #category : #'test slots' }
CDFluidClassParser2Test >> testSimpleSlots [

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

{ #category : #'test - tags' }
CDFluidClassParser2Test >> testTag [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	defString := 'Object < #MyObject
		tags: { ''tag1'' . ''tag2'' };
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: (def tags statements collect: [:each | each value]) equals: #('tag1' 'tag2') asOrderedCollection
]

{ #category : #'test traits' }
CDFluidClassParser2Test >> testTraitAlias [

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
CDFluidClassParser2Test >> testTraitEmpty [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		uses: {};
		package: #MyPackage'.
		
	def := parser parse: defString.
	self assert: def traitDefinition equals: nil
]

{ #category : #'test traits' }
CDFluidClassParser2Test >> testTraitPlainSimple [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		uses: MyTrait;
		package: #MyPackage'.
		
	def := parser parse: defString.
	self assert: def traitDefinition name equals: #MyTrait.
]

{ #category : #'test traits' }
CDFluidClassParser2Test >> testTraitSequence [

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
CDFluidClassParser2Test >> testTypedSlots [

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
CDFluidClassParser2Test >> testVariableByteSubclass [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		variableByte;
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def classKind equals: #variableByte
]

{ #category : #'test kinds' }
CDFluidClassParser2Test >> testVariableSubclass [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		variable;
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def classKind equals: #variable
]

{ #category : #'test kinds' }
CDFluidClassParser2Test >> testVariableWordSubclass [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		variableWord;
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def classKind equals: #variableWord
]

{ #category : #'test kinds' }
CDFluidClassParser2Test >> testWeakSubclass [

	| parser defString def |
	parser := self classDefinitionParserClass new.
	
	defString := 'Object < #MyObject
		weak;
		package: #MyPackage'.
	def := parser parse: defString.
	self assert: def classKind equals: #weak
]

{ #category : #'just trying an idea' }
CDFluidClassParser2Test >> trying [
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
