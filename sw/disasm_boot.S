
main.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <UART_check_busy-0x4>:
   0:	0750006f          	j	874 <main>

00000004 <UART_check_busy>:
   4:	fe010113          	addi	sp,sp,-32
   8:	00812e23          	sw	s0,28(sp)
   c:	02010413          	addi	s0,sp,32
  10:	000087b7          	lui	a5,0x8
  14:	20878793          	addi	a5,a5,520 # 8208 <_bss_end+0x3207>
  18:	fef42623          	sw	a5,-20(s0)
  1c:	fec42783          	lw	a5,-20(s0)
  20:	0007a783          	lw	a5,0(a5)
  24:	00078513          	mv	a0,a5
  28:	01c12403          	lw	s0,28(sp)
  2c:	02010113          	addi	sp,sp,32
  30:	00008067          	ret

00000034 <UART_read_data>:
  34:	fe010113          	addi	sp,sp,-32
  38:	00812e23          	sw	s0,28(sp)
  3c:	02010413          	addi	s0,sp,32
  40:	000087b7          	lui	a5,0x8
  44:	20078793          	addi	a5,a5,512 # 8200 <_bss_end+0x31ff>
  48:	fef42623          	sw	a5,-20(s0)
  4c:	fec42783          	lw	a5,-20(s0)
  50:	0007a783          	lw	a5,0(a5)
  54:	00078513          	mv	a0,a5
  58:	01c12403          	lw	s0,28(sp)
  5c:	02010113          	addi	sp,sp,32
  60:	00008067          	ret

00000064 <UART_send_byte>:
  64:	fd010113          	addi	sp,sp,-48
  68:	02812623          	sw	s0,44(sp)
  6c:	03010413          	addi	s0,sp,48
  70:	fca42e23          	sw	a0,-36(s0)
  74:	000087b7          	lui	a5,0x8
  78:	20478793          	addi	a5,a5,516 # 8204 <_bss_end+0x3203>
  7c:	fef42623          	sw	a5,-20(s0)
  80:	fec42783          	lw	a5,-20(s0)
  84:	fdc42703          	lw	a4,-36(s0)
  88:	00e7a023          	sw	a4,0(a5)
  8c:	00000013          	nop
  90:	02c12403          	lw	s0,44(sp)
  94:	03010113          	addi	sp,sp,48
  98:	00008067          	ret

0000009c <UART_send_word>:
  9c:	fd010113          	addi	sp,sp,-48
  a0:	02812623          	sw	s0,44(sp)
  a4:	03010413          	addi	s0,sp,48
  a8:	fca42e23          	sw	a0,-36(s0)
  ac:	000087b7          	lui	a5,0x8
  b0:	20478793          	addi	a5,a5,516 # 8204 <_bss_end+0x3203>
  b4:	fef42623          	sw	a5,-20(s0)
  b8:	fdc42783          	lw	a5,-36(s0)
  bc:	4187d713          	srai	a4,a5,0x18
  c0:	fec42783          	lw	a5,-20(s0)
  c4:	00e7a023          	sw	a4,0(a5)
  c8:	fdc42783          	lw	a5,-36(s0)
  cc:	4107d713          	srai	a4,a5,0x10
  d0:	fec42783          	lw	a5,-20(s0)
  d4:	00e7a023          	sw	a4,0(a5)
  d8:	fdc42783          	lw	a5,-36(s0)
  dc:	4087d713          	srai	a4,a5,0x8
  e0:	fec42783          	lw	a5,-20(s0)
  e4:	00e7a023          	sw	a4,0(a5)
  e8:	fec42783          	lw	a5,-20(s0)
  ec:	fdc42703          	lw	a4,-36(s0)
  f0:	00e7a023          	sw	a4,0(a5)
  f4:	00000013          	nop
  f8:	02c12403          	lw	s0,44(sp)
  fc:	03010113          	addi	sp,sp,48
 100:	00008067          	ret

00000104 <UART_check>:
 104:	fe010113          	addi	sp,sp,-32
 108:	00812e23          	sw	s0,28(sp)
 10c:	02010413          	addi	s0,sp,32
 110:	000087b7          	lui	a5,0x8
 114:	20c78793          	addi	a5,a5,524 # 820c <_bss_end+0x320b>
 118:	fef42623          	sw	a5,-20(s0)
 11c:	fec42783          	lw	a5,-20(s0)
 120:	0007a783          	lw	a5,0(a5)
 124:	00078513          	mv	a0,a5
 128:	01c12403          	lw	s0,28(sp)
 12c:	02010113          	addi	sp,sp,32
 130:	00008067          	ret

