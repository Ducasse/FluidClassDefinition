Class {
	#name : #CDClassTag,
	#superclass : #CDNode,
	#instVars : [
		'name'
	],
	#category : #'FluidClassDefinition-New Nodes'
}

{ #category : #accessing }
CDClassTag >> name [
	^ name
]

{ #category : #accessing }
CDClassTag >> name: aString [ 
	name := aString
]
