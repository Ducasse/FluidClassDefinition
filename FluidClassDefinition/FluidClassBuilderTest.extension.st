Extension { #name : #FluidClassBuilderTest }

{ #category : #'*FluidClassDefinition' }
FluidClassBuilderTest >> testInstalledMinimalExceptOneMockClassRecreatorIsMinimal [

	| shiftClassBuilder installedClass |
	self removeFromSystem.
	[ 
	builder := self class compilerClass new
		           evaluate: 'Object < #MyClass
	layout: FixedLayout;
	uses: {};
	slots: { #x };
	sharedVariables: {};
	tag: '''' ;
	sharedPools: {};
	package: ''FluidClassDefinition'''.
	shiftClassBuilder := builder shiftClassBuilder.
	ShiftClassInstaller new makeWithBuilder: shiftClassBuilder.
	
	installedClass := self class environment at: #MyClass ifAbsent: [self fail].
	self assert: (ClassDefinitionPrinter fluid for: installedClass; yourself) definitionString  equals: 'Object < #MyClass
	slots: { #x };
	package: ''FluidClassDefinition''']
		ensure: [ self removeFromSystem  ]
]

{ #category : #'*FluidClassDefinition' }
FluidClassBuilderTest >> testInstalledMinimalMockClassRecreatorIsMinimal [

	| shiftClassBuilder installedClass |
	self removeFromSystem.
	[ 
	builder := self class compilerClass new
		           evaluate: 'Object < #MyClass
	layout: FixedLayout;
	uses: {};
	slots: {};
	sharedVariables: {};
	tag: '''' ;
	sharedPools: {};
	package: ''FluidClassDefinition'''.
	shiftClassBuilder := builder shiftClassBuilder.
	ShiftClassInstaller new makeWithBuilder: shiftClassBuilder.
	
	installedClass := self class environment at: #MyClass ifAbsent: [self fail].
	         
	self assert: (ClassDefinitionPrinter fluid for: installedClass) definitionString equals: 'Object < #MyClass
	package: ''FluidClassDefinition''']
		ensure: [ self removeFromSystem  ]
]