00000134 <delay_ms>:
 134:	fd010113          	addi	sp,sp,-48
 138:	02812623          	sw	s0,44(sp)
 13c:	03010413          	addi	s0,sp,48
 140:	fca42e23          	sw	a0,-36(s0)
 144:	fdc42703          	lw	a4,-36(s0)
 148:	00070793          	mv	a5,a4
 14c:	00579793          	slli	a5,a5,0x5
 150:	40e787b3          	sub	a5,a5,a4
 154:	00279793          	slli	a5,a5,0x2
 158:	40e787b3          	sub	a5,a5,a4
 15c:	00279793          	slli	a5,a5,0x2
 160:	40e787b3          	sub	a5,a5,a4
 164:	00179793          	slli	a5,a5,0x1
 168:	fef42423          	sw	a5,-24(s0)
 16c:	fe042623          	sw	zero,-20(s0)
 170:	0100006f          	j	180 <delay_ms+0x4c>
 174:	fec42783          	lw	a5,-20(s0)
 178:	00178793          	addi	a5,a5,1
 17c:	fef42623          	sw	a5,-20(s0)
 180:	fec42703          	lw	a4,-20(s0)
 184:	fe842783          	lw	a5,-24(s0)
 188:	fef746e3          	blt	a4,a5,174 <delay_ms+0x40>
 18c:	00000013          	nop
 190:	00000013          	nop
 194:	02c12403          	lw	s0,44(sp)
 198:	03010113          	addi	sp,sp,48
 19c:	00008067          	ret

000001a0 <delay_us>:
 1a0:	fd010113          	addi	sp,sp,-48
 1a4:	02812623          	sw	s0,44(sp)
 1a8:	03010413          	addi	s0,sp,48
 1ac:	fca42e23          	sw	a0,-36(s0)
 1b0:	fdc42783          	lw	a5,-36(s0)
 1b4:	00179793          	slli	a5,a5,0x1
 1b8:	fef42423          	sw	a5,-24(s0)
 1bc:	fe042623          	sw	zero,-20(s0)
 1c0:	0100006f          	j	1d0 <delay_us+0x30>
 1c4:	fec42783          	lw	a5,-20(s0)
 1c8:	00178793          	addi	a5,a5,1
 1cc:	fef42623          	sw	a5,-20(s0)
 1d0:	fec42703          	lw	a4,-20(s0)
 1d4:	fe842783          	lw	a5,-24(s0)
 1d8:	fef746e3          	blt	a4,a5,1c4 <delay_us+0x24>
 1dc:	00000013          	nop
 1e0:	00000013          	nop
 1e4:	02c12403          	lw	s0,44(sp)
 1e8:	03010113          	addi	sp,sp,48
 1ec:	00008067          	ret

000001f0 <delay>:
 1f0:	fd010113          	addi	sp,sp,-48
 1f4:	02812623          	sw	s0,44(sp)
 1f8:	03010413          	addi	s0,sp,48
 1fc:	fca42e23          	sw	a0,-36(s0)
 200:	fe042623          	sw	zero,-20(s0)
 204:	0100006f          	j	214 <delay+0x24>
 208:	fec42783          	lw	a5,-20(s0)
 20c:	00178793          	addi	a5,a5,1
 210:	fef42623          	sw	a5,-20(s0)
 214:	fec42703          	lw	a4,-20(s0)
 218:	fdc42783          	lw	a5,-36(s0)
 21c:	fef746e3          	blt	a4,a5,208 <delay+0x18>
 220:	00000013          	nop
 224:	00000013          	nop
 228:	02c12403          	lw	s0,44(sp)
 22c:	03010113          	addi	sp,sp,48
 230:	00008067          	ret

00000234 <set_led>:
 234:	fd010113          	addi	sp,sp,-48
 238:	02812623          	sw	s0,44(sp)
 23c:	03010413          	addi	s0,sp,48
 240:	fca42e23          	sw	a0,-36(s0)
 244:	000087b7          	lui	a5,0x8
 248:	30078793          	addi	a5,a5,768 # 8300 <_bss_end+0x32ff>
 24c:	fef42623          	sw	a5,-20(s0)
 250:	fec42783          	lw	a5,-20(s0)
 254:	fdc42703          	lw	a4,-36(s0)
 258:	00e7a023          	sw	a4,0(a5)
 25c:	00000013          	nop
 260:	02c12403          	lw	s0,44(sp)
 264:	03010113          	addi	sp,sp,48
 268:	00008067          	ret

