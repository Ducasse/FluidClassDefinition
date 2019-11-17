Class {
	#name : #CDPackageNode,
	#superclass : #CDNode,
	#instVars : [
		'packageName'
	],
	#category : #FluidClassDefinition
}

{ #category : #accessing }
CDPackageNode >> packageName [
	^ packageName
]

{ #category : #accessing }
CDPackageNode >> packageName: anObject [
	packageName := anObject
]

{ #category : #accessing }
CDPackageNode >> value [ 
	"to be compatible with the default CDClassDefinitionNode definition.
	there a package is just an RBLiteralNode and it should be a PackageNode too."
	^ packageName
]
