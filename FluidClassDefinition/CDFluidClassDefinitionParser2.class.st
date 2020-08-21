"
I'm parser for the new class syntax. 


### The new syntax for class definition (just for the class and not for the methods) is

```
Superclass < #MyObject
		uses: #MyTrait;
		slots: { #a. #b };
		sharedVariables: { #A. #B };
  		tags: {'tag2' . 'Core'} ;
		layout: VariableLayout; 
		sharedPools: { #TextConstants } ;
 		package: #MyPackage
```
Pay attention all the messages should be keyword-based.

The minimal class definition is the following one: 

```
Superclass < #MyObject
		package: #MyPackage
```



### Concerns 
Note that sending a message to the superclass is close to subclass: and it lets the class selects 
a class definition parser if the syntax should be extended. 
In addition having a binary message makes () unneccessary.


### Class side definition 
In Pharo, a metaclass cannot be created in isolation (yes we can programmatically) so the class side definition is the following one. But we need more investigation on this point.

``` 
	Point class
		uses: TraitX;
		slots: { foo };
		package: ''Kernel-BasicObjects'''
```	



"
Class {
	#name : #CDFluidClassDefinitionParser2,
	#superclass : #Object,
	#instVars : [
		'classDefinition',
		'subclass'
	],
	#category : #'FluidClassDefinition-Parser'
}

