Class {
	#name : #FluidTraitBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'FluidClassDefinition-Builder'
}

{ #category : #running }
FluidTraitBuilderTest >> setUp [

	builder := FluidTraitBuilder new 
	

]

{ #category : #tests }
FluidTraitBuilderTest >> testBuildSimplePoint2 [

	| trait |
	builder := Trait << #TPoint2.
	builder slots: { #x . #y }.
	builder package: 'FakedCore'.
	trait := builder build.
	
	self assert: trait name equals: #TPoint2.
	self assert: trait slots size equals: 2.

]

{ #category : #tests }
FluidTraitBuilderTest >> testTrait [

	Trait << #TPoint3
		package: 'Fake'
]
