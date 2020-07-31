"
I'm a builder to create class definition using a fluid interface. 
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

### Todo

Hi Stef, 
   the classBuilder is made in a way that it always produces a valid class. For all its ""parameters"" it has default values. The only needed one is the className. It can be used direclty creating it by ShiftClassBuilder new, and it can already create and configure the class. It does not install it in the environment (that is done by the ClassInstaller). 
The use of 
ShiftClassInstaller make: [ :builder| ...] is just to get a builder that is configured for such installer. 
Maybe this part of the api can be upgraded, so I can give a builder to the installer and say, install whatever this builder creates. 
For the example:
ShiftClassBuilder new
    buildEnvironment: (ShSmalltalkGlobalsEnvironment new);
    name: #CDAbstractClassDefinitionParser;
    slots: { #classDefinition. #subclass };
    category: 'FluidClassDefinition-Foo';
    build
The build message will create the class, until that point nothing is used. I am seeing some things I will like to change, for example I like the split of the package and the tag (and replace the old category).
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
		'poolDictionaries'
	],
	#category : #'FluidClassDefinition-Builder'
}

{ #category : #accessing }
FluidClassBuilder >> classNameToBuild [
	^ classNameToBuild
]

{ #category : #accessing }
FluidClassBuilder >> classNameToBuild: aSymbol [ 
	classNameToBuild := aSymbol
]

{ #category : #'as yet unclassified' }
FluidClassBuilder >> layout: aClass [ 
	layout := aClass
]

{ #category : #'as yet unclassified' }
FluidClassBuilder >> layoutToBuild [
	^ layout 
]

{ #category : #accessing }
FluidClassBuilder >> package: aString [
	packageName := aString
]

{ #category : #accessing }
FluidClassBuilder >> packageToBuild [
	^ packageName
]

{ #category : #'as yet unclassified' }
FluidClassBuilder >> poolDictionaries: aString [ 
	poolDictionaries := aString
]

{ #category : #'as yet unclassified' }
FluidClassBuilder >> poolDictionariesToBuild [
	^ poolDictionaries 
]

{ #category : #'as yet unclassified' }
FluidClassBuilder >> sharedVariables: aCollection [ 
	sharedVariables := aCollection
]

{ #category : #'as yet unclassified' }
FluidClassBuilder >> sharedVariablesToBuild [
	^ sharedVariables 
]

{ #category : #accessing }
FluidClassBuilder >> slots: aCollection [ 
	slotsToBuild := aCollection
]

{ #category : #accessing }
FluidClassBuilder >> slotsToBuild [
	^ slotsToBuild
]

{ #category : #accessing }
FluidClassBuilder >> superclassToBuild [
	^ superclassToBuild
]

{ #category : #accessing }
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
