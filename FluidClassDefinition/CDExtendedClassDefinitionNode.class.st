"
To be merged in its superclass when integrated
"
Class {
	#name : #CDExtendedClassDefinitionNode,
	#superclass : #CDClassDefinitionNode,
	#instVars : [
		'tags'
	],
	#category : #'FluidClassDefinition-Extensions'
}

{ #category : #accessing }
CDExtendedClassDefinitionNode >> tags [
	^ tags
]

{ #category : #accessing }
CDExtendedClassDefinitionNode >> tags: anObject [
	tags := anObject
]
