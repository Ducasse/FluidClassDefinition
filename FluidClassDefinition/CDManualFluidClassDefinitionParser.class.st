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
		'array'
	],
	#category : #'FluidClassDefinition-NewApproach'
}

{ #category : #visiting }
CDManualFluidClassDefinitionParser >> basicError [

	CDFluidClassParserError new 
			messageText: 'Wrong class definition it should be either Object < #Point or Object class < #Point ';	
			signal

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
