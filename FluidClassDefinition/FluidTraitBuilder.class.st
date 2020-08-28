Class {
	#name : #FluidTraitBuilder,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'slots',
		'name',
		'uses',
		'builder'
	],
	#category : #'FluidClassDefinition-Builder'
}

{ #category : #accessing }
FluidTraitBuilder >> build [

	^ builder build 


]

{ #category : #accessing }
FluidTraitBuilder >> fillShiftClassBuilder [

	builder := ShiftClassBuilder new.
	builder buildEnvironment: ShSmalltalkGlobalsEnvironment new. 
	builder
		name: name;
		superclass: nil;
		metaSuperclass: Trait;
		metaclassClass: MetaclassForTraits;
		slots: slots;
		sharedVariables: '';
		sharedPools: '';
		category: packageName.
	uses ifNotNil: [ 
		builder traitComposition: uses asTraitComposition.
		builder classTraitComposition: uses asTraitComposition classComposition ].
	builder classSlots: #()
]

{ #category : #accessing }
FluidTraitBuilder >> instanceVariables: anArray [

	slots := anArray
]

{ #category : #accessing }
FluidTraitBuilder >> name: aString [

	name := aString
]

{ #category : #accessing }
FluidTraitBuilder >> package: aString [
	self fillShiftClassBuilder. 
	packageName := aString.
	
]

{ #category : #accessing }
FluidTraitBuilder >> slots: anArray [

	slots := anArray
]

{ #category : #accessing }
FluidTraitBuilder >> uses: anArray [

	uses := anArray
]
