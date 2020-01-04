Class {
	#name : #CDBogusMinimalClassDefinitionTest,
	#superclass : #CDFluidClassParserTest,
	#category : #'FluidClassDefinition-MessageBasedVersion'
}

{ #category : #running }
CDBogusMinimalClassDefinitionTest >> classDefinitionString [

	^ '2Object <| #3Point
			packagez: #''_Kernel-BasicObjects'''
]
