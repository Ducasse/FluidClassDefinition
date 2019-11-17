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

{ #category : #visiting }
CDFluidClassDefinitionParser >> visitCascadeNode: aRBCascadeNode [ 
	
	"RBCascadeNode((Object <<< #Point)
	slots: {#x . #y};
	classVariables: {#XX . #YY};
	package: #'Kernel-BasicObjects')"	self halt.
]

{ #category : #visiting }
CDFluidClassDefinitionParser >> visitMessageNode: aRBMessageNode [

	(self isInstanceSideDefinition: aRBMessageNode)
		ifTrue: [ self parseSuperclassNode: aRBMessageNode receiver ]
		ifFalse: [ self parseClassName: aRBMessageNode receiver receiver ].
	
	aRBMessageNode selectorParts
		with: aRBMessageNode arguments
		do: [ :selectorPart :argument |
			self parseSelectorPart: selectorPart withArgument: argument ]
]
