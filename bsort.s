j _bsort
000010 00000000000000000000000111 #0 offset=7
000000 #1
000000 #2
000005 #3
000008 #3
000007 #4
000001 #6
.data
	.word
#t0 = 01000
#t1 = 01001
#t2 = 01010
#t3 = 01011

.text
_bsort:
	LW $t3,24($0)
	# 100011 base rt=t3 offset
	100011 00000 01011 0000000000011000 #7
	LW $t2,20($0)
	100011 00000 01010 0000000000010100
	LW $t1,16($0)
	100011 00000 01001 0000000000010000
	LW $t0,12($0)
	100011 00000 01000 0000000000001100

# sort0: #t0,t1
	SLT $s0,$t1,$t0 #if t1<t0, s0=1
	#slt rd rs rt
	# 000000 rs=t1 rt=t0 rd=s0 00000 101010
	000000 01001 01000 10000 00000 101010 #44
	BEQ $s0,$0,sort1 #if s0==0(t0<t1) don't switch
	# 000100 rs=s0 rt=0 offset=3
	000100 10000 00000 0000000000000011 #48
#switch
	ADD $s1,$t0,$0 #tmp=s1=t0
	#ADD rd,rs,rt
	# 00000 rs=t0 rt=0 rd=s1 00000 100000
	000000 01000 00000 10001 00000 100000 #52
	ADD $t0,$t1,$0 #t0=t1
	# 00000 rs=t1 rt=0 rd=t0 00000 100000
	000000 01001 00000 01000 00000 100000 #56
	ADD $t1,$s1,$0 #t1=s1=tmp=t0
	# 00000 rs=s1 rt=0 rd=t1 00000 100000
	000000 10001 00000 01001 00000 100000 #60

sort1: #t1,t2
	SLT $s0,$t2,$t1
	# 000000 t2 t1 s0 00000 101010
	000000 01010 01001 10000 00000 101010 #64
	BEQ $s0,$0,sort2
	# 000100 rs=s0 rt=0 offset=84-68-4=12
	000100 10000 00000 0000000000001100 #68
	ADD $s1,$t1,$0
	# 00000 rs=t1 rt=0 rd=s1 00000 100000
	000000 01001 00000 10001 00000 100000 #72
	ADD $t1,$t2,$0
	# 00000 rs=t2 rt=0 rd=t1 00000 100000
	000000 01010 00000 01001 00000 100000 #76
	ADD $t2,$s1,$0
	# 00000 rs=s1 rt=0 rd=t2 00000 100000
	000000 10001 00000 01010 00000 100000 #80

sort2: #t2,t3
	SLT $s0,$t3,$t2
	# 000000 t3 t2 s0 00000 101010
	000000 01011 01010 10000 00000 101010
	BEQ $s0,$0,sort3
	000100 10000 00000 0000000000001100
	ADD $s1,$t2,$0
	#ADD rd,rs,rt
	# 00000 rs=t2 rt=0 rd=s1 00000 100000
	000000 01010 00000 10001 00000 100000
	ADD $t2,$t3,$0
	# 00000 rs=t3 rt=0 rd=t2 00000 100000
	000000 01011 00000 01010 00000 100000
	ADD $t3,$s1,$0
	# 00000 rs=s1 rt=0 rd=t3 00000 100000
	000000 10001 00000 01011 00000 100000

sort3: #t0,t1
	SLT $s0,$t1,$t0
	000000 01001 01000 10000 00000 101010
	BEQ $s0,$0,sort4
	000100 10000 00000 0000000000001100
	ADD $s1,$t0,$0
	000000 01000 00000 10001 00000 100000
	ADD $t0,$t1,$0
	000000 01001 00000 01000 00000 100000
	ADD $t1,$s1,$0
	000000 10001 00000 01001 00000 100000

sort4: #t1,t2
	SLT $s0,$t2,$t1
	000000 01010 01001 10000 00000 101010
	BEQ $s0,$0,sort5
	000100 10000 00000 0000000000001100
	ADD $s1,$t1,$0
	000000 01001 00000 10001 00000 100000
	ADD $t1,$t2,$0
	000000 01010 00000 01001 00000 100000
	ADD $t2,$s1,$0
	000000 10001 00000 01010 00000 100000

sort5: #t0,t1
	SLT $s0,$t1,$t0
	000000 01001 01000 10000 00000 101010
	BEQ $s0,$0,_EXIT
	000100 10000 00000 0000000000001100
	ADD $s1,$t0,$0
	000000 01000 00000 10001 00000 100000
	ADD $t0,$t1,$0
	000000 01001 00000 01000 00000 100000
	ADD $t1,$s1,$0
	000000 10001 00000 01001 00000 100000

_EXIT:
	SW $t0,12($0)
	# 101011 base5 rt5 offset16
	101011 00000 01000 0000000000001100
	SW $t1,16($0)
	101011 00000 01001 0000000000010000
	SW $t2,20($0)
	101011 00000 01010 0000000000010100
	SW $t3,24($0)
	101011 00000 01011 0000000000011000