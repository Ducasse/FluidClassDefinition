"
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
	#name : #CDFluidClassDefinitionParser,
	#superclass : #CDAbstractClassDefinitionParser,
	#category : #FluidClassDefinition
}

{ #category : #query }
CDFluidClassDefinitionParser >> isClassDefinition [
	"Returns whether the identified class definition is an class side one"
	
	^ classDefinition isClassSideDefinition
]

{ #category : #query }
CDFluidClassDefinitionParser >> isInstanceDefinition [
	"returns whether the identified class definition is an instance side one"
	
	^ classDefinition isInstanceSideDefinition
]

{ #category : #visiting }
CDFluidClassDefinitionParser >> isInstanceSideDefinition: aNode [
	"Point < #ColoredPoint vs. Point class < #ColoredPoint"
	
	| instanceSide selector |
	[ selector := aNode receiver selector ] 
			on: MessageNotUnderstood 
			do: [ :ex | CDFluidClassParserError new messageText: aNode selector, ' is not a correct way to define a class'; signal ] .
	instanceSide := aNode receiver selector = #<.
	instanceSide 
		ifFalse: [ aNode receiver selector = #class
						ifTrue: [ "we only return false when class is used"
						^ false ]
						ifFalse: [ CDFluidClassParserError new messageText: aNode receiver selector, 'is not a correct way to define a class'; signal ] 
						].
	^ instanceSide
]

{ #category : #visiting }
CDFluidClassDefinitionParser >> parseClassName: aNode [ 
]

{ #category : #visiting }
CDFluidClassDefinitionParser >> parseSelectorPart: selectorPart withArgument: anArray [
]

{ #category : #visiting }
CDFluidClassDefinitionParser >> visitCascadeNode: aRBCascadeNode [ 
	
	"RBCascadeNode((Object <<< #Point)
	slots: {#x . #y};
	classVariables: {#XX . #YY};
	package: #'Kernel-BasicObjects')"	self halt.
]

{ #category : #visiting }
CDFluidClassDefinitionParser >> visitMessageNode: aRBMessageNode [
	"selector is packages"
	self isInstanceDefinition
		ifTrue: [ self parseClassName: aRBMessageNode receiver receiver  ]
		ifFalse: [ self parseClassName: aRBMessageNode receiver receiver ].
	
	aRBMessageNode selectorParts
		with: aRBMessageNode arguments
		do: [ :selectorPart :argument |
			self parseSelectorPart: selectorPart withArgument: argument ]
]
