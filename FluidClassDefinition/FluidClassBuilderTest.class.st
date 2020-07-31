Class {
	#name : #FluidClassBuilderTest,
	#superclass : #TestCase,
	#category : #'FluidClassDefinition-Builder'
}

{ #category : #tests }
FluidClassBuilderTest >> testBuilderWithPackage [

	| builder |
	builder := Object < #Point.
	builder package: 'Kernel-BasicObjects'.
	self assert: builder packageToBuild equals: 'Kernel-BasicObjects'

	
]

{ #category : #tests }
FluidClassBuilderTest >> testBuilderWithSlots [

	| builder |
	builder := Object < #Point.
	builder slots: { #x . #y }.
	self assert: builder slotsToBuild equals: { #x . #y }.

	
]

{ #category : #tests }
FluidClassBuilderTest >> testBuilderWithTag [

	| builder |
	builder := Object < #Point.
	builder tag: 'Foo'.
	self assert: builder tagToBuild equals: 'Foo'.

	
]

{ #category : #tests }
FluidClassBuilderTest >> testCreateBuilder [

	| builder |
	builder := Object < #Point.
	self assert: builder superclassToBuild equals: Object.
	self assert: builder classNameToBuild equals: #Point.
	
]

{ #category : #tests }
FluidClassBuilderTest >> testCreateBuilderWithNil [

	| builder |
	builder := nil < #NewProtoObject.
	self assert: builder superclassToBuild equals: nil.
	self assert: builder classNameToBuild equals: #NewProtoObject.
	
]