0000026c <ETHERNET_send_data>:
 26c:	fd010113          	addi	sp,sp,-48
 270:	02812623          	sw	s0,44(sp)
 274:	03010413          	addi	s0,sp,48
 278:	fca42e23          	sw	a0,-36(s0)
 27c:	fcb42c23          	sw	a1,-40(s0)
 280:	fcc42a23          	sw	a2,-44(s0)
 284:	fdc42703          	lw	a4,-36(s0)
 288:	00100793          	li	a5,1
 28c:	00f71863          	bne	a4,a5,29c <ETHERNET_send_data+0x30>
 290:	000087b7          	lui	a5,0x8
 294:	fef42623          	sw	a5,-20(s0)
 298:	0100006f          	j	2a8 <ETHERNET_send_data+0x3c>
 29c:	000087b7          	lui	a5,0x8
 2a0:	10078793          	addi	a5,a5,256 # 8100 <_bss_end+0x30ff>
 2a4:	fef42623          	sw	a5,-20(s0)
 2a8:	a0a017b7          	lui	a5,0xa0a01
 2ac:	b0878793          	addi	a5,a5,-1272 # a0a00b08 <_bss_end+0xa09fbb07>
 2b0:	fef42223          	sw	a5,-28(s0)
 2b4:	fe442783          	lw	a5,-28(s0)
 2b8:	04000713          	li	a4,64
 2bc:	00e7a023          	sw	a4,0(a5)
 2c0:	fd442783          	lw	a5,-44(s0)
 2c4:	0027d793          	srli	a5,a5,0x2
 2c8:	fef42023          	sw	a5,-32(s0)
 2cc:	fe042423          	sw	zero,-24(s0)
 2d0:	0600006f          	j	330 <ETHERNET_send_data+0xc4>
 2d4:	fe842703          	lw	a4,-24(s0)
 2d8:	fe042783          	lw	a5,-32(s0)
 2dc:	02f71463          	bne	a4,a5,304 <ETHERNET_send_data+0x98>
 2e0:	fe842783          	lw	a5,-24(s0)
 2e4:	00279793          	slli	a5,a5,0x2
 2e8:	fd842703          	lw	a4,-40(s0)
 2ec:	00f707b3          	add	a5,a4,a5
 2f0:	0007a783          	lw	a5,0(a5)
 2f4:	00078713          	mv	a4,a5
 2f8:	fe442783          	lw	a5,-28(s0)
 2fc:	00e7a023          	sw	a4,0(a5)
 300:	0240006f          	j	324 <ETHERNET_send_data+0xb8>
 304:	fe842783          	lw	a5,-24(s0)
 308:	00279793          	slli	a5,a5,0x2
 30c:	fd842703          	lw	a4,-40(s0)
 310:	00f707b3          	add	a5,a4,a5
 314:	0007a783          	lw	a5,0(a5)
 318:	00078713          	mv	a4,a5
 31c:	fec42783          	lw	a5,-20(s0)
 320:	00e7a023          	sw	a4,0(a5)
 324:	fe842783          	lw	a5,-24(s0)
 328:	00178793          	addi	a5,a5,1
 32c:	fef42423          	sw	a5,-24(s0)
 330:	fe842703          	lw	a4,-24(s0)
 334:	fe042783          	lw	a5,-32(s0)
 338:	f8e7dee3          	bge	a5,a4,2d4 <ETHERNET_send_data+0x68>
 33c:	00000013          	nop
 340:	00000013          	nop
 344:	02c12403          	lw	s0,44(sp)
 348:	03010113          	addi	sp,sp,48
 34c:	00008067          	ret