{ #category : #parsing }
CDFluidClassDefinitionParser2 class >> fromASTNode: aNode [ 
	
	^ self new parseRootNode: aNode
]

{ #category : #parsing }
CDFluidClassDefinitionParser2 class >> parse: aString [ 
	
	^ self new parse: aString
]

{ #category : #internal }
CDFluidClassDefinitionParser2 >> beClassDefinition [
		
	classDefinition := CDClassDefinitionNode new
]

{ #category : #internal }
CDFluidClassDefinitionParser2 >> beMetaclassDefinition [
		
	classDefinition := CDMetaclassDefinitionNode new
]

{ #category : #'private class factory' }
CDFluidClassDefinitionParser2 >> classNameNodeClass [
	^ CDClassNameNode
]

{ #category : #parsing }
CDFluidClassDefinitionParser2 >> handleClassAndSuperclassOf: aNode [
	
	(self isInstanceSideDefinition: aNode receiver)
		ifTrue: [ 
			self parseSuperclassNode: aNode receiver receiver.
			self parseClassName: aNode receiver arguments first  
			]
		ifFalse: [ self parseClassName: aNode receiver receiver ].
]

{ #category : #testing }
CDFluidClassDefinitionParser2 >> isInstanceSideDefinition: aRBMessageNode [
	"Based on the Point or Point class structure, returns whether the definition is a class or instance side definition."
	"Depending on the chosen syntax for class side we could make sure that we are looking for <"
	^ aRBMessageNode isMessage and: [ aRBMessageNode selector = #< ]
	
]

{ #category : #accessing }
CDFluidClassDefinitionParser2 >> package: aNode [ 
	
	classDefinition packageNameNode: aNode astNode: aNode
]

{ #category : #'parsing main' }
CDFluidClassDefinitionParser2 >> parse: aString [ 
	
	| expressionTree |
	expressionTree := RBParser parseExpression: aString.
	expressionTree doSemanticAnalysis.
	
	^ self parseRootNode: expressionTree
]

{ #category : #parsing }
CDFluidClassDefinitionParser2 >> parseClassName: aNode [
	| className superclassNode |
	className := (aNode isVariable
		ifTrue: [ aNode name ]
		ifFalse: [ aNode value ]) asSymbol.
	superclassNode := self classNameNodeClass new
		originalNode: aNode;
		className: className.
	classDefinition className: className astNode: superclassNode
]

{ #category : #parsing }
CDFluidClassDefinitionParser2 >> parseClassName: aNode withType: aSymbol [
	
	self parseClassName: aNode.
	classDefinition classKind: aSymbol
]

{ #category : #parsing }
CDFluidClassDefinitionParser2 >> parseInstanceVariablesFromNode: aNode [
	| slots slotNodes instanceVariablesString |
	instanceVariablesString := aNode value.
	slots := instanceVariablesString substrings.
	slotNodes := slots
		collect: [ :slotName | 
			| start |
			start := aNode start
				+ (instanceVariablesString findString: slotName).
			self slotNodeClass
				node: aNode
				name: slotName
				slotClassName: #InstanceVariableSlot
				start: start
				stop: start + slotName size ].
	classDefinition slots: slotNodes
]

{ #category : #parsing }
CDFluidClassDefinitionParser2 >> parseLayout: aNode [

	classDefinition classKind: aNode binding value kind
]

{ #category : #parsing }
CDFluidClassDefinitionParser2 >> parsePoolDictionariesFromNode: aNode [
	| shareds sharedPoolNodes sharedPoolString |
	sharedPoolString := aNode value.
	shareds := sharedPoolString substrings.
	sharedPoolNodes := shareds
		collect: [ :slotName | 
			| start |
			start := aNode start + (sharedPoolString findString: slotName).
			self sharedPoolNodeClass
				node: aNode
				name: slotName
				start: start
				stop: start + slotName size ].
	classDefinition sharedPools: sharedPoolNodes
]

{ #category : #parsing }
CDFluidClassDefinitionParser2 >> parseRootNode: expressionTree [
	expressionTree extractClassDefinitionFor: self. 
	classDefinition originalNode: expressionTree.
	
	expressionTree acceptVisitor: self.
	^ classDefinition
]

{ #category : #'parsing main' }
CDFluidClassDefinitionParser2 >> parseSelectorPart: aString withArgument: aNode [ 
	"We could do this with reflection, or with a dictionary and closures.
	I chose to use a series of if for readability only."
	

	aString =	 #slots:
		ifTrue: [ ^ self parseSlotsNodesFromArrayNode: aNode ].
	aString =	 #sharedVariables: 
		ifTrue: [ ^ self parseSharedVariableNames: aNode ].	
	aString =	 #package:
		ifTrue: [ ^ self package: aNode ].
	aString = #layout:
		ifTrue: [ ^ self parseLayout: aNode ].	
	aString = #tags: 
		ifTrue: [  ^self "do nothing since class definition do not store them." ].
	aString =	 #uses:
		ifTrue: [ ^ self parseTraitDefinitionFromNode: aNode ].
	aString =	 #sharedPools:
		ifTrue: [ ^ self parseSharedPoolsFromNode: aNode ].
	
	CDUnrecognizedClassPart new
		classDefinition: self; 
		unrecognizedPart: aString;
		signal
]

{ #category : #parsing }
CDFluidClassDefinitionParser2 >> parseSharedPoolsFromNode: aNode [
	| shareds sharedPoolNodes sharedPoolString |
	sharedPoolString := aNode value.
	shareds := sharedPoolString substrings.
	sharedPoolNodes := shareds
		collect: [ :slotName | 
			| start |
			start := aNode start + (sharedPoolString findString: slotName).
			self sharedPoolNodeClass
				node: aNode
				name: slotName
				start: start
				stop: start + slotName size ].
	classDefinition sharedPools: sharedPoolNodes
]

{ #category : #parsing }
CDFluidClassDefinitionParser2 >> parseSharedVariableNames: aNode [ 
	
	| slotNodes classVariablesString |
	classVariablesString := aNode sourceCode.
	slotNodes := aNode statements
		collect: [ :literalNode | 		
			| start literalName |
			literalName := literalNode value.
			start := aNode start + (classVariablesString findString: literalName).
			CDSharedVariableNode
				node: aNode
				name: literalName
				slotClassName: 'ClassVariableSlot'
				start: start
				stop: start + literalNode size ].
	classDefinition sharedSlots: slotNodes
]

{ #category : #parsing }
CDFluidClassDefinitionParser2 >> parseSlotNode: aRBMessageNode [
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
			aRBMessageNode arguments first isGlobal
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

{ #category : #parsing }
CDFluidClassDefinitionParser2 >> parseSlotsNodesFromArrayNode: aRBArrayNode [
	
	aRBArrayNode statements do: [ :slotStatement |
		self parseSlotNode: slotStatement ]
]

{ #category : #parsing }
CDFluidClassDefinitionParser2 >> parseSuperclassNode: aSuperclassNode [
	| aSuperclassName superclassNode |
	aSuperclassName := aSuperclassNode isLiteralNode
		ifTrue: [ nil ]
		ifFalse: [ aSuperclassNode binding value asString asSymbol ].
	superclassNode := self classNameNodeClass new
		originalNode: aSuperclassNode;
		className: aSuperclassName.
	classDefinition
		superclassName: aSuperclassName
		astNode: superclassNode
]

{ #category : #parsing }
CDFluidClassDefinitionParser2 >> parseTraitDefinitionFromNode: aNode [
	
	| traitComposition |
	traitComposition := CDTraitCompositionBuilder new buildFrom: aNode.	
	classDefinition traitDefinition: traitComposition.
]

{ #category : #internal }
CDFluidClassDefinitionParser2 >> setAdequateClassDefinitionFrom: expressionTree [
	"set a class or metaclass class definition as class definition object."
	(self isInstanceSideDefinition: expressionTree)
		ifTrue: [ self beClassDefinition ]
		ifFalse: [ self beMetaclassDefinition ]
]

{ #category : #'private class factory' }
CDFluidClassDefinitionParser2 >> sharedPoolNodeClass [
	^ CDSharedPoolNode
]

{ #category : #'private class factory' }
CDFluidClassDefinitionParser2 >> slotInitializationNodeClass [

	^ RBSlotInitializationNode 
]

{ #category : #'private class factory' }
CDFluidClassDefinitionParser2 >> slotNodeClass [
	^ CDSlotNode
]

{ #category : #parsing }
CDFluidClassDefinitionParser2 >> visitCascadeNode: aRBCascadeNode [ 
	
	self handleClassAndSuperclassOf: aRBCascadeNode.	
	aRBCascadeNode messages do: 
		[:msg | msg selectorParts
					with: msg arguments
					do: [ :selectorPart :argument |
			self parseSelectorPart: selectorPart withArgument: argument ] ]
]

{ #category : #parsing }
CDFluidClassDefinitionParser2 >> visitMessageNode: aRBMessageNode [

	"Object < #Point
			package: ''Kernel-BasicObjects'''.
	or 
	
	Class side definition to be discussed.
	 either 
	Object < #Point
			uses: TraitX;
			slots: { foo };
			package: ''Kernel-BasicObjects'''
	
	or 
	Point class
		uses: TraitX;
		slots: { foo };
		package: ''Kernel-BasicObjects'''
	With this one we do not pass via the builder.
	
		"		
	self handleClassAndSuperclassOf: aRBMessageNode.
	
	
	aRBMessageNode selectorParts
		with: aRBMessageNode arguments
		do: [ :selectorPart :argument |
			self parseSelectorPart: selectorPart withArgument: argument ]
]
