Class {
	#name : #FluidClassBuilderTest,
	#superclass : #TestCase,
	#category : #'FluidClassDefinition-Builder'
}

{ #category : #tests }
FluidClassBuilderTest >> builder [ 	

	^  FluidClassBuilder new
]

{ #category : #tests }
FluidClassBuilderTest >> testBuildLayout [
	| builder |
	builder := self builder.
	builder 
		layout: VariableLayout;
		package: 'Collections-Sequenceable'.
	self assert: builder layoutToBuild equals: VariableLayout

	
]

{ #category : #tests }
FluidClassBuilderTest >> testBuilderPoolDictionaries [

	| builder |
	builder := self builder.
	builder slots: {#string . #runs};
		tag: 'Base';
		poolDictionaries: 'TextConstants';
		package: 'Text-Core'.  
	self assert: builder poolDictionariesToBuild equals: 'TextConstants'.
	
]

{ #category : #tests }
FluidClassBuilderTest >> testBuilderSharedVariables [

	| builder |
	builder := self builder.
	builder 
		layout: ByteLayout;
		sharedVariables: { #NonAsciiMap };
		package: 'Collections-Strings'.  
	self assert: builder sharedVariablesToBuild equals: { #NonAsciiMap }.
	self assert: builder layoutToBuild equals: ByteLayout.
	
]

{ #category : #tests }
FluidClassBuilderTest >> testBuilderWithPackage [

	| builder |
	builder := self builder.
	builder package: 'Kernel-BasicObjects'.
	self assert: builder packageToBuild equals: 'Kernel-BasicObjects'

	
]

{ #category : #tests }
FluidClassBuilderTest >> testBuilderWithSlots [

	| builder |
	builder := self builder.
	builder slots: { #x . #y }.
	self assert: builder slotsToBuild equals: { #x . #y }.

	
]

{ #category : #tests }
FluidClassBuilderTest >> testBuilderWithTag [

	| builder |
	builder := self builder.
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