00000350 <ETHERNET_read_data>:
 350:	fc010113          	addi	sp,sp,-64
 354:	02812e23          	sw	s0,60(sp)
 358:	04010413          	addi	s0,sp,64
 35c:	fca42623          	sw	a0,-52(s0)
 360:	fcb42423          	sw	a1,-56(s0)
 364:	fcc42703          	lw	a4,-52(s0)
 368:	00100793          	li	a5,1
 36c:	00f71a63          	bne	a4,a5,380 <ETHERNET_read_data+0x30>
 370:	000087b7          	lui	a5,0x8
 374:	00878793          	addi	a5,a5,8 # 8008 <_bss_end+0x3007>
 378:	fef42623          	sw	a5,-20(s0)
 37c:	0100006f          	j	38c <ETHERNET_read_data+0x3c>
 380:	000087b7          	lui	a5,0x8
 384:	10878793          	addi	a5,a5,264 # 8108 <_bss_end+0x3107>
 388:	fef42623          	sw	a5,-20(s0)
 38c:	a0a017b7          	lui	a5,0xa0a01
 390:	b0878793          	addi	a5,a5,-1272 # a0a00b08 <_bss_end+0xa09fbb07>
 394:	fef42223          	sw	a5,-28(s0)
 398:	fe442783          	lw	a5,-28(s0)
 39c:	0007a783          	lw	a5,0(a5)
 3a0:	fef42023          	sw	a5,-32(s0)
 3a4:	fe042423          	sw	zero,-24(s0)
 3a8:	fec42783          	lw	a5,-20(s0)
 3ac:	0007a783          	lw	a5,0(a5)
 3b0:	fcf42e23          	sw	a5,-36(s0)
 3b4:	fdc42703          	lw	a4,-36(s0)
 3b8:	a0a017b7          	lui	a5,0xa0a01
 3bc:	b0878793          	addi	a5,a5,-1272 # a0a00b08 <_bss_end+0xa09fbb07>
 3c0:	02f70663          	beq	a4,a5,3ec <ETHERNET_read_data+0x9c>
 3c4:	fe842783          	lw	a5,-24(s0)
 3c8:	00279793          	slli	a5,a5,0x2
 3cc:	fc842703          	lw	a4,-56(s0)
 3d0:	00f707b3          	add	a5,a4,a5
 3d4:	fdc42703          	lw	a4,-36(s0)
 3d8:	00e7a023          	sw	a4,0(a5)
 3dc:	fe842783          	lw	a5,-24(s0)
 3e0:	00178793          	addi	a5,a5,1
 3e4:	fef42423          	sw	a5,-24(s0)
 3e8:	fc1ff06f          	j	3a8 <ETHERNET_read_data+0x58>
 3ec:	00000013          	nop
 3f0:	03c12403          	lw	s0,60(sp)
 3f4:	04010113          	addi	sp,sp,64
 3f8:	00008067          	ret

000003fc <ETHERNET_check_done>:
 3fc:	fd010113          	addi	sp,sp,-48
 400:	02812623          	sw	s0,44(sp)
 404:	03010413          	addi	s0,sp,48
 408:	fca42e23          	sw	a0,-36(s0)
 40c:	fdc42703          	lw	a4,-36(s0)
 410:	00100793          	li	a5,1
 414:	00f71a63          	bne	a4,a5,428 <ETHERNET_check_done+0x2c>
 418:	000087b7          	lui	a5,0x8
 41c:	00478793          	addi	a5,a5,4 # 8004 <_bss_end+0x3003>
 420:	fef42623          	sw	a5,-20(s0)
 424:	0100006f          	j	434 <ETHERNET_check_done+0x38>
 428:	000087b7          	lui	a5,0x8
 42c:	10478793          	addi	a5,a5,260 # 8104 <_bss_end+0x3103>
 430:	fef42623          	sw	a5,-20(s0)
 434:	fec42783          	lw	a5,-20(s0)
 438:	0007a783          	lw	a5,0(a5)
 43c:	00078513          	mv	a0,a5
 440:	02c12403          	lw	s0,44(sp)
 444:	03010113          	addi	sp,sp,48
 448:	00008067          	ret

0000044c <ETHERNET_data_count>:
 44c:	fd010113          	addi	sp,sp,-48
 450:	02812623          	sw	s0,44(sp)
 454:	03010413          	addi	s0,sp,48
 458:	fca42e23          	sw	a0,-36(s0)
 45c:	fdc42703          	lw	a4,-36(s0)
 460:	00100793          	li	a5,1
 464:	00f71a63          	bne	a4,a5,478 <ETHERNET_data_count+0x2c>
 468:	000087b7          	lui	a5,0x8
 46c:	01078793          	addi	a5,a5,16 # 8010 <_bss_end+0x300f>
 470:	fef42623          	sw	a5,-20(s0)
 474:	0100006f          	j	484 <ETHERNET_data_count+0x38>
 478:	000087b7          	lui	a5,0x8
 47c:	11078793          	addi	a5,a5,272 # 8110 <_bss_end+0x310f>
 480:	fef42623          	sw	a5,-20(s0)
 484:	fec42783          	lw	a5,-20(s0)
 488:	0007a783          	lw	a5,0(a5)
 48c:	00078513          	mv	a0,a5
 490:	02c12403          	lw	s0,44(sp)
 494:	03010113          	addi	sp,sp,48
 498:	00008067          	ret

