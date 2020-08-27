"
I'm a builder to create class definition using a fluid interface. In the future I should be removed 
and a shiftClassBuilder should be used instead.

I'm created by the message `<` as in 

```
Object < #Point
```

My build process happens when I resolve the message #package: as in 

```
Object < #Point 
	slots: { #x . #y };
	tag: 'Basics';
	package: 'Kernel'
```	

Now this is not totally true. This expression creates a shiftClassBuilder.
And we should send build to the fluidclassbuilder to actually kick the building.
 
	
The mandatory information (name, superclass, package) are systematically passed to the builder.
Others are checked first and when available passed. 	
	
### To install a class (to be used later)

```
ShiftClassInstaller new makeWithBuilder: (Object < #Point33 
 slots: { #x . #y };
 tag: 'Basics';
 package: 'Kernel') shiftClassBuilder	
```

"
Class {
	#name : #FluidClassBuilder,
	#superclass : #Object,
	#instVars : [
		'superclassToBuild',
		'classNameToBuild',
		'slotsToBuild',
		'tagToBuild',
		'packageName',
		'layout',
		'sharedVariables',
		'poolDictionaries',
		'traitComposition',
		'sharedPools',
		'shiftClassBuilder',
		'stBuilder'
	],
	#category : #'FluidClassDefinition-Builder'
}

{ #category : #building }
FluidClassBuilder >> build [

	^ shiftClassBuilder build 


]

{ #category : #'accessing mandatory' }
FluidClassBuilder >> classNameToBuild [
	"mandatory"
	
	^ classNameToBuild
]

{ #category : #'accessing mandatory' }
FluidClassBuilder >> classNameToBuild: aSymbol [ 
	classNameToBuild := aSymbol
]

{ #category : #building }
FluidClassBuilder >> fillShiftClassBuilder [ 

	shiftClassBuilder := ShiftClassBuilder new
		buildEnvironment: ShSmalltalkGlobalsEnvironment new;
		name: classNameToBuild;
		superclass: superclassToBuild;
		category: packageName.
	slotsToBuild ifNotNil: [ shiftClassBuilder slots: slotsToBuild ].
	layout ifNotNil: [ shiftClassBuilder layoutClass: layout ].
	traitComposition ifNotNil: [ shiftClassBuilder traitComposition: traitComposition ].
	sharedVariables ifNotNil: [ shiftClassBuilder sharedVariables: sharedVariables].
	poolDictionaries ifNotNil: [ shiftClassBuilder sharedPools: poolDictionaries  ].
	


]

{ #category : #accessing }
FluidClassBuilder >> layout: aClass [ 
	layout := aClass
]

{ #category : #accessing }
FluidClassBuilder >> layoutToBuild [
	^ layout 
]

{ #category : #'accessing mandatory' }
FluidClassBuilder >> package: aString [
	
	packageName := aString.
	self fillShiftClassBuilder 
]

{ #category : #'accessing mandatory' }
FluidClassBuilder >> packageToBuild [
	^ packageName
]

{ #category : #accessing }
FluidClassBuilder >> poolDictionaries: aString [ 
	poolDictionaries := aString
]

{ #category : #accessing }
FluidClassBuilder >> poolDictionariesToBuild [
	^ poolDictionaries 
]

{ #category : #accessing }
FluidClassBuilder >> sharedPools: aString [ 
	sharedPools := aString
]

{ #category : #accessing }
FluidClassBuilder >> sharedPoolsToBuild [
	^ sharedPools
]

{ #category : #accessing }
FluidClassBuilder >> sharedVariables: aCollection [ 
	sharedVariables := aCollection
]

{ #category : #accessing }
FluidClassBuilder >> sharedVariablesToBuild [
	^ sharedVariables 
]

{ #category : #building }
FluidClassBuilder >> shiftClassBuilder [ 

	^ shiftClassBuilder 
]

{ #category : #accessing }
FluidClassBuilder >> slots: aCollection [ 
	slotsToBuild := aCollection
]

{ #category : #accessing }
FluidClassBuilder >> slotsToBuild [
	^ slotsToBuild
]

{ #category : #'accessing mandatory' }
FluidClassBuilder >> superclassToBuild [
	^ superclassToBuild
]

{ #category : #'accessing mandatory' }
FluidClassBuilder >> superclassToBuild: aClass [ 
	
	superclassToBuild := aClass
]

{ #category : #accessing }
FluidClassBuilder >> tag: aString [ 
	tagToBuild := aString
]

{ #category : #accessing }
FluidClassBuilder >> tagToBuild [
	^ tagToBuild
]

{ #category : #accessing }
FluidClassBuilder >> traitsToBuild [
	^ traitComposition 
]

{ #category : #accessing }
FluidClassBuilder >> uses: aTraitComposition [
	traitComposition := aTraitComposition
]
