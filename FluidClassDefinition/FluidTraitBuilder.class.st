Class {
	#name : #FluidTraitBuilder,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'slots',
		'name'
	],
	#category : #'FluidClassDefinition-Builder'
}

{ #category : #accessing }
FluidTraitBuilder >> build [ 
	self halt.
	Trait 
]

{ #category : #accessing }
FluidTraitBuilder >> name: aString [

	name := aString
]

{ #category : #accessing }
FluidTraitBuilder >> package: aString [
	
	packageName := aString.
	
]

{ #category : #accessing }
FluidTraitBuilder >> slots: anArray [

	slots := anArray
]