0000049c <ETHERNET_protocol>:
 49c:	fd010113          	addi	sp,sp,-48
 4a0:	02812623          	sw	s0,44(sp)
 4a4:	03010413          	addi	s0,sp,48
 4a8:	fca42e23          	sw	a0,-36(s0)
 4ac:	fdc42703          	lw	a4,-36(s0)
 4b0:	00100793          	li	a5,1
 4b4:	00f71a63          	bne	a4,a5,4c8 <ETHERNET_protocol+0x2c>
 4b8:	000087b7          	lui	a5,0x8
 4bc:	01478793          	addi	a5,a5,20 # 8014 <_bss_end+0x3013>
 4c0:	fef42623          	sw	a5,-20(s0)
 4c4:	0100006f          	j	4d4 <ETHERNET_protocol+0x38>
 4c8:	000087b7          	lui	a5,0x8
 4cc:	11478793          	addi	a5,a5,276 # 8114 <_bss_end+0x3113>
 4d0:	fef42623          	sw	a5,-20(s0)
 4d4:	fec42783          	lw	a5,-20(s0)
 4d8:	0007a783          	lw	a5,0(a5)
 4dc:	00078513          	mv	a0,a5
 4e0:	02c12403          	lw	s0,44(sp)
 4e4:	03010113          	addi	sp,sp,48
 4e8:	00008067          	ret

000004ec <ETHERNET_rx_ready>:
 4ec:	fd010113          	addi	sp,sp,-48
 4f0:	02812623          	sw	s0,44(sp)
 4f4:	03010413          	addi	s0,sp,48
 4f8:	fca42e23          	sw	a0,-36(s0)
 4fc:	fdc42703          	lw	a4,-36(s0)
 500:	00100793          	li	a5,1
 504:	00f71a63          	bne	a4,a5,518 <ETHERNET_rx_ready+0x2c>
 508:	000087b7          	lui	a5,0x8
 50c:	00c78793          	addi	a5,a5,12 # 800c <_bss_end+0x300b>
 510:	fef42623          	sw	a5,-20(s0)
 514:	0100006f          	j	524 <ETHERNET_rx_ready+0x38>
 518:	000087b7          	lui	a5,0x8
 51c:	10c78793          	addi	a5,a5,268 # 810c <_bss_end+0x310b>
 520:	fef42623          	sw	a5,-20(s0)
 524:	fec42783          	lw	a5,-20(s0)
 528:	0007a783          	lw	a5,0(a5)
 52c:	00078513          	mv	a0,a5
 530:	02c12403          	lw	s0,44(sp)
 534:	03010113          	addi	sp,sp,48
 538:	00008067          	ret

0000053c <DM_set_reg>:
 53c:	fd010113          	addi	sp,sp,-48
 540:	02812623          	sw	s0,44(sp)
 544:	03010413          	addi	s0,sp,48
 548:	fca42e23          	sw	a0,-36(s0)
 54c:	fcb42c23          	sw	a1,-40(s0)
 550:	fcc42a23          	sw	a2,-44(s0)
 554:	fdc42703          	lw	a4,-36(s0)
 558:	00100793          	li	a5,1
 55c:	00f71a63          	bne	a4,a5,570 <DM_set_reg+0x34>
 560:	000087b7          	lui	a5,0x8
 564:	01878793          	addi	a5,a5,24 # 8018 <_bss_end+0x3017>
 568:	fef42623          	sw	a5,-20(s0)
 56c:	0100006f          	j	57c <DM_set_reg+0x40>
 570:	000087b7          	lui	a5,0x8
 574:	11878793          	addi	a5,a5,280 # 8118 <_bss_end+0x3117>
 578:	fef42623          	sw	a5,-20(s0)
 57c:	fdc42703          	lw	a4,-36(s0)
 580:	00100793          	li	a5,1
 584:	00f71a63          	bne	a4,a5,598 <DM_set_reg+0x5c>
 588:	000087b7          	lui	a5,0x8
 58c:	01c78793          	addi	a5,a5,28 # 801c <_bss_end+0x301b>
 590:	fef42423          	sw	a5,-24(s0)
 594:	0100006f          	j	5a4 <DM_set_reg+0x68>
 598:	000087b7          	lui	a5,0x8
 59c:	11c78793          	addi	a5,a5,284 # 811c <_bss_end+0x311b>
 5a0:	fef42423          	sw	a5,-24(s0)
 5a4:	fd442703          	lw	a4,-44(s0)
 5a8:	fe842783          	lw	a5,-24(s0)
 5ac:	00e7a023          	sw	a4,0(a5)
 5b0:	fd842703          	lw	a4,-40(s0)
 5b4:	fec42783          	lw	a5,-20(s0)
 5b8:	00e7a023          	sw	a4,0(a5)
 5bc:	00000013          	nop
 5c0:	02c12403          	lw	s0,44(sp)
 5c4:	03010113          	addi	sp,sp,48
 5c8:	00008067          	ret

