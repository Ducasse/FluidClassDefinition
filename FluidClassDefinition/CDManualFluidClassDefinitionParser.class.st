"
I am a copy of class CDFluidClassDefinitionParser. This comment is copied from there, and might not be entirely accurate

The new syntax for class definition (just for the class and not for the methods) is

Superclass <<< #MyObject
		uses: #MyTrait;
		slots: { #a. #b };
		classVariables: { #A. #B };
  		tags: #(Core) ;
		package: #MyPackage

The minimal class definition is the following one: 

Superclass <<< #MyObject
		package: #MyPackage


Note that sending a message to the superclass is close to subclass: and it lets the class selects 
a class definition parser if the syntax should be extended. 
In addition having a binary message makes () unneccessary.
"
Class {
	#name : #CDManualFluidClassDefinitionParser,
	#superclass : #CDAbstractClassDefinitionParser,
	#instVars : [
		'array'
	],
	#category : #FluidClassDefinition
}

{ #category : #visiting }
CDManualFluidClassDefinitionParser >> basicError [

	CDFluidClassParserError new 
			messageText: 'Wrong class definition it should be either Object < #Point or Object class < #Point ';	
			signal

]

{ #category : #testing }
CDManualFluidClassDefinitionParser >> isClassDefinition [
	"Returns whether the identified class definition is an class side one"
	
	^ classDefinition isClassSideDefinition
]

{ #category : #query }
CDManualFluidClassDefinitionParser >> isInstanceDefinition [
	"returns whether the identified class definition is an instance side one"
	
	^ classDefinition isInstanceSideDefinition
]

{ #category : #visiting }
CDManualFluidClassDefinitionParser >> isInstanceSideDefinition: aNode [
	"Point < #ColoredPoint vs. Point class < #ColoredPoint"
	
	| correctSelector selector |
	[ selector := aNode receiver selector ] 
			on: MessageNotUnderstood 
			do: [ :ex | CDFluidClassParserError new messageText: aNode selector, ' is not a correct way to define a class'; signal ].
	correctSelector := selector = #<.
	correctSelector 
			ifTrue: [
				(aNode receiver receiver class = RBMessageNode)
						ifTrue: [ aNode receiver receiver selector = #class 
									ifTrue: [ "we only return false when class is used"
										^ false ]]
			ifFalse: [ ^ true]].
	 CDFluidClassParserError new messageText: aNode receiver selector, 'is not a correct way to define a class'; signal.
		
	

]

{ #category : #visiting }
CDManualFluidClassDefinitionParser >> parse: aString [
	array := self tokensOf: aString.
	self validateInstanceOrClassSide.
	self isInstanceDefinition
		ifTrue: [ self validateSuperclass: array first.
				 	self validatePackage: array last ].
	^ classDefinition
]

{ #category : #visiting }
CDManualFluidClassDefinitionParser >> parseClassName: aNode [ 
]

{ #category : #visiting }
CDManualFluidClassDefinitionParser >> parseSelectorPart: selectorPart withArgument: anArray [
]

{ #category : #accessing }
CDManualFluidClassDefinitionParser >> superclass [
]

{ #category : #visiting }
CDManualFluidClassDefinitionParser >> tokensOf: aString [

	^ RBParser parseLiterals: aString
]

{ #category : #visiting }
CDManualFluidClassDefinitionParser >> validateInstanceOrClassSide [
	array second = '<'
		ifTrue: [ self beClassDefinition ]
		ifFalse: [ array second = 'class'
				ifTrue: [ array third = '<'
						ifTrue: [ self beMetaclassDefinition ]
						ifFalse: [ self basicError ] ]
				ifFalse: [ self basicError ] ]
]

{ #category : #visiting }
CDManualFluidClassDefinitionParser >> validatePackage: aString [
 
	| packageNode |
	"we should validate that aString is not 333 or 3C or point"
	packageNode := CDPackageNode new packageName: aString.
	classDefinition
		packageNameNode: packageNode astNode: packageNode

]

{ #category : #visiting }
CDManualFluidClassDefinitionParser >> validateSuperclass: aString [ 
	| superclassNode |
	"we should validate that aString is not 333 or 3C or point"
	superclassNode := self classNameNodeClass new className: aString.
	classDefinition
		superclassName: aString
		astNode: superclassNode
]

{ #category : #visiting }
CDManualFluidClassDefinitionParser >> visitCascadeNode: aRBCascadeNode [ 
	
	"RBCascadeNode((Object <<< #Point)
	slots: {#x . #y};
	classVariables: {#XX . #YY};
	package: #'Kernel-BasicObjects')"	self halt.
]

{ #category : #visiting }
CDManualFluidClassDefinitionParser >> visitMessageNode: aRBMessageNode [
	"selector is packages"
	self isInstanceDefinition
		ifTrue: [ self parseClassName: aRBMessageNode receiver receiver  ]
		ifFalse: [ self parseClassName: aRBMessageNode receiver receiver ].
	
	aRBMessageNode selectorParts
		with: aRBMessageNode arguments
		do: [ :selectorPart :argument |
			self parseSelectorPart: selectorPart withArgument: argument ]
]
