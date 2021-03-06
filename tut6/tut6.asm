INCLUDE "hardware.inc"

SECTION "entry",ROM0[$0100]
	nop
	jp $0150

SECTION "start",HOME[$150]
	di

	call	waitvblank

	ld   a,%00000000
	ldh  [rLCDC],a

	ld	a,0
	ld	hl,_SCRN0+$44
	ld	b,14
maprowloop:
	ld	c,12
mapcolloop:
	ld	[hli],a
	inc	a
	
	dec	c
	jr	nz,mapcolloop

	ld	de,$14
	add	hl,de
	
	dec	b
	jr	nz,maprowloop


	
	ld	c,$A8
	ld	hl,alice
	ld	de,_VRAM
tilesloop:	
	ld	b,$10
	call	memcpy
	dec	c
	jr	nz,tilesloop
	
	ld   a,%10010001
	ldh  [rLCDC],a
	
	ld   a,%11100100 ;load a normal palette
	ldh  [rBGP],a    ;load the palette
	
loop:	
	halt
	nop
	jp	loop

waitvblank:
	ldh	a,[rLY]
	cp	$91
	jr	nz,waitvblank
	ret

memcpy:
	ld	a,[hli]
	ld	[de],a
	inc	de
	dec	b
	jr	nz,memcpy
	ret

memset:
	ld	[de],a
	inc	de
	dec	b
	jr	nz,memset
	ret