000005cc <DM_busy>:
 5cc:	fd010113          	addi	sp,sp,-48
 5d0:	02812623          	sw	s0,44(sp)
 5d4:	03010413          	addi	s0,sp,48
 5d8:	fca42e23          	sw	a0,-36(s0)
 5dc:	fdc42703          	lw	a4,-36(s0)
 5e0:	00100793          	li	a5,1
 5e4:	00f71a63          	bne	a4,a5,5f8 <DM_busy+0x2c>
 5e8:	000087b7          	lui	a5,0x8
 5ec:	02478793          	addi	a5,a5,36 # 8024 <_bss_end+0x3023>
 5f0:	fef42623          	sw	a5,-20(s0)
 5f4:	0100006f          	j	604 <DM_busy+0x38>
 5f8:	000087b7          	lui	a5,0x8
 5fc:	12478793          	addi	a5,a5,292 # 8124 <_bss_end+0x3123>
 600:	fef42623          	sw	a5,-20(s0)
 604:	fec42783          	lw	a5,-20(s0)
 608:	0007a783          	lw	a5,0(a5)
 60c:	00078513          	mv	a0,a5
 610:	02c12403          	lw	s0,44(sp)
 614:	03010113          	addi	sp,sp,48
 618:	00008067          	ret

0000061c <DM_get_reg>:
 61c:	fd010113          	addi	sp,sp,-48
 620:	02112623          	sw	ra,44(sp)
 624:	02812423          	sw	s0,40(sp)
 628:	03010413          	addi	s0,sp,48
 62c:	fca42e23          	sw	a0,-36(s0)
 630:	fcb42c23          	sw	a1,-40(s0)
 634:	fdc42703          	lw	a4,-36(s0)
 638:	00100793          	li	a5,1
 63c:	00f71a63          	bne	a4,a5,650 <DM_get_reg+0x34>
 640:	000087b7          	lui	a5,0x8
 644:	01878793          	addi	a5,a5,24 # 8018 <_bss_end+0x3017>
 648:	fef42423          	sw	a5,-24(s0)
 64c:	0100006f          	j	65c <DM_get_reg+0x40>
 650:	000087b7          	lui	a5,0x8
 654:	11878793          	addi	a5,a5,280 # 8118 <_bss_end+0x3117>
 658:	fef42423          	sw	a5,-24(s0)
 65c:	fdc42503          	lw	a0,-36(s0)
 660:	f6dff0ef          	jal	ra,5cc <DM_busy>
 664:	00050793          	mv	a5,a0
 668:	00078463          	beqz	a5,670 <DM_get_reg+0x54>
 66c:	ff1ff06f          	j	65c <DM_get_reg+0x40>
 670:	00000013          	nop
 674:	fdc42703          	lw	a4,-36(s0)
 678:	00100793          	li	a5,1
 67c:	00f71a63          	bne	a4,a5,690 <DM_get_reg+0x74>
 680:	000087b7          	lui	a5,0x8
 684:	02078793          	addi	a5,a5,32 # 8020 <_bss_end+0x301f>
 688:	fef42623          	sw	a5,-20(s0)
 68c:	0100006f          	j	69c <DM_get_reg+0x80>
 690:	000087b7          	lui	a5,0x8
 694:	12078793          	addi	a5,a5,288 # 8120 <_bss_end+0x311f>
 698:	fef42623          	sw	a5,-20(s0)
 69c:	fec42783          	lw	a5,-20(s0)
 6a0:	0007a783          	lw	a5,0(a5)
 6a4:	00078513          	mv	a0,a5
 6a8:	02c12083          	lw	ra,44(sp)
 6ac:	02812403          	lw	s0,40(sp)
 6b0:	03010113          	addi	sp,sp,48
 6b4:	00008067          	ret

