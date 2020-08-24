Extension { #name : #ClassDescription }

{ #category : #'*FluidClassDefinition' }
ClassDescription >> definitionWithSlots [
	"The class definition with a way to specify slots. Shown when the class defines special Slot"
	^ self instanceSide asFluidDefinitionString
	
	"
	| stream poolString|
	poolString := self sharedPoolsString.

	stream := (String new: 800) writeStream.
	superclass 
		ifNotNil: [stream nextPutAll: superclass name]
		ifNil: [stream nextPutAll: 'ProtoObject'].
	stream 
		nextPutAll: ' subclass: '; 
		store: self name.
	self hasTraitComposition ifTrue: [
		stream 
			crtab; 
			nextPutAll: 'uses: ';
			nextPutAll: self traitCompositionString ].
			
	self classLayout isFixedLayout ifFalse: [
		stream 
			crtab; 
			nextPutAll: 'layout: ';
			nextPutAll: self classLayout class name ].
	
	stream 
		crtab; 
		nextPutAll: 'slots: ';
		nextPutAll: self slotDefinitionString.
		
	stream 
		crtab; 
		nextPutAll: 'classVariables: ';
		nextPutAll: self classVariableDefinitionString.
	
	poolString = '' ifFalse: [
		stream 
			crtab; 
			nextPutAll: 'poolDictionaries: ';
			store: poolString ].
		
	stream 
		crtab; 
		nextPutAll: 'package: ';
		store: self category asString.

	superclass ifNil: [ 
		stream nextPutAll: '.'; cr.
		stream nextPutAll: self name.
		stream space; nextPutAll: 'superclass: nil'. ].

	^ stream contents"
]
