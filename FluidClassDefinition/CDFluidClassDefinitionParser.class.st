"
The new syntax for class definition (just for the class and not for the methods) is

Superclass < #MyObject
		uses: #MyTrait;
		slots: { #a. #b };
		sharedVariables: { #A. #B };
  		tags: {'tag2' . 'Core'} ;
		layout: VariableLayout; 
		sharedPools: { #TextConstants } ;
 		package: #MyPackage

The minimal class definition is the following one: 

Superclass < #MyObject
		package: #MyPackage

Pay attention all the messages should be keyword-based.


Note that sending a message to the superclass is close to subclass: and it lets the class selects 
a class definition parser if the syntax should be extended. 
In addition having a binary message makes () unneccessary.

Open Questions: what should be a class definition 

Object class < #Point
	package: 'Kernel-BasicObjects'

?

What is the advantage over 

CDManualFluidClassDefinitionParser class
	instanceVariableNames: ''



Implementation
===============

arrayTokens contains the RBTokens and array contains just the symbols.
This way I do not have to change everything all the times.
Should remove array

Open question/todo: 
===================


	- how to handle errors 

	- how do handle variableSubclass:, weakSubclass:, ephemeronSubclass: 
			I would favor
			
			 	Superclass < #MyObject
					slots: { #a. #b };
					layout: VariableLayout; 
					
			This way we do not have to manage possibly wrong arguments. 
	- should make sure that the node of the tree can be used with findBestNode that....
				
	- make sure that the corresponding messages do exist in the respective class 
	so that we can have both a declarative and execution version. 

"
Class {
	#name : #CDFluidClassDefinitionParser,
	#superclass : #CDAbstractClassDefinitionParser,
	#instVars : [
		'array',
		'lines',
		'arrayTokens'
	],
	#classVars : [
		'On'
	],
	#category : #'FluidClassDefinition-Parser'
}

{ #category : #'temporary controls' }
CDFluidClassDefinitionParser class >> initialize [
	"self initialize"
	On := true
]

{ #category : #'temporary controls' }
CDFluidClassDefinitionParser class >> isOn [ 
	^ On
]

{ #category : #'temporary controls' }
CDFluidClassDefinitionParser class >> off [

	On := false
]

{ #category : #'temporary controls' }
CDFluidClassDefinitionParser class >> on [

	On := true
]

{ #category : #'temporary controls' }
CDFluidClassDefinitionParser class >> setStatus: aBoolean [

	On := aBoolean
]

{ #category : #private }
CDFluidClassDefinitionParser >> array: aCollection [ 
	array := aCollection
]

{ #category : #error }
CDFluidClassDefinitionParser >> basicError [

	CDFluidClassParserError new 
			messageText: 'Wrong class definition it should be either Object < #Point or Object class < #Point ';	
			signal

]

{ #category : #private }
CDFluidClassDefinitionParser >> chopLinesFrom: start [ 
	
	lines := OrderedCollection new. 
	lines := arrayTokens allButFirst: start.
	lines := lines splitOn: [ :each | each value = $;].
	lines := lines allButLast.

	

]

{ #category : #'private properties' }
CDFluidClassDefinitionParser >> classCreationSelectorString [
	^ '<'
]

{ #category : #private }
CDFluidClassDefinitionParser >> fluidLines [
	^ lines
]

{ #category : #private }
CDFluidClassDefinitionParser >> hasFluidPart [
	
	^ array size > 5
]

{ #category : #testing }
CDFluidClassDefinitionParser >> isClassDefinition [
	"Returns whether the identified class definition is a class side one.
	i.e., something like 
		
		Object class < #Point
			package: ''Kernel-BasicObjects''
	"
	
	^ classDefinition isClassSideDefinition
]

{ #category : #query }
CDFluidClassDefinitionParser >> isInstanceDefinition [
	"Returns whether the identified class definition is an instance side one."
	
	^ classDefinition isInstanceSideDefinition
]

{ #category : #testing }
CDFluidClassDefinitionParser >> isInstanceSideDefinition: aRBMessageNode [
	"Based on the Point or Point class structure, returns whether the definition is a class or instance side definition."
	^ self halt.
]

{ #category : #public }
CDFluidClassDefinitionParser >> parse: aString [
	self setString: aString.
	self validateMinimalDefinition.
	self setInstanceOrClassSide.
	classDefinition tokens: arrayTokens.
	self isInstanceDefinition
		ifTrue: [ self setSuperclass.
			self setClassName: array third.
			self setPackage: array last.
			self hasFluidPart
				ifTrue: [ self chopLinesFrom: 3.
					self treatLines ] ].
	self halt.
	^ classDefinition
]

{ #category : #operations }
CDFluidClassDefinitionParser >> parseClassVariableNames: aNode [ 
	"copied from CDClassDefinitionParser"
	| slotNodes |
	slotNodes := aNode statements
		collect: [ :slot |
			CDSharedVariableNode
				node: aNode
				name: slot value
				slotClassName: 'ClassVariableSlot'
				start: slot start
				stop: slot stop ].
	classDefinition sharedSlots: slotNodes
]

{ #category : #operations }
CDFluidClassDefinitionParser >> parseKindFrom: aString [ 

	classDefinition classKind: aString
]

{ #category : #operations }
CDFluidClassDefinitionParser >> parseSelectorPart: aString withArgument: aNode [ 
	"copied and adapted from CDClassDefinitionParser"
	
	(#(#variable #ephemeron #weak #variableByte #normal #variableWord) includes: aString)
		ifTrue: [ ^ self parseKindFrom: aString ].
	aString =	 #slots:
		ifTrue: [ ^ self parseSlotsNodesFromArrayNode: aNode ].
	aString =	 #sharedVariables:
		ifTrue: [ ^ self parseClassVariableNames: aNode ].	
	aString =	 #uses:
		ifTrue: [ ^ self parseTraitDefinitionFromNode: aNode ].
	aString = #tags:
		ifTrue: [ ^ self parseTagsFromNode: aNode ].
	aString =	 #sharedPools:
		ifTrue: [ ^ self parseSharedPoolsFromNode: aNode ].
	CDUnrecognizedClassPart new
		classDefinition: self; 
		unrecognizedPart: aString;
		signal
]

{ #category : #operations }
CDFluidClassDefinitionParser >> parseSharedPoolsFromNode: aNode [ 

	'Superclass < #MyObject		
		...
		sharedPools: { #TextConstants } ;
 		...	
		package: #MyPackage'
]

{ #category : #operations }
CDFluidClassDefinitionParser >> parseSlotNode: aRBMessageNode [
	"what ugly method! Pay attention start and stop should be tested and probably adjusted!"

	"when a slot is just 'inst'"
	aRBMessageNode isLiteralNode
		ifTrue: [ | slot |
			slot := self slotNodeClass
				node: aRBMessageNode
				name: aRBMessageNode value
				slotClassName: #InstanceVariableSlot
				initializationMessage: self slotInitializationNodeClass new
				start: aRBMessageNode start
				stop: aRBMessageNode stop.
			classDefinition addSlot: slot.
			^ self ].
	
	aRBMessageNode selector = '=>' 
		ifTrue: [  
			aRBMessageNode arguments first isMessage
		
		ifFalse: [  
			"when a slot is just 'inst' => InstanceVariableSlot."
			aRBMessageNode arguments first isVariable
				ifTrue: [ | slot |
					slot := self slotNodeClass
						node: aRBMessageNode
						name: aRBMessageNode receiver value
						slotClassName: aRBMessageNode arguments first name
						initializationMessage: self slotInitializationNodeClass new
						start: aRBMessageNode start
						stop: aRBMessageNode stop.
						classDefinition addSlot: slot.
				^ self ].
				"we will have to do something for example if we have 
				#x => 2"
				]
			ifTrue: [  
				
				"when a slot is 'inst' => (InstanceVariableSlot default: 5)."
				| slot slotDefNode |
				slotDefNode := aRBMessageNode.
				slot := self slotNodeClass
					node: aRBMessageNode
					name: slotDefNode receiver value
					slotClassName: slotDefNode arguments first receiver name
					initializationMessage:
						(self slotInitializationNodeClass
							selectorParts: aRBMessageNode arguments first selectorParts
							argumentParts: aRBMessageNode arguments first arguments)
					start: aRBMessageNode start
					stop: aRBMessageNode stop.
				classDefinition addSlot: slot.
				^ self ]
		]
]

{ #category : #operations }
CDFluidClassDefinitionParser >> parseSlotsNodesFromArrayNode: aRBArrayNode [
	
	aRBArrayNode statements do: [ :slotStatement |
		self parseSlotNode: slotStatement ]
]

{ #category : #operations }
CDFluidClassDefinitionParser >> parseTagsFromNode: aRBArrayNode [ 
	
	classDefinition tags: aRBArrayNode
]

{ #category : #operations }
CDFluidClassDefinitionParser >> parseTraitDefinitionFromNode: aNode [
	"copied from CDClassDefinitionParser"
	| traitComposition |
	(aNode isKindOf: RBArrayNode) and: [aNode isEmpty ifTrue: [ ^self ]].
	traitComposition := CDTraitCompositionBuilder new buildFrom: aNode.	
	classDefinition traitDefinition: traitComposition.
]

{ #category : #'private properties' }
CDFluidClassDefinitionParser >> setClassName: aString [
	"no validation made, use validateClassName: to get one."

	classDefinition className: aString astNode: (self classNameNodeClass new className: aString)
		
]

{ #category : #building }
CDFluidClassDefinitionParser >> setInstanceOrClassSide [
	"array second value = self classCreationSelectorString
		ifTrue: [ self beClassDefinition ]
		ifFalse: [ array second value = 'class'
				ifTrue: [ array third value = self classCreationSelectorString
						ifTrue: [ self beMetaclassDefinition ]
						ifFalse: [ self wrongClassMessageError ] ]
				ifFalse: [ self wrongInstanceMessageError ] ]."
			
	"in case of error decide that we get an instance definition"
	self beClassDefinition. 
	array second value = self classCreationSelectorString
		ifFalse: [ array second value = 'class'
				ifTrue: [ array third value = self classCreationSelectorString
						ifTrue: [ self beMetaclassDefinition ]]].
	self flag: #shouldDiscusss
]

{ #category : #building }
CDFluidClassDefinitionParser >> setPackage: aString [
 
	| packageNode |
	packageNode := CDPackageNode new packageName: aString.
	classDefinition
		packageNameNode: packageNode astNode: packageNode

]

{ #category : #private }
CDFluidClassDefinitionParser >> setString: aString [
	arrayTokens := self tokensOf: aString.
	array := arrayTokens collect: [ :each | each value ]
]

{ #category : #building }
CDFluidClassDefinitionParser >> setSuperclass [
	self setSuperclassName: array first value

]

{ #category : #'private properties' }
CDFluidClassDefinitionParser >> setSuperclassName: aString [
	"No validation" 
	
	| superclassNode |
	superclassNode := self classNameNodeClass new className: aString.
	classDefinition
		superclassName: aString
		astNode: superclassNode
]

{ #category : #private }
CDFluidClassDefinitionParser >> tokensOf: aString [
	^ RBScanner scanTokenObjects: aString
	"^ RBParser parseLiterals: aString"
]

{ #category : #private }
CDFluidClassDefinitionParser >> treatLines [

	| msg |
	lines do: [ :each | 
			| expressionTree tokens parser |
			each size = 1 
				ifTrue: [ 
					"we have a unary message"
					self parseSelectorPart: each first value withArgument: #()]
				ifFalse: [  
					tokens := each asOrderedCollection.
					tokens addLast: RBToken new.
					msg := tokens first.
					tokens := tokens allButFirst.
					parser := CDRBParser new  initializeWithTokenStream: (ReadStream on: tokens).
					expressionTree := parser parseExpressionFromTokens.
					self parseSelectorPart: msg value withArgument:  expressionTree statements first.	
		]
	]
	
]

{ #category : #error }
CDFluidClassDefinitionParser >> validateMinimalDefinition [

	array size < 3
		ifTrue: [ self signal ]
]

{ #category : #error }
CDFluidClassDefinitionParser >> wrongClassMessageError [
	"I do not know how to not raise an error here!"
	CDFluidClassParserError new 
			messageText: 'A class is defined using the message < as in Object < #Point or Object class < #Point';
			parseContext: (CDValidationReport new 
										actualTokens: {array third}; fullTokens: array);
										signal
]

{ #category : #error }
CDFluidClassDefinitionParser >> wrongInstanceMessageError [

	CDFluidClassParserError new 
			messageText: 'A class is defined using the message < as in Object < #Point';
			parseContext: (CDValidationReport new 
										actualTokens: {array second}; fullTokens: array);
										signal
]
