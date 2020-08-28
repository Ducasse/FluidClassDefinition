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
CDTraitParserTest >> testSimpleDefinition [

	| def |
	def := self classDefinitionParserClass parse: 'Trait << #TPoint
			package: ''Kernel-BasicObjects'''.
	"please rename class name!!! it should be class"
	self assert: def className equals: #TPoint.
	self assert: def packageName equals:  #'Kernel-BasicObjects'

]

{ #category : #'tests - slots' }
CDTraitParserTest >> testSimpleDefinitionWithEmptySlots [

	| def |
	def := self classDefinitionParserClass parse: 'Trait << #TPoint2
			slots: {  };
			package: ''Kernel-BasicObjects'''.
	"please rename class name!!! it should be class"
	self assert: def className equals: #TPoint2.
	self assert: def slots isEmpty.
	self assert: def packageName equals:  #'Kernel-BasicObjects'

]

{ #category : #'tests - slots' }
CDTraitParserTest >> testSimpleDefinitionWithSlots [

	| def |
	def := self classDefinitionParserClass parse: 'Trait << #TPoint2
			slots: { #x . #y };
			package: ''Kernel-BasicObjects'''.
	"please rename class name!!! it should be class"
	self assert: def className equals: #TPoint2.
	self assert: def slots first name equals: #x. 
	self assert: def slots second name equals: #y. 
	self assert: def packageName equals:  #'Kernel-BasicObjects'

]

{ #category : #'tests - slots' }
CDTraitParserTest >> testSimpleDefinitionWithTypedSlots [

	| def |
	def := self classDefinitionParserClass parse: 'Trait << #TPoint2
			slots: { #inst => InstanceVariableSlot };
			package: ''Kernel-BasicObjects'''.
	"please rename class name!!! it should be class"
	self assert: def className equals: #TPoint2.
	self assert: def slots first name equals: #inst.
	self assert: def packageName equals:  #'Kernel-BasicObjects'

]

{ #category : #'tests - trait users' }
CDTraitParserTest >> testWithEmptyUses [

	| def |
	def := self classDefinitionParserClass parse: 'Trait << #TPoint2
			uses: {  };
			package: ''Kernel-BasicObjects'''.
	"please rename class name!!! it should be class"
	self assert: def className equals: #TPoint2.
	self assert: def traitDefinition equals: 1.
	self assert: def packageName equals:  #'Kernel-BasicObjects'

]
