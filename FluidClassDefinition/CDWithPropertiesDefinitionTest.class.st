Class {
	#name : #CDWithPropertiesDefinitionTest,
	#superclass : #CDAbstractFluidClassParserTest,
	#category : #'FluidClassDefinition-MessageBasedVersion'
}

{ #category : #helpers }
CDWithPropertiesDefinitionTest >> classDefinitionString [

	^ 'Object < #Point
			slots: {#x . #y};
			classVariables: { #XX . #YY};
			package: #''Kernel-BasicObjects'''
]

{ #category : #helpers }
CDWithPropertiesDefinitionTest >> firstClassVariableName [

	^ 'XX'
]

{ #category : #helpers }
CDWithPropertiesDefinitionTest >> firstInstanceVariableName [

	^ 'x'
]

{ #category : #helpers }
CDWithPropertiesDefinitionTest >> secondClassVariableName [

	^ 'YY'
]

{ #category : #helpers }
CDWithPropertiesDefinitionTest >> secondInstanceVariableName [

	^ 'y'
]

{ #category : #tests }
CDWithPropertiesDefinitionTest >> testClassDefHasInstanceVarSlots [
	
	self assert: classDefinition slotNodes first name equals: self firstInstanceVariableName.
	self assert: classDefinition slotNodes second name equals: self secondInstanceVariableName.
]
