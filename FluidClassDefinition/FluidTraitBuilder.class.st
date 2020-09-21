Class {
	#name : #FluidTraitBuilder,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'slots',
		'name',
		'uses',
		'builder',
		'tagToBuild',
		'shiftClassBuilder'
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
		metaclassClass: MetaclassForTraits.
	tagToBuild isNil or: [ tagToBuild isEmpty 
		ifTrue: [ shiftClassBuilder category: packageName ]
		ifFalse: [ shiftClassBuilder category: packageName, '-',tagToBuild asString ]].
	slots ifNotNil: [ builder slots: slots].
	builder	
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
FluidTraitBuilder >> tag [
	^ tagToBuild
]

{ #category : #accessing }
FluidTraitBuilder >> tag: anObject [
	tagToBuild := anObject
]

{ #category : #accessing }
FluidTraitBuilder >> uses: anArray [

	uses := anArray
]
