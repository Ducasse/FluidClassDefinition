"
I'm a builder to create class definition using a fluid interface. 
I'm created by the message < as in 

Object < #Point

My build process happens when I resolve the message #package: as in 

Object < #Point 
	slots: { #x . #y };
	tag: 'Basics';
	package: 'Kernel'
	
"
Class {
	#name : #FluidClassBuilder,
	#superclass : #Object,
	#instVars : [
		'superclassToBuild',
		'classNameToBuild',
		'slotsToBuild',
		'tagToBuild'
	],
	#category : #'FluidClassDefinition-Builder'
}

{ #category : #accessing }
FluidClassBuilder >> classNameToBuild [
	^ classNameToBuild
]

{ #category : #accessing }
FluidClassBuilder >> classNameToBuild: aSymbol [ 
	classNameToBuild := aSymbol
]

{ #category : #accessing }
FluidClassBuilder >> slots: aCollection [ 
	slotsToBuild := aCollection
]

{ #category : #accessing }
FluidClassBuilder >> slotsToBuild [
	^ slotsToBuild
]

{ #category : #accessing }
FluidClassBuilder >> superclassToBuild [
	^ superclassToBuild
]

{ #category : #accessing }
FluidClassBuilder >> superclassToBuild: aClass [ 
	
	superclassToBuild := aClass
]

{ #category : #accessing }
FluidClassBuilder >> tag: aString [ 
	tagToBuild := aString
]

{ #category : #accessing }
FluidClassBuilder >> tagToBuild [
	^ tagToBuild
]