alice:
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$07,$00,$10,$0F,$2F,$1F
	db $00,$00,$00,$00,$00,$00,$A7,$40,$5F,$E0,$5B,$E4,$19,$E6,$38,$C7
	db $00,$00,$00,$00,$00,$00,$00,$00,$80,$00,$E0,$00,$E0,$00,$70,$80
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $03,$1F,$08,$07,$18,$07,$31,$0E,$25,$1E,$45,$3E,$53,$2C,$13,$6C
	db $78,$87,$FB,$04,$FB,$04,$FB,$04,$F7,$08,$F7,$08,$E7,$18,$E9,$16
	db $10,$E0,$90,$60,$D0,$20,$C0,$30,$C8,$30,$E8,$10,$E0,$18,$C0,$38
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$01,$00,$01,$00,$02,$01,$0C,$03,$18,$07
	db $23,$5C,$A3,$5C,$B3,$4C,$73,$8C,$71,$8E,$71,$8E,$78,$87,$FC,$03
	db $C9,$36,$8A,$75,$4D,$B3,$CC,$33,$CC,$33,$CF,$30,$1F,$E0,$1F,$E0
	db $C4,$38,$62,$9C,$72,$8C,$32,$CC,$79,$86,$F9,$06,$F1,$0E,$F2,$0C
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$01,$00,$03,$00,$06,$01,$0F,$00,$0B,$04,$0A,$05
	db $34,$0B,$F9,$06,$BB,$44,$FB,$04,$FB,$04,$E3,$1C,$C1,$3E,$01,$FE
	db $FE,$01,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00
	db $0F,$F0,$6E,$91,$7E,$81,$39,$C6,$92,$6C,$81,$7E,$8D,$7E,$85,$7E
	db $F2,$0C,$72,$8C,$9C,$60,$F0,$00,$70,$00,$48,$30,$48,$30,$C8,$30
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$06,$01
	db $00,$00,$00,$00,$00,$00,$03,$00,$1F,$00,$DF,$20,$9F,$60,$07,$F8
	db $00,$00,$07,$00,$71,$0E,$CF,$30,$FF,$00,$FF,$00,$FF,$00,$FF,$00
	db $10,$0F,$A1,$5E,$FF,$00,$FF,$00,$FE,$01,$F0,$0F,$FF,$00,$03,$00
	db $30,$CF,$F8,$07,$F8,$07,$F0,$0F,$02,$FF,$F0,$0F,$B2,$0F,$F0,$0F
	db $FF,$00,$3F,$C0,$07,$F8,$06,$F9,$01,$FE,$07,$F8,$0E,$F0,$08,$F0
	db $82,$7C,$03,$FC,$07,$F8,$CE,$31,$F4,$03,$07,$00,$08,$00,$18,$00
	db $CE,$30,$8F,$70,$1E,$E1,$1F,$E0,$5F,$A0,$37,$08,$19,$06,$06,$01
	db $00,$00,$00,$00,$80,$00,$60,$80,$B0,$40,$EC,$10,$F6,$08,$F9,$06
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$01,$00
	db $05,$02,$0B,$04,$1E,$01,$16,$09,$31,$0E,$42,$3C,$82,$7C,$01,$FE
	db $7C,$80,$40,$80,$80,$00,$80,$00,$00,$00,$00,$00,$00,$00,$01,$00
	db $00,$00,$00,$00,$00,$00,$06,$01,$18,$07,$20,$1F,$80,$7F,$00,$FF
	db $07,$00,$18,$07,$C0,$3F,$01,$FF,$07,$FF,$00,$FF,$00,$FF,$00,$FF
	db $80,$7F,$00,$FF,$28,$F7,$AE,$F1,$0F,$F0,$0F,$F0,$2F,$F0,$0F,$F0
	db $10,$E0,$10,$E0,$20,$C0,$63,$80,$C6,$01,$FC,$03,$FE,$01,$EF,$00
	db $30,$00,$60,$00,$C0,$00,$80,$00,$60,$80,$08,$F0,$02,$FC,$00,$FF
	db $01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $BF,$40,$67,$18,$1C,$03,$06,$01,$01,$00,$00,$00,$00,$00,$00,$00
	db $80,$00,$C0,$00,$E0,$00,$70,$80,$B0,$40,$B0,$40,$A8,$50,$A8,$50
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$01,$00,$01,$00,$02,$01,$02,$01,$04,$03
	db $9C,$7F,$98,$7F,$88,$7F,$0C,$FF,$0C,$FF,$0E,$FF,$1E,$FF,$0E,$FF
	db $62,$81,$01,$FF,$17,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	db $00,$FF,$00,$FF,$FF,$FF,$40,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	db $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	db $0C,$F0,$1C,$E0,$18,$E0,$18,$E0,$1C,$E0,$32,$C0,$2B,$C0,$2D,$C0
	db $67,$00,$23,$00,$30,$00,$20,$00,$00,$00,$00,$00,$01,$00,$00,$00
	db $82,$7F,$C1,$3F,$30,$0F,$18,$07,$0C,$03,$06,$01,$03,$00,$00,$00
	db $40,$80,$30,$C0,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$80,$7F
	db $01,$00,$0C,$03,$01,$FF,$02,$FF,$04,$FF,$04,$FF,$30,$FF,$00,$FF
	db $00,$F8,$00,$F8,$C0,$F8,$40,$F8,$64,$F8,$72,$FC,$10,$FE,$90,$FF
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$07,$08,$07,$10,$0F,$00,$1F,$20,$1F,$40,$3F,$58,$3F,$5C,$3F
	db $0F,$FF,$0B,$FF,$09,$FF,$19,$FF,$19,$FF,$19,$FF,$08,$FF,$08,$FF
	db $00,$FF,$00,$FF,$00,$FF,$80,$FF,$80,$FF,$B0,$FF,$C0,$FF,$C0,$FF
	db $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	db $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$01,$FE,$01,$FE
	db $38,$C0,$78,$80,$60,$80,$40,$80,$A8,$00,$98,$00,$C0,$00,$E0,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$80,$00,$00,$00,$80,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $80,$7F,$60,$1F,$20,$1F,$30,$0F,$18,$07,$0C,$03,$06,$01,$03,$00
	db $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	db $90,$FF,$98,$FF,$98,$FF,$08,$FF,$08,$FF,$08,$FF,$08,$FF,$00,$FF
	db $80,$00,$40,$80,$20,$C0,$10,$E0,$08,$F0,$00,$F8,$04,$F8,$00,$F8
	db $18,$3F,$32,$1D,$29,$1E,$11,$0E,$08,$07,$04,$03,$02,$01,$00,$00
	db $08,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$80,$7F
	db $C0,$FF,$60,$FF,$60,$FF,$60,$FF,$30,$FF,$30,$FF,$10,$FF,$F0,$FF
	db $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	db $01,$FE,$03,$FC,$03,$FC,$07,$F8,$05,$F8,$09,$F0,$0E,$F0,$10,$E0
	db $B0,$00,$8E,$00,$03,$00,$80,$00,$C0,$00,$C0,$00,$60,$00,$40,$00
	db $20,$00,$30,$00,$C0,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$01,$00,$01,$00
	db $01,$00,$00,$00,$01,$00,$03,$00,$0E,$01,$1C,$03,$B8,$07,$E0,$1F
	db $80,$7F,$C0,$3F,$C0,$3F,$80,$7F,$00,$FF,$00,$FF,$00,$FF,$01,$FF
	db $04,$FF,$04,$FF,$00,$FF,$00,$FF,$1C,$FF,$7C,$FF,$F8,$FF,$F2,$FC
	db $00,$F8,$08,$F0,$00,$F0,$10,$E0,$20,$C0,$40,$80,$80,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $10,$0F,$08,$07,$00,$07,$01,$06,$04,$03,$05,$03,$05,$03,$01,$03
	db $00,$FF,$60,$9F,$F8,$07,$FC,$03,$04,$FB,$F2,$FD,$FC,$FF,$FE,$FF
	db $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	db $10,$E0,$20,$C0,$60,$80,$40,$80,$78,$80,$03,$FC,$00,$FF,$00,$FF
	db $00,$00,$30,$00,$30,$00,$20,$00,$00,$00,$FF,$00,$00,$FF,$00,$FF
	db $00,$00,$00,$00,$82,$00,$02,$00,$DF,$00,$E0,$1F,$00,$FF,$00,$FF
	db $73,$00,$36,$01,$38,$07,$E0,$1F,$00,$FF,$00,$FF,$00,$FF,$00,$FF
	db $80,$7F,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$01,$FF,$03,$FF,$06,$FF
	db $03,$FF,$07,$FF,$1F,$FF,$3F,$FF,$FF,$FF,$FC,$FF,$C6,$F8,$70,$80
	db $F4,$F8,$E0,$F8,$C0,$F0,$80,$E0,$40,$80,$80,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $02,$01,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $FF,$FF,$3F,$FF,$4F,$3F,$18,$07,$03,$00,$00,$00,$00,$00,$00,$00
	db $00,$FF,$80,$FF,$E8,$FF,$F8,$FF,$1A,$FD,$73,$0C,$06,$00,$02,$00
	db $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$C0,$3F,$38,$07,$07,$00
	db $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$80,$7F
	db $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$20,$FF,$07,$F8
	db $00,$FF,$00,$FF,$00,$FF,$00,$FF,$00,$FF,$0C,$F0,$20,$C0,$80,$00
	db $1D,$FE,$34,$F8,$C8,$F0,$20,$C0,$80,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $03,$00,$01,$00,$01,$00,$01,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $03,$00,$03,$00,$83,$00,$83,$00,$C3,$00,$C3,$00,$61,$00,$61,$00
	db $3F,$00,$30,$00,$10,$00,$18,$00,$08,$00,$0C,$00,$06,$00,$06,$00
	db $F0,$00,$30,$00,$10,$00,$30,$00,$30,$00,$10,$00,$18,$00,$18,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $31,$00,$11,$00,$19,$00,$09,$00,$0C,$00,$04,$00,$07,$00,$00,$07
	db $02,$00,$03,$00,$81,$00,$81,$00,$00,$00,$00,$00,$80,$00,$00,$80
	db $18,$00,$18,$00,$18,$00,$98,$00,$18,$00,$1C,$00,$72,$0C,$67,$18
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$F0,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $08,$07,$0F,$00,$15,$08,$00,$1F,$0F,$1F,$0E,$1F,$11,$0E,$00,$00
	db $40,$80,$40,$80,$00,$80,$00,$80,$00,$80,$80,$00,$00,$00,$00,$00
	db $96,$79,$FF,$7F,$BF,$7F,$7F,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $68,$F0,$F4,$F8,$E4,$F8,$F0,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
	db $00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00,$00
