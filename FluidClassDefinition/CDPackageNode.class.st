Class {
	#name : #CDPackageNode,
	#superclass : #CDNode,
	#instVars : [
		'packageName'
	],
	#category : #'FluidClassDefinition-Core'
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
	There a package is just an RBLiteralNode and it may be a PackageNode too."
	
	^ packageName
]
