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

{ #category : #tests }
OldPharoClassDefinitionPrinterTest >> testPoint [

	"it should break!!"
	self assert: (self forClass: Point) equals: 'Object subclass: #Point
	instanceVariableNames: ''x y''
	classVariableNames: ''''
	package: ''Kernel-BasicObjects'''
]