000006b8 <bootloader>:
 6b8:	fd010113          	addi	sp,sp,-48
 6bc:	02112623          	sw	ra,44(sp)
 6c0:	02812423          	sw	s0,40(sp)
 6c4:	02912223          	sw	s1,36(sp)
 6c8:	03010413          	addi	s0,sp,48
 6cc:	000017b7          	lui	a5,0x1
 6d0:	87478793          	addi	a5,a5,-1932 # 874 <main>
 6d4:	fef42423          	sw	a5,-24(s0)
 6d8:	a2dff0ef          	jal	ra,104 <UART_check>
 6dc:	00050793          	mv	a5,a0
 6e0:	00079463          	bnez	a5,6e8 <bootloader+0x30>
 6e4:	ff5ff06f          	j	6d8 <bootloader+0x20>
 6e8:	00000013          	nop
 6ec:	949ff0ef          	jal	ra,34 <UART_read_data>
 6f0:	fea42223          	sw	a0,-28(s0)
 6f4:	a11ff0ef          	jal	ra,104 <UART_check>
 6f8:	00050793          	mv	a5,a0
 6fc:	00079463          	bnez	a5,704 <bootloader+0x4c>
 700:	ff5ff06f          	j	6f4 <bootloader+0x3c>
 704:	00000013          	nop
 708:	fe442783          	lw	a5,-28(s0)
 70c:	00879493          	slli	s1,a5,0x8
 710:	925ff0ef          	jal	ra,34 <UART_read_data>
 714:	00050793          	mv	a5,a0
 718:	00f487b3          	add	a5,s1,a5
 71c:	fef42223          	sw	a5,-28(s0)
 720:	9e5ff0ef          	jal	ra,104 <UART_check>
 724:	00050793          	mv	a5,a0
 728:	00079463          	bnez	a5,730 <bootloader+0x78>
 72c:	ff5ff06f          	j	720 <bootloader+0x68>
 730:	00000013          	nop
 734:	fe442783          	lw	a5,-28(s0)
 738:	00879493          	slli	s1,a5,0x8
 73c:	8f9ff0ef          	jal	ra,34 <UART_read_data>
 740:	00050793          	mv	a5,a0
 744:	00f487b3          	add	a5,s1,a5
 748:	fef42223          	sw	a5,-28(s0)
 74c:	9b9ff0ef          	jal	ra,104 <UART_check>
 750:	00050793          	mv	a5,a0
 754:	00079463          	bnez	a5,75c <bootloader+0xa4>
 758:	ff5ff06f          	j	74c <bootloader+0x94>
 75c:	00000013          	nop
 760:	fe442783          	lw	a5,-28(s0)
 764:	00879493          	slli	s1,a5,0x8
 768:	8cdff0ef          	jal	ra,34 <UART_read_data>
 76c:	00050793          	mv	a5,a0
 770:	00f487b3          	add	a5,s1,a5
 774:	fef42223          	sw	a5,-28(s0)
 778:	fe842783          	lw	a5,-24(s0)
 77c:	fef42623          	sw	a5,-20(s0)
 780:	0c40006f          	j	844 <bootloader+0x18c>
 784:	fec42783          	lw	a5,-20(s0)
 788:	fef42023          	sw	a5,-32(s0)
 78c:	979ff0ef          	jal	ra,104 <UART_check>
 790:	00050793          	mv	a5,a0
 794:	00079463          	bnez	a5,79c <bootloader+0xe4>
 798:	ff5ff06f          	j	78c <bootloader+0xd4>
 79c:	00000013          	nop
 7a0:	895ff0ef          	jal	ra,34 <UART_read_data>
 7a4:	fca42e23          	sw	a0,-36(s0)
 7a8:	95dff0ef          	jal	ra,104 <UART_check>
 7ac:	00050793          	mv	a5,a0
 7b0:	00079463          	bnez	a5,7b8 <bootloader+0x100>
 7b4:	ff5ff06f          	j	7a8 <bootloader+0xf0>
 7b8:	00000013          	nop
 7bc:	fdc42783          	lw	a5,-36(s0)
 7c0:	00879493          	slli	s1,a5,0x8
 7c4:	871ff0ef          	jal	ra,34 <UART_read_data>
 7c8:	00050793          	mv	a5,a0
 7cc:	00f487b3          	add	a5,s1,a5
 7d0:	fcf42e23          	sw	a5,-36(s0)
 7d4:	931ff0ef          	jal	ra,104 <UART_check>
 7d8:	00050793          	mv	a5,a0
 7dc:	00079463          	bnez	a5,7e4 <bootloader+0x12c>
 7e0:	ff5ff06f          	j	7d4 <bootloader+0x11c>
 7e4:	00000013          	nop
 7e8:	fdc42783          	lw	a5,-36(s0)
 7ec:	00879493          	slli	s1,a5,0x8
 7f0:	845ff0ef          	jal	ra,34 <UART_read_data>
 7f4:	00050793          	mv	a5,a0
 7f8:	00f487b3          	add	a5,s1,a5
 7fc:	fcf42e23          	sw	a5,-36(s0)
 800:	905ff0ef          	jal	ra,104 <UART_check>
 804:	00050793          	mv	a5,a0
 808:	00079463          	bnez	a5,810 <bootloader+0x158>
 80c:	ff5ff06f          	j	800 <bootloader+0x148>
 810:	00000013          	nop
 814:	fdc42783          	lw	a5,-36(s0)
 818:	00879493          	slli	s1,a5,0x8
 81c:	819ff0ef          	jal	ra,34 <UART_read_data>
 820:	00050793          	mv	a5,a0
 824:	00f487b3          	add	a5,s1,a5
 828:	fcf42e23          	sw	a5,-36(s0)
 82c:	fe042783          	lw	a5,-32(s0)
 830:	fdc42703          	lw	a4,-36(s0)
 834:	00e7a023          	sw	a4,0(a5)
 838:	fec42783          	lw	a5,-20(s0)
 83c:	00478793          	addi	a5,a5,4
 840:	fef42623          	sw	a5,-20(s0)
 844:	fe442703          	lw	a4,-28(s0)
 848:	fe842783          	lw	a5,-24(s0)
 84c:	00f707b3          	add	a5,a4,a5
 850:	fec42703          	lw	a4,-20(s0)
 854:	f2e7d8e3          	bge	a5,a4,784 <bootloader+0xcc>
 858:	01c0006f          	j	874 <main>
 85c:	00000013          	nop
 860:	02c12083          	lw	ra,44(sp)
 864:	02812403          	lw	s0,40(sp)
 868:	02412483          	lw	s1,36(sp)
 86c:	03010113          	addi	sp,sp,48
 870:	00008067          	ret

