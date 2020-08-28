Class {
	#name : #CDTraitDefinitionNode,
	#superclass : #CDClassDefinitionNode,
	#category : #'FluidClassDefinition-New Nodes'
}

{ #category : #visitor }
CDTraitDefinitionNode >> acceptVisitor: aProgramNodeVisitor [
	
	self visitTraitDefinition: self
]
