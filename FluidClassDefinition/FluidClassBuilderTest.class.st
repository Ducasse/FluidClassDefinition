Class {
	#name : #FluidClassBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'builder'
	],
	#category : #'FluidClassDefinition-Builder'
}

{ #category : #running }
FluidClassBuilderTest >> builder [ 	

	^  builder
]

{ #category : #running }
FluidClassBuilderTest >> setUp [

	builder := FluidClassBuilder new 
		superclassToBuild: Object;
		classNameToBuild: #Point33;
		package: 'FakedPackage'

]

{ #category : #'tests - gathering' }
FluidClassBuilderTest >> testBuildLayout [

	builder 
		layout: VariableLayout;
		package: 'Collections-Sequenceable'.
	self assert: builder layoutToBuild equals: VariableLayout

	
]

{ #category : #'tests - build' }
FluidClassBuilderTest >> testBuildSimplePoint2 [

	| clas |
	builder := Object < #Point2.
	builder slots: { #x . #y }.
	builder package: 'FakedCore'.
	clas := builder build.
	
	self assert: clas superclass equals: Object.
	self assert: clas name equals: #Point2.
	self assert: clas slots size equals: 2.
	self falg: #askPablo.
	"self assert: clas package packageName equals: 'FakedCore'"
	
]

{ #category : #'tests - gathering' }
FluidClassBuilderTest >> testBuilderSharedPools [

	builder slots: {#string . #runs};
		tag: 'Base';
		sharedPools: 'TextConstants';
		package: 'Text-Core'.  
	self assert: builder sharedPoolsToBuild equals: 'TextConstants'.
	
]

{ #category : #'tests - gathering' }
FluidClassBuilderTest >> testBuilderSharedVariables [

	builder 
		layout: ByteLayout;
		sharedVariables: { #NonAsciiMap };
		package: 'Collections-Strings'.  
	self assert: builder sharedVariablesToBuild equals: { #NonAsciiMap }.
	self assert: builder layoutToBuild equals: ByteLayout.
	
]

{ #category : #'tests - gathering' }
FluidClassBuilderTest >> testBuilderTraits [
	
	builder uses: TViewModel.
	self assert: builder traitsToBuild equals: TViewModel 
]

{ #category : #'tests - mandatory' }
FluidClassBuilderTest >> testBuilderWithPackage [

	builder package: 'Kernel-BasicObjects'.
	self assert: builder packageToBuild equals: 'Kernel-BasicObjects'

	
]

{ #category : #'tests - gathering' }
FluidClassBuilderTest >> testBuilderWithSlots [

	builder slots: { #x . #y }.
	self assert: builder slotsToBuild equals: { #x . #y }.

	
]

{ #category : #'tests - gathering' }
FluidClassBuilderTest >> testBuilderWithTag [

	builder tag: 'Foo'.
	self assert: builder tagToBuild equals: 'Foo'.

	
]

{ #category : #'tests - mandatory' }
FluidClassBuilderTest >> testCreateBuilder [

	builder := Object < #Point.
	self assert: builder superclassToBuild equals: Object.
	self assert: builder classNameToBuild equals: #Point.
	
]

{ #category : #'tests - mandatory' }
FluidClassBuilderTest >> testCreateBuilderWithNil [

	builder := nil < #NewProtoObject.
	self assert: builder superclassToBuild equals: nil.
	self assert: builder classNameToBuild equals: #NewProtoObject.
	
]