00000874 <main>:
 874:	ff010113          	addi	sp,sp,-16
 878:	00112623          	sw	ra,12(sp)
 87c:	00812423          	sw	s0,8(sp)
 880:	01010413          	addi	s0,sp,16
 884:	0000b7b7          	lui	a5,0xb
 888:	bcd78613          	addi	a2,a5,-1075 # abcd <_bss_end+0x5bcc>
 88c:	1aa00593          	li	a1,426
 890:	00100513          	li	a0,1
 894:	ca9ff0ef          	jal	ra,53c <DM_set_reg>
 898:	00000013          	nop
 89c:	00078513          	mv	a0,a5
 8a0:	00c12083          	lw	ra,12(sp)
 8a4:	00812403          	lw	s0,8(sp)
 8a8:	01010113          	addi	sp,sp,16
 8ac:	00008067          	ret

Disassembly of section .sdata:

00005000 <byte>:
    5000:	37    	Address 0x0000000000005000 is out of bounds.

    5004:	 

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	fmsub.d	ft6,ft6,ft4,ft7,rmm
   4:	2820                	fld	fs0,80(s0)
   6:	29554e47          	fmsub.s	ft8,fa0,fs5,ft5,rmm
   a:	3920                	fld	fs0,112(a0)
   c:	322e                	fld	ft4,232(sp)
   e:	302e                	fld	ft0,232(sp)
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	1b41                	addi	s6,s6,-16
   2:	0000                	unimp
   4:	7200                	flw	fs0,32(a2)
   6:	7369                	lui	t1,0xffffa
   8:	01007663          	bgeu	zero,a6,14 <UART_check_busy+0x10>
   c:	0011                	c.nop	4
   e:	0000                	unimp
  10:	1004                	addi	s1,sp,32
  12:	7205                	lui	tp,0xfffe1
  14:	3376                	fld	ft6,376(sp)
  16:	6932                	flw	fs2,12(sp)
  18:	7032                	flw	ft0,44(sp)
  1a:	0030                	addi	a2,sp,8
