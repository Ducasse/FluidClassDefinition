"
The new syntax for class definition (just for the class and not for the methods) is

Superclass < #MyObject
		uses: #MyTrait;
		slots: { #a. #b };
		classVariables: { #A. #B };
  		tags: #(Core) ;
		package: #MyPackage

The minimal class definition is the following one: 

Superclass < #MyObject
		package: #MyPackage


Note that sending a message to the superclass is close to subclass: and it lets the class selects 
a class definition parser if the syntax should be extended. 
In addition having a binary message makes () unneccessary.

Open Questions: what should be a class definition 

Object class < #Point
	package: ''Kernel-BasicObjects''

?

What is the advantage over 

CDManualFluidClassDefinitionParser class
	instanceVariableNames: ''

"
Class {
	#name : #CDManualFluidClassDefinitionParser,
	#superclass : #CDAbstractClassDefinitionParser,
	#instVars : [
		'array',
		'lines'
	],
	#category : #'FluidClassDefinition-NewApproach'
}

{ #category : #private }
CDManualFluidClassDefinitionParser >> array: aCollection [ 
	array := aCollection
]

{ #category : #error }
CDManualFluidClassDefinitionParser >> basicError [

	CDFluidClassParserError new 
			messageText: 'Wrong class definition it should be either Object < #Point or Object class < #Point ';	
			signal

]

{ #category : #private }
CDManualFluidClassDefinitionParser >> chopLinesFrom: start [ 
	
	lines := OrderedCollection new. 
	lines := array allButFirst: start.
	lines := lines splitOn: #(#';').
	lines := lines allButLast.
	

]

{ #category : #public }
CDManualFluidClassDefinitionParser >> expressionStringFrom: aLine [
	"this is a bit silly to recreate source to parse it for real this time,
	but I do not want to build the build by hand. And I want to reuse most of the logic of the CDCLassDefinitionParser. So first make work and we will see."
	
	^ String streamContents: [ :s |
		s << 'self '.   
		aLine 
			do: [ :each | s << each  ]
			separatedBy: [ s space ]]
]

{ #category : #accessing }
CDManualFluidClassDefinitionParser >> fluidLines [
	^ lines
]

{ #category : #private }
CDManualFluidClassDefinitionParser >> hasFluidPart [
	
	^ array size > 5
]

{ #category : #testing }
CDManualFluidClassDefinitionParser >> isClassDefinition [
	"Returns whether the identified class definition is a class side one.
	i.e., something like 
		
		Object class < #Point
			package: ''Kernel-BasicObjects''
	"
	
	^ classDefinition isClassSideDefinition
]

{ #category : #query }
CDManualFluidClassDefinitionParser >> isInstanceDefinition [
	"Returns whether the identified class definition is an instance side one."
	
	^ classDefinition isInstanceSideDefinition
]

{ #category : #testing }
CDManualFluidClassDefinitionParser >> isInstanceSideDefinition: aRBMessageNode [
	"Based on the Point or Point class structure, returns whether the definition is a class or instance side definition."
	^ self halt.
]

{ #category : #public }
CDManualFluidClassDefinitionParser >> parse: aString [
	array := self tokensOf: aString.
	self validateMinimalDefinition.
	self validateInstanceOrClassSide.
	
	self isInstanceDefinition
		ifTrue: [ self validateSuperclass.
				self validateClassName: array third.
				self validatePackage: array last.
				self hasFluidPart 
					ifTrue: 
						[ self chopLinesFrom: 3.
						self treatLines ].
				].
	^ classDefinition
]

{ #category : #'from ClassDefinitionParser' }
CDManualFluidClassDefinitionParser >> parseTraitDefinitionFromNode: aNode [
	
	| traitComposition |
	traitComposition := CDTraitCompositionBuilder new buildFrom: aNode.	
	classDefinition traitDefinition: traitComposition.
]

{ #category : #'private properties' }
CDManualFluidClassDefinitionParser >> setClassName: aString [
	"no validation made, use validateClassName: to get one."

	classDefinition className: aString astNode: (self classNameNodeClass new className: aString)
		
]

{ #category : #'private properties' }
CDManualFluidClassDefinitionParser >> setSuperclassName: aString [
	"No validation" 
	
	| superclassNode |
	superclassNode := self classNameNodeClass new className: aString.
	classDefinition
		superclassName: aString
		astNode: superclassNode
]

{ #category : #parsing }
CDManualFluidClassDefinitionParser >> tokensOf: aString [

	^ RBParser parseLiterals: aString
]

{ #category : #public }
CDManualFluidClassDefinitionParser >> treatLines [

	| expressionTree |
	expressionTree := RBParser parseExpression: (self expressionStringFrom: lines first).
	expressionTree doSemanticAnalysis.
	
	self parseTraitDefinitionFromNode: expressionTree arguments first 
]

{ #category : #testing }
CDManualFluidClassDefinitionParser >> validClassName: aString [ 

	^ aString first isLetter and: [ aString first isUppercase and: [ aString isAllAlphaNumerics ]]
]

{ #category : #validating }
CDManualFluidClassDefinitionParser >> validateClassName: aString [ 
	
	(aString isSymbol and: [ self validClassName: aString ])
		ifFalse: [  CDFluidClassParserError new 
							messageText: 'A class name should start with an uppercase, followed by letter or digits';
							parseContext: (CDParseErrorContext new actualTokens: {aString}; fullTokens: array);
							signal ].
	self setClassName: aString
	
]

{ #category : #validating }
CDManualFluidClassDefinitionParser >> validateInstanceOrClassSide [
	array second = '<'
		ifTrue: [ self beClassDefinition ]
		ifFalse: [ array second = 'class'
				ifTrue: [ array third = '<'
						ifTrue: [ self beMetaclassDefinition ]
						ifFalse: [ self wrongClassMessageError ] ]
				ifFalse: [ self wrongInstanceMessageError ] ]
]

{ #category : #error }
CDManualFluidClassDefinitionParser >> validateMinimalDefinition [

	array size < 3
		ifTrue: [ self signal ]
]

{ #category : #error }
CDManualFluidClassDefinitionParser >> validatePackage: aString [
 
	| packageNode |
	"we should validate that aString is not 333 or 3C or point"
	packageNode := CDPackageNode new packageName: aString.
	classDefinition
		packageNameNode: packageNode astNode: packageNode

]

{ #category : #validating }
CDManualFluidClassDefinitionParser >> validateSuperclass [

	self validateSuperclass: array first
]

{ #category : #validating }
CDManualFluidClassDefinitionParser >> validateSuperclass: aString [ 

	"We do not check that the class exist because a class definition can be about classes elsewhere than in the image."
	(aString isString and: [ self validClassName: aString ])
		ifFalse: [  CDFluidClassParserError new 
							messageText: 'A class name should start with an uppercase, followed by letter or digits';
							parseContext: (CDParseErrorContext new actualTokens: {aString}; fullTokens: array);
							signal ].
	self setSuperclassName: aString
	
]

{ #category : #error }
CDManualFluidClassDefinitionParser >> wrongClassMessageError [

	CDFluidClassParserError new 
			messageText: 'A class is defined using the message < as in Object < #Point or Object class < #Point';
			parseContext: (CDParseErrorContext new 
										actualTokens: {array third}; fullTokens: array);
										signal
]

{ #category : #error }
CDManualFluidClassDefinitionParser >> wrongInstanceMessageError [

	CDFluidClassParserError new 
			messageText: 'A class is defined using the message < as in Object < #Point';
			parseContext: (CDParseErrorContext new 
										actualTokens: {array second}; fullTokens: array);
										signal
]
