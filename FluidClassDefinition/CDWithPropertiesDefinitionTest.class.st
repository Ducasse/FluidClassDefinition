Class {
	#name : #CDWithPropertiesDefinitionTest,
	#superclass : #CDFluidClassParserTest,
	#category : #FluidClassDefinition
}

{ #category : #helpers }
CDWithPropertiesDefinitionTest >> classDefinitionString [

	^ 'Object <<< #Point
			slots: {#x . #y};
			classVariables: { #XX . #YY};
			package: #''Kernel-BasicObjects'''
]
