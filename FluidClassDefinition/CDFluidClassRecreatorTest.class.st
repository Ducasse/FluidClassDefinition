"
This test suite is about recreating a class textual representation from the class.
"
Class {
	#name : #CDFluidClassRecreatorTest,
	#superclass : #TestCase,
	#instVars : [
		'classDefinition'
	],
	#category : #'FluidClassDefinition-Parser'
}

{ #category : #'tests - classes' }
CDFluidClassRecreatorTest >> testArray [

	self assert: Array asFluidDefinitionString equals: 'ArrayedCollection < #Array
	layout: VariableLayout;
	tag: ''Base'';
	package: ''Collections-Sequenceable'''
]

{ #category : #'tests - classes' }
CDFluidClassRecreatorTest >> testByteString [

	self assert: ByteString asFluidDefinitionString equals: 'String < #ByteString
	layout: ByteLayout;
	sharedVariables: { #NonAsciiMap };
	tag: ''Base'';
	package: ''Collections-Strings'''  
]

{ #category : #'tests - classes' }
CDFluidClassRecreatorTest >> testChronologyConstants [
	
	self assert: ChronologyConstants asFluidDefinitionString equals: 'SharedPool < #ChronologyConstants
	sharedVariables: { #NanosInSecond . #MonthNames . #SecondsInHour . #SecondsInDay . #SqueakEpoch . #NanosInMillisecond . #DayNames . #DaysInMonth . #SecondsInMinute . #MicrosecondsInDay };
	tag: ''Chronology'';
	package: ''Kernel'''
]

{ #category : #'tests - classes' }
CDFluidClassRecreatorTest >> testMetaclass [
	
	self assert: Metaclass asFluidDefinitionString equals: 'ClassDescription < #Metaclass
	slots: {#thisClass};
	tag: ''Classes'';
	package: ''Kernel''' 
]

{ #category : #'tests - classes' }
CDFluidClassRecreatorTest >> testMetaclassClass [
	
	self assert: Metaclass class asFluidDefinitionString equals: 
 'ClassDescription class < #Metaclass
	package: ''Kernel'''	
]

{ #category : #'tests - classes' }
CDFluidClassRecreatorTest >> testPoint [
	
	self assert: Point asFluidDefinitionString equals: 'Object < #Point
	slots: {#x . #y};
	tag: ''BasicObjects'';
	package: ''Kernel'''
	
]

{ #category : #'tests - unnecessary values' }
CDFluidClassRecreatorTest >> testPointMinimalInformation [
	"I would like to be able to test if I provide too many empty values that
	the default empty values are just ignored."
	| class |
	self skip.
	class := (Object < #Point2
	slots: {#x . #y};
	tag: 'BasicObjects';
	package: 'Kernel') build.
	self assert: class asFluidDefinitionString equals: 'Object < #Point2
	slots: {#x . #y};
	tag: ''BasicObjects'';
	package: ''_UndefinedPackage'''
	
]

{ #category : #'tests - traits' }
CDFluidClassRecreatorTest >> testTBehavior [

	self assert: TBehavior asFluidDefinitionString equals: 'Trait  << #TBehavior
	package: ''TraitsV2-Compatibility'''
]

{ #category : #'tests - traits' }
CDFluidClassRecreatorTest >> testTSlot [

	self 
		assert: (Trait << #TTUses slots: {  #x . #y }; package: 'Fake') build asFluidDefinitionString 
		equals: 
	'Trait  << #TTUses
	slots: {#x . #y};
	package: ''_UnpackagedPackage''' 
]

{ #category : #'tests - traits' }
CDFluidClassRecreatorTest >> testTUses [

	self assert: (Trait << #TTUses uses: TBehavior; package: 'Fake') build asFluidDefinitionString equals:  'Trait  << #TTUses
	uses: TBehavior;
	package: ''_UnpackagedPackage'''
]

{ #category : #'tests - classes' }
CDFluidClassRecreatorTest >> testText [

	self assert: Text asFluidDefinitionString equals: 
 'ArrayedCollection < #Text
	slots: {#string . #runs};
	tag: ''Base'';
	sharedPools: ''TextConstants'';
	package: ''Text-Core''' 
]

{ #category : #'tests - classes' }
CDFluidClassRecreatorTest >> testTraitAtMetaclass [
	
	self assert: RubScrolledTextModel asFluidDefinitionString equals: 'Object < #RubScrolledTextModel
	uses: TViewModel;
	slots: {#hasUnacceptedEdits . #announcer . #text . #primarySelectionInterval . #interactionModel};
	tag: ''Editing-Widgets'';
	package: ''Rubric''' 
]
