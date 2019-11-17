Class {
	#name : #CDMinimalClassDefinitionTest,
	#superclass : #CDFluidClassParserTest,
	#category : #FluidClassDefinition
}

{ #category : #running }
CDMinimalClassDefinitionTest >> classDefinitionString [

	^ 'Object <<< #Point
			package: #''Kernel-BasicObjects'''
]
