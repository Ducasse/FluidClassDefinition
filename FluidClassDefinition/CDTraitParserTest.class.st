Class {
	#name : #CDTraitParserTest,
	#superclass : #TestCase,
	#instVars : [
		'traitDefinition'
	],
	#category : #'FluidClassDefinition-Parser'
}

{ #category : #running }
CDTraitParserTest >> classDefinitionParserClass [

	^ CDFluidClassDefinitionParser
]

{ #category : #'tests - simple trait definition' }
CDTraitParserTest >> testSimpleDefinitionClassName [

	| def |
	def := self classDefinitionParserClass parse: 'Trait << #TPoint
			package: ''Kernel-BasicObjects'''.
	"please rename class name!!! it should be class"
	self assert: def className equals: #TPoint.

]
