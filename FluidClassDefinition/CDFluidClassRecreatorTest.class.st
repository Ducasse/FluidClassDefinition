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

{ #category : #tests }
CDFluidClassRecreatorTest >> testArray [

	self assert: Array asFluidDefinitionString equals: 'ArrayedCollection < #Array
	layout: VariableLayout;
	tag: ''Base'';
	package: ''Collections-Sequenceable'''
]

{ #category : #tests }
CDFluidClassRecreatorTest >> testByteString [

	self assert: ByteString asFluidDefinitionString equals: 'String < #ByteString
	layout: ByteLayout;
	sharedVariables: { #NonAsciiMap };
	tag: ''Base'';
	package: ''Collections-Strings'''  
]

{ #category : #tests }
CDFluidClassRecreatorTest >> testChronologyConstants [
	
	self assert: ChronologyConstants asFluidDefinitionString equals: 'SharedPool < #ChronologyConstants
	sharedVariables: { #NanosInSecond. #MonthNames. #SecondsInHour. #SecondsInDay. #SqueakEpoch. #NanosInMillisecond. #DayNames. #DaysInMonth. #SecondsInMinute. #MicrosecondsInDay };
	tag: ''Chronology'';
	package: ''Kernel''' 
]

{ #category : #tests }
CDFluidClassRecreatorTest >> testMetaclass [
	
	self assert: Metaclass asFluidDefinitionString equals: 'ClassDescription < #Metaclass
	slots: {#thisClass};
	tag: ''Classes'';
	package: ''Kernel''' 
]

{ #category : #tests }
CDFluidClassRecreatorTest >> testMetaclassClass [
	
	self assert: Metaclass class asFluidDefinitionString equals: 
 'ClassDescription class < #Metaclass
	package: ''Kernel'''	
]

{ #category : #tests }
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
	self flag: #pablo. 
	self assert: class asFluidDefinitionString equals: 'Object < #Point2
	slots: {#x . #y};
	tag: ''BasicObjects'';
	package: ''Kernel'''
	
]

{ #category : #tests }
CDFluidClassRecreatorTest >> testText [

	self assert: Text asFluidDefinitionString equals: 
 'ArrayedCollection < #Text
	slots: {#string . #runs};
	tag: ''Base'';
	sharedPools: ''TextConstants'';
	package: ''Text-Core''' 
]

{ #category : #tests }
CDFluidClassRecreatorTest >> testTraitAtMetaclass [
	
	self assert: RubScrolledTextModel asFluidDefinitionString equals: 'Object < #RubScrolledTextModel
	uses: TViewModel;
	slots: {#hasUnacceptedEdits . #announcer . #text . #primarySelectionInterval . #interactionModel};
	tag: ''Editing-Widgets'';
	package: ''Rubric''' 
]
