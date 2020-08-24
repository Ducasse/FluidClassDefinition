Class {
	#name : #CDClassTagNode,
	#superclass : #CDNode,
	#instVars : [
		'name'
	],
	#category : #'FluidClassDefinition-New Nodes'
}

{ #category : #accessing }
CDClassTagNode >> name [
	^ name
]

{ #category : #accessing }
CDClassTagNode >> name: aString [ 
	name := aString
]
