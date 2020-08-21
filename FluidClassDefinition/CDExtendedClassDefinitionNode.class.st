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
CDExtendedClassDefinitionNode >> tag [
	^ tags
]

{ #category : #accessing }
CDExtendedClassDefinitionNode >> tag: anObject [
	tags := anObject
]

{ #category : #accessing }
CDExtendedClassDefinitionNode >> tags [
	^ tags
]

{ #category : #accessing }
CDExtendedClassDefinitionNode >> tags: anObject [
	tags := anObject
]
