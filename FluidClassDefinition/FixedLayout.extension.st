Extension { #name : #FixedLayout }

{ #category : #'*FluidClassDefinition' }
FixedLayout class >> extending: superLayout scope: aScope host: aClass [
	^ (superLayout extend: aScope)
		host: aClass;
		yourself
]
