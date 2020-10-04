Class {
	#name : #OldPharoClassDefinitionPrinterTest,
	#superclass : #CommonClassDefinitionPrinterTest,
	#category : #'FluidClassDefinition-Printer-UnderDev'
}

{ #category : #'instance creation' }
OldPharoClassDefinitionPrinterTest >> forClass: aClass [
	^ (OldPharoClassDefinitionPrinter for: aClass) definitionString 


]

{ #category : #'instance creation' }
OldPharoClassDefinitionPrinterTest >> setUp [ 
	super setUp.
	ClassDefinitionPrinter showSlotClassDefinition: false.
]

{ #category : #'tests - traits' }
OldPharoClassDefinitionPrinterTest >> testAlignmentMorphClass [

	self 
		assert: (self forClass: AlignmentMorph class)  equals: 'BorderedMorph class subclass: ''AlignmentMorph class''
	uses: TAbleToRotate classTrait
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''Morphic-Base-Basic'''
]

{ #category : #'tests - classes' }
OldPharoClassDefinitionPrinterTest >> testArray [

	self 
		assert: (self forClass: Array) equals: 'ArrayedCollection variableSubclass: #Array
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''Collections-Sequenceable-Base'''
]

{ #category : #'tests - classes' }
OldPharoClassDefinitionPrinterTest >> testByteString [

	self 
		assert: (self forClass: ByteString) 
		equals: 'String variableByteSubclass: #ByteString
	instanceVariableNames: ''''
	classVariableNames: ''NonAsciiMap''
	package: ''Collections-Strings-Base'''
]

{ #category : #'tests - classes' }
OldPharoClassDefinitionPrinterTest >> testChronologyConstants [
	
	self assert: (self forClass: ChronologyConstants) equals: 'SharedPool subclass: #ChronologyConstants
	instanceVariableNames: ''''
	classVariableNames: ''DayNames DaysInMonth MicrosecondsInDay MonthNames NanosInMillisecond NanosInSecond SecondsInDay SecondsInHour SecondsInMinute SqueakEpoch''
	package: ''Kernel-Chronology'''
]

{ #category : #'tests - metaclasses' }
OldPharoClassDefinitionPrinterTest >> testClassSideDoesNotShowPackage [

	self assert: (self forClass: MOPTraitTest class) equals: 'TestCase class subclass: ''MOPTraitTest class''
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''Tests-Traits-MOP'''
]

{ #category : #'tests - traits' }
OldPharoClassDefinitionPrinterTest >> testComplexTrait [

	self assert: (self forClass: MOPTestClassD) equals: 'Object subclass: #MOPTestClassD
	uses: Trait2 @ {#c3->#c2}
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''Tests-Traits-MOP'''

]

{ #category : #'tests - metaclasses' }
OldPharoClassDefinitionPrinterTest >> testMetaclass [
	
	self assert: (self forClass: Metaclass) equals:  'ClassDescription subclass: #Metaclass
	instanceVariableNames: ''thisClass''
	classVariableNames: ''''
	package: ''Kernel-Classes'''
]

{ #category : #'tests - metaclasses' }
OldPharoClassDefinitionPrinterTest >> testMetaclassClass [
	
	self 
		assert: (self forClass: Metaclass class) 
		equals: 'ClassDescription class subclass: ''Metaclass class''
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''Kernel-Classes'''	
]

{ #category : #'tests - traits' }
OldPharoClassDefinitionPrinterTest >> testMultiPools [

	self assert: (self forClass: ClassMultiplePoolUser) equals: 'Object subclass: #ClassMultiplePoolUser
	instanceVariableNames: ''''
	classVariableNames: ''''
	poolDictionaries: ''PoolDefiner PoolDefiner2''
	package: ''Kernel-Tests-Classes'''
]

{ #category : #'tests - classes' }
OldPharoClassDefinitionPrinterTest >> testPoint [

	"it should break!!"
	self assert: (self forClass: Point) equals: 'Object subclass: #Point
	instanceVariableNames: ''x y''
	classVariableNames: ''''
	package: ''Kernel-BasicObjects'''
]

{ #category : #'tests - classes' }
OldPharoClassDefinitionPrinterTest >> testProtoObject [
	
	self assert: (self forClass: ProtoObject) equals: 'ProtoObject subclass: #ProtoObject
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''Kernel-Objects''.
ProtoObject superclass: nil'
		
 
]

{ #category : #'tests - metaclasses' }
OldPharoClassDefinitionPrinterTest >> testSystemAnnouncerClass [
	
	self 
		assert: (self forClass: SystemAnnouncer class) 
		equals: 'Announcer class subclass: ''SystemAnnouncer class''
	instanceVariableNames: ''announcer''
	classVariableNames: ''''
	package: ''System-Announcements-Core'''
]

{ #category : #'tests - traits' }
OldPharoClassDefinitionPrinterTest >> testTBehavior [

	self 
		assert: (self forClass: TBehavior)  equals: 'ProtoObject subclass: #TBehavior
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''TraitsV2-Compatibility-Traits''.
TBehavior superclass: nil'
]

{ #category : #'tests - traits' }
OldPharoClassDefinitionPrinterTest >> testTComparableClassTrait [

	self assert: (self forClass: TComparable classTrait) equals: 'Trait subclass: ''TComparable classTrait''
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''Kernel-Traits-Base'''
]

{ #category : #'tests - traits' }
OldPharoClassDefinitionPrinterTest >> testTEventVisitorClassTrait [

	self assert: (self forClass: EpTEventVisitor classTrait) equals: 'Trait subclass: ''EpTEventVisitor classTrait''
	uses: EpTCodeChangeVisitor classTrait
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''Epicea-Visitors'''
]

{ #category : #'tests - traits' }
OldPharoClassDefinitionPrinterTest >> testTSlot [

	self 
		assert: (Trait << #TTUses slots: {  #x . #y }; package: 'Fake') build definitionString 
		equals: 
	'Trait  << #TTUses
	slots: { #x . #y };
	package: ''_UnpackagedPackage''' 
]

{ #category : #'tests - traits' }
OldPharoClassDefinitionPrinterTest >> testTUses [

	self assert: (Trait << #TTUses uses: TBehavior; package: 'Fake') build definitionString equals:  'Trait  << #TTUses
	uses: TBehavior;
	package: ''_UnpackagedPackage'''
]

{ #category : #'tests - classes' }
OldPharoClassDefinitionPrinterTest >> testText [

	self assert: (self forClass: Text) equals: 'ArrayedCollection subclass: #Text
	instanceVariableNames: ''string runs''
	classVariableNames: ''''
	poolDictionaries: ''TextConstants''
	package: ''Text-Core-Base'''
]

{ #category : #'tests - traits' }
OldPharoClassDefinitionPrinterTest >> testTrait [
	
	self assert: (self forClass: RubScrolledTextModel) equals: 'Object subclass: #RubScrolledTextModel
	uses: TViewModel
	instanceVariableNames: ''hasUnacceptedEdits announcer text primarySelectionInterval interactionModel''
	classVariableNames: ''''
	package: ''Rubric-Editing-Widgets'''
	 
]

{ #category : #'tests - traits' }
OldPharoClassDefinitionPrinterTest >> testTrait3 [

	self assert: (self forClass: Trait3 classTrait) equals: 'Trait3 classTrait
	uses: Trait2 classTrait
	instanceVariableNames: '''

]

{ #category : #'tests - traits' }
OldPharoClassDefinitionPrinterTest >> testTrait3AndTag [

	self 
		assert: (self forClass: Trait3) 
		equals: 'Trait named: #Trait3
	 uses: Trait2
	 package: ''Tests-Traits-MOP''' 
]
