
main.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <UART_check_busy-0x4>:
   0:	1490006f          	j	948 <main>

00000004 <UART_check_busy>:
   4:	fe010113          	addi	sp,sp,-32
   8:	00812e23          	sw	s0,28(sp)
   c:	02010413          	addi	s0,sp,32
  10:	000087b7          	lui	a5,0x8
  14:	20878793          	addi	a5,a5,520 # 8208 <A+0x2208>
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
  44:	20078793          	addi	a5,a5,512 # 8200 <A+0x2200>
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
  78:	20478793          	addi	a5,a5,516 # 8204 <A+0x2204>
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
  b0:	20478793          	addi	a5,a5,516 # 8204 <A+0x2204>
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
 114:	20c78793          	addi	a5,a5,524 # 820c <A+0x220c>
 118:	fef42623          	sw	a5,-20(s0)
 11c:	fec42783          	lw	a5,-20(s0)
 120:	0007a783          	lw	a5,0(a5)
 124:	00078513          	mv	a0,a5
 128:	01c12403          	lw	s0,28(sp)
 12c:	02010113          	addi	sp,sp,32
 130:	00008067          	ret

00000134 <copy_array>:
 134:	fd010113          	addi	sp,sp,-48
 138:	02812623          	sw	s0,44(sp)
 13c:	03010413          	addi	s0,sp,48
 140:	fca42e23          	sw	a0,-36(s0)
 144:	fcb42c23          	sw	a1,-40(s0)
 148:	fcc42a23          	sw	a2,-44(s0)
 14c:	fcd42823          	sw	a3,-48(s0)
 150:	fd442783          	lw	a5,-44(s0)
 154:	fef42623          	sw	a5,-20(s0)
 158:	0400006f          	j	198 <copy_array+0x64>
 15c:	fec42703          	lw	a4,-20(s0)
 160:	fd442783          	lw	a5,-44(s0)
 164:	40f707b3          	sub	a5,a4,a5
 168:	00279793          	slli	a5,a5,0x2
 16c:	fdc42703          	lw	a4,-36(s0)
 170:	00f70733          	add	a4,a4,a5
 174:	fec42783          	lw	a5,-20(s0)
 178:	00279793          	slli	a5,a5,0x2
 17c:	fd842683          	lw	a3,-40(s0)
 180:	00f687b3          	add	a5,a3,a5
 184:	00072703          	lw	a4,0(a4)
 188:	00e7a023          	sw	a4,0(a5)
 18c:	fec42783          	lw	a5,-20(s0)
 190:	00178793          	addi	a5,a5,1
 194:	fef42623          	sw	a5,-20(s0)
 198:	fec42703          	lw	a4,-20(s0)
 19c:	fd042783          	lw	a5,-48(s0)
 1a0:	fae7dee3          	bge	a5,a4,15c <copy_array+0x28>
 1a4:	00000013          	nop
 1a8:	02c12403          	lw	s0,44(sp)
 1ac:	03010113          	addi	sp,sp,48
 1b0:	00008067          	ret

000001b4 <delay_ms>:
 1b4:	fd010113          	addi	sp,sp,-48
 1b8:	02812623          	sw	s0,44(sp)
 1bc:	03010413          	addi	s0,sp,48
 1c0:	fca42e23          	sw	a0,-36(s0)
 1c4:	fdc42703          	lw	a4,-36(s0)
 1c8:	00070793          	mv	a5,a4
 1cc:	00579793          	slli	a5,a5,0x5
 1d0:	40e787b3          	sub	a5,a5,a4
 1d4:	00279793          	slli	a5,a5,0x2
 1d8:	40e787b3          	sub	a5,a5,a4
 1dc:	00279793          	slli	a5,a5,0x2
 1e0:	40e787b3          	sub	a5,a5,a4
 1e4:	00179793          	slli	a5,a5,0x1
 1e8:	fef42423          	sw	a5,-24(s0)
 1ec:	fe042623          	sw	zero,-20(s0)
 1f0:	0100006f          	j	200 <delay_ms+0x4c>
 1f4:	fec42783          	lw	a5,-20(s0)
 1f8:	00178793          	addi	a5,a5,1
 1fc:	fef42623          	sw	a5,-20(s0)
 200:	fec42703          	lw	a4,-20(s0)
 204:	fe842783          	lw	a5,-24(s0)
 208:	fef746e3          	blt	a4,a5,1f4 <delay_ms+0x40>
 20c:	00000013          	nop
 210:	02c12403          	lw	s0,44(sp)
 214:	03010113          	addi	sp,sp,48
 218:	00008067          	ret

0000021c <delay_us>:
 21c:	fd010113          	addi	sp,sp,-48
 220:	02812623          	sw	s0,44(sp)
 224:	03010413          	addi	s0,sp,48
 228:	fca42e23          	sw	a0,-36(s0)
 22c:	fdc42783          	lw	a5,-36(s0)
 230:	00179793          	slli	a5,a5,0x1
 234:	fef42423          	sw	a5,-24(s0)
 238:	fe042623          	sw	zero,-20(s0)
 23c:	0100006f          	j	24c <delay_us+0x30>
 240:	fec42783          	lw	a5,-20(s0)
 244:	00178793          	addi	a5,a5,1
 248:	fef42623          	sw	a5,-20(s0)
 24c:	fec42703          	lw	a4,-20(s0)
 250:	fe842783          	lw	a5,-24(s0)
 254:	fef746e3          	blt	a4,a5,240 <delay_us+0x24>
 258:	00000013          	nop
 25c:	02c12403          	lw	s0,44(sp)
 260:	03010113          	addi	sp,sp,48
 264:	00008067          	ret

00000268 <delay>:
 268:	fd010113          	addi	sp,sp,-48
 26c:	02812623          	sw	s0,44(sp)
 270:	03010413          	addi	s0,sp,48
 274:	fca42e23          	sw	a0,-36(s0)
 278:	fe042623          	sw	zero,-20(s0)
 27c:	0100006f          	j	28c <delay+0x24>
 280:	fec42783          	lw	a5,-20(s0)
 284:	00178793          	addi	a5,a5,1
 288:	fef42623          	sw	a5,-20(s0)
 28c:	fec42703          	lw	a4,-20(s0)
 290:	fdc42783          	lw	a5,-36(s0)
 294:	fef746e3          	blt	a4,a5,280 <delay+0x18>
 298:	00000013          	nop
 29c:	02c12403          	lw	s0,44(sp)
 2a0:	03010113          	addi	sp,sp,48
 2a4:	00008067          	ret

000002a8 <set_led>:
 2a8:	fd010113          	addi	sp,sp,-48
 2ac:	02812623          	sw	s0,44(sp)
 2b0:	03010413          	addi	s0,sp,48
 2b4:	fca42e23          	sw	a0,-36(s0)
 2b8:	000087b7          	lui	a5,0x8
 2bc:	30078793          	addi	a5,a5,768 # 8300 <A+0x2300>
 2c0:	fef42623          	sw	a5,-20(s0)
 2c4:	fec42783          	lw	a5,-20(s0)
 2c8:	fdc42703          	lw	a4,-36(s0)
 2cc:	00e7a023          	sw	a4,0(a5)
 2d0:	00000013          	nop
 2d4:	02c12403          	lw	s0,44(sp)
 2d8:	03010113          	addi	sp,sp,48
 2dc:	00008067          	ret

000002e0 <ETHERNET_send_data>:
 2e0:	fd010113          	addi	sp,sp,-48
 2e4:	02812623          	sw	s0,44(sp)
 2e8:	03010413          	addi	s0,sp,48
 2ec:	fca42e23          	sw	a0,-36(s0)
 2f0:	fcb42c23          	sw	a1,-40(s0)
 2f4:	fcc42a23          	sw	a2,-44(s0)
 2f8:	fdc42703          	lw	a4,-36(s0)
 2fc:	00100793          	li	a5,1
 300:	00f71863          	bne	a4,a5,310 <ETHERNET_send_data+0x30>
 304:	000087b7          	lui	a5,0x8
 308:	fef42623          	sw	a5,-20(s0)
 30c:	0100006f          	j	31c <ETHERNET_send_data+0x3c>
 310:	000087b7          	lui	a5,0x8
 314:	10078793          	addi	a5,a5,256 # 8100 <A+0x2100>
 318:	fef42623          	sw	a5,-20(s0)
 31c:	a0a017b7          	lui	a5,0xa0a01
 320:	b0878793          	addi	a5,a5,-1272 # a0a00b08 <A+0xa09fab08>
 324:	fef42223          	sw	a5,-28(s0)
 328:	fe442783          	lw	a5,-28(s0)
 32c:	04000713          	li	a4,64
 330:	00e7a023          	sw	a4,0(a5)
 334:	fd442783          	lw	a5,-44(s0)
 338:	0027d793          	srli	a5,a5,0x2
 33c:	fef42023          	sw	a5,-32(s0)
 340:	fe042423          	sw	zero,-24(s0)
 344:	0600006f          	j	3a4 <ETHERNET_send_data+0xc4>
 348:	fe842703          	lw	a4,-24(s0)
 34c:	fe042783          	lw	a5,-32(s0)
 350:	02f71463          	bne	a4,a5,378 <ETHERNET_send_data+0x98>
 354:	fe842783          	lw	a5,-24(s0)
 358:	00279793          	slli	a5,a5,0x2
 35c:	fd842703          	lw	a4,-40(s0)
 360:	00f707b3          	add	a5,a4,a5
 364:	0007a783          	lw	a5,0(a5)
 368:	00078713          	mv	a4,a5
 36c:	fe442783          	lw	a5,-28(s0)
 370:	00e7a023          	sw	a4,0(a5)
 374:	0240006f          	j	398 <ETHERNET_send_data+0xb8>
 378:	fe842783          	lw	a5,-24(s0)
 37c:	00279793          	slli	a5,a5,0x2
 380:	fd842703          	lw	a4,-40(s0)
 384:	00f707b3          	add	a5,a4,a5
 388:	0007a783          	lw	a5,0(a5)
 38c:	00078713          	mv	a4,a5
 390:	fec42783          	lw	a5,-20(s0)
 394:	00e7a023          	sw	a4,0(a5)
 398:	fe842783          	lw	a5,-24(s0)
 39c:	00178793          	addi	a5,a5,1
 3a0:	fef42423          	sw	a5,-24(s0)
 3a4:	fe842703          	lw	a4,-24(s0)
 3a8:	fe042783          	lw	a5,-32(s0)
 3ac:	f8e7dee3          	bge	a5,a4,348 <ETHERNET_send_data+0x68>
 3b0:	00000013          	nop
 3b4:	02c12403          	lw	s0,44(sp)
 3b8:	03010113          	addi	sp,sp,48
 3bc:	00008067          	ret

000003c0 <ETHERNET_read_data>:
 3c0:	fc010113          	addi	sp,sp,-64
 3c4:	02812e23          	sw	s0,60(sp)
 3c8:	04010413          	addi	s0,sp,64
 3cc:	fca42623          	sw	a0,-52(s0)
 3d0:	fcb42423          	sw	a1,-56(s0)
 3d4:	fcc42703          	lw	a4,-52(s0)
 3d8:	00100793          	li	a5,1
 3dc:	00f71a63          	bne	a4,a5,3f0 <ETHERNET_read_data+0x30>
 3e0:	000087b7          	lui	a5,0x8
 3e4:	00878793          	addi	a5,a5,8 # 8008 <A+0x2008>
 3e8:	fef42623          	sw	a5,-20(s0)
 3ec:	0100006f          	j	3fc <ETHERNET_read_data+0x3c>
 3f0:	000087b7          	lui	a5,0x8
 3f4:	10878793          	addi	a5,a5,264 # 8108 <A+0x2108>
 3f8:	fef42623          	sw	a5,-20(s0)
 3fc:	a0a017b7          	lui	a5,0xa0a01
 400:	b0878793          	addi	a5,a5,-1272 # a0a00b08 <A+0xa09fab08>
 404:	fef42223          	sw	a5,-28(s0)
 408:	fe442783          	lw	a5,-28(s0)
 40c:	0007a783          	lw	a5,0(a5)
 410:	fef42023          	sw	a5,-32(s0)
 414:	fe042423          	sw	zero,-24(s0)
 418:	fec42783          	lw	a5,-20(s0)
 41c:	0007a783          	lw	a5,0(a5)
 420:	fcf42e23          	sw	a5,-36(s0)
 424:	fdc42703          	lw	a4,-36(s0)
 428:	a0a017b7          	lui	a5,0xa0a01
 42c:	b0878793          	addi	a5,a5,-1272 # a0a00b08 <A+0xa09fab08>
 430:	02f70663          	beq	a4,a5,45c <ETHERNET_read_data+0x9c>
 434:	fe842783          	lw	a5,-24(s0)
 438:	00279793          	slli	a5,a5,0x2
 43c:	fc842703          	lw	a4,-56(s0)
 440:	00f707b3          	add	a5,a4,a5
 444:	fdc42703          	lw	a4,-36(s0)
 448:	00e7a023          	sw	a4,0(a5)
 44c:	fe842783          	lw	a5,-24(s0)
 450:	00178793          	addi	a5,a5,1
 454:	fef42423          	sw	a5,-24(s0)
 458:	fc1ff06f          	j	418 <ETHERNET_read_data+0x58>
 45c:	00000013          	nop
 460:	03c12403          	lw	s0,60(sp)
 464:	04010113          	addi	sp,sp,64
 468:	00008067          	ret

0000046c <ETHERNET_check_done>:
 46c:	fd010113          	addi	sp,sp,-48
 470:	02812623          	sw	s0,44(sp)
 474:	03010413          	addi	s0,sp,48
 478:	fca42e23          	sw	a0,-36(s0)
 47c:	fdc42703          	lw	a4,-36(s0)
 480:	00100793          	li	a5,1
 484:	00f71a63          	bne	a4,a5,498 <ETHERNET_check_done+0x2c>
 488:	000087b7          	lui	a5,0x8
 48c:	00478793          	addi	a5,a5,4 # 8004 <A+0x2004>
 490:	fef42623          	sw	a5,-20(s0)
 494:	0100006f          	j	4a4 <ETHERNET_check_done+0x38>
 498:	000087b7          	lui	a5,0x8
 49c:	10478793          	addi	a5,a5,260 # 8104 <A+0x2104>
 4a0:	fef42623          	sw	a5,-20(s0)
 4a4:	fec42783          	lw	a5,-20(s0)
 4a8:	0007a783          	lw	a5,0(a5)
 4ac:	0ff7f793          	andi	a5,a5,255
 4b0:	00078513          	mv	a0,a5
 4b4:	02c12403          	lw	s0,44(sp)
 4b8:	03010113          	addi	sp,sp,48
 4bc:	00008067          	ret

000004c0 <ETHERNET_data_count>:
 4c0:	fd010113          	addi	sp,sp,-48
 4c4:	02812623          	sw	s0,44(sp)
 4c8:	03010413          	addi	s0,sp,48
 4cc:	fca42e23          	sw	a0,-36(s0)
 4d0:	fdc42703          	lw	a4,-36(s0)
 4d4:	00100793          	li	a5,1
 4d8:	00f71a63          	bne	a4,a5,4ec <ETHERNET_data_count+0x2c>
 4dc:	000087b7          	lui	a5,0x8
 4e0:	01078793          	addi	a5,a5,16 # 8010 <A+0x2010>
 4e4:	fef42623          	sw	a5,-20(s0)
 4e8:	0100006f          	j	4f8 <ETHERNET_data_count+0x38>
 4ec:	000087b7          	lui	a5,0x8
 4f0:	11078793          	addi	a5,a5,272 # 8110 <A+0x2110>
 4f4:	fef42623          	sw	a5,-20(s0)
 4f8:	fec42783          	lw	a5,-20(s0)
 4fc:	0007a783          	lw	a5,0(a5)
 500:	00078513          	mv	a0,a5
 504:	02c12403          	lw	s0,44(sp)
 508:	03010113          	addi	sp,sp,48
 50c:	00008067          	ret

00000510 <ETHERNET_protocol>:
 510:	fd010113          	addi	sp,sp,-48
 514:	02812623          	sw	s0,44(sp)
 518:	03010413          	addi	s0,sp,48
 51c:	fca42e23          	sw	a0,-36(s0)
 520:	fdc42703          	lw	a4,-36(s0)
 524:	00100793          	li	a5,1
 528:	00f71a63          	bne	a4,a5,53c <ETHERNET_protocol+0x2c>
 52c:	000087b7          	lui	a5,0x8
 530:	01478793          	addi	a5,a5,20 # 8014 <A+0x2014>
 534:	fef42623          	sw	a5,-20(s0)
 538:	0100006f          	j	548 <ETHERNET_protocol+0x38>
 53c:	000087b7          	lui	a5,0x8
 540:	11478793          	addi	a5,a5,276 # 8114 <A+0x2114>
 544:	fef42623          	sw	a5,-20(s0)
 548:	fec42783          	lw	a5,-20(s0)
 54c:	0007a783          	lw	a5,0(a5)
 550:	00078513          	mv	a0,a5
 554:	02c12403          	lw	s0,44(sp)
 558:	03010113          	addi	sp,sp,48
 55c:	00008067          	ret

00000560 <ETHERNET_rx_ready>:
 560:	fd010113          	addi	sp,sp,-48
 564:	02812623          	sw	s0,44(sp)
 568:	03010413          	addi	s0,sp,48
 56c:	fca42e23          	sw	a0,-36(s0)
 570:	fdc42703          	lw	a4,-36(s0)
 574:	00100793          	li	a5,1
 578:	00f71a63          	bne	a4,a5,58c <ETHERNET_rx_ready+0x2c>
 57c:	000087b7          	lui	a5,0x8
 580:	00c78793          	addi	a5,a5,12 # 800c <A+0x200c>
 584:	fef42623          	sw	a5,-20(s0)
 588:	0100006f          	j	598 <ETHERNET_rx_ready+0x38>
 58c:	000087b7          	lui	a5,0x8
 590:	10c78793          	addi	a5,a5,268 # 810c <A+0x210c>
 594:	fef42623          	sw	a5,-20(s0)
 598:	fec42783          	lw	a5,-20(s0)
 59c:	0007a783          	lw	a5,0(a5)
 5a0:	0ff7f793          	andi	a5,a5,255
 5a4:	00078513          	mv	a0,a5
 5a8:	02c12403          	lw	s0,44(sp)
 5ac:	03010113          	addi	sp,sp,48
 5b0:	00008067          	ret

000005b4 <ETHERNET_set_RX_mode>:
 5b4:	fd010113          	addi	sp,sp,-48
 5b8:	02812623          	sw	s0,44(sp)
 5bc:	03010413          	addi	s0,sp,48
 5c0:	fca42e23          	sw	a0,-36(s0)
 5c4:	fcb42c23          	sw	a1,-40(s0)
 5c8:	fdc42703          	lw	a4,-36(s0)
 5cc:	00100793          	li	a5,1
 5d0:	00f71a63          	bne	a4,a5,5e4 <ETHERNET_set_RX_mode+0x30>
 5d4:	000087b7          	lui	a5,0x8
 5d8:	02878793          	addi	a5,a5,40 # 8028 <A+0x2028>
 5dc:	fef42623          	sw	a5,-20(s0)
 5e0:	0100006f          	j	5f0 <ETHERNET_set_RX_mode+0x3c>
 5e4:	000087b7          	lui	a5,0x8
 5e8:	12878793          	addi	a5,a5,296 # 8128 <A+0x2128>
 5ec:	fef42623          	sw	a5,-20(s0)
 5f0:	fd842703          	lw	a4,-40(s0)
 5f4:	fec42783          	lw	a5,-20(s0)
 5f8:	00e7a023          	sw	a4,0(a5)
 5fc:	00000013          	nop
 600:	02c12403          	lw	s0,44(sp)
 604:	03010113          	addi	sp,sp,48
 608:	00008067          	ret

0000060c <DM_set_reg>:
 60c:	fd010113          	addi	sp,sp,-48
 610:	02812623          	sw	s0,44(sp)
 614:	03010413          	addi	s0,sp,48
 618:	fca42e23          	sw	a0,-36(s0)
 61c:	fcb42c23          	sw	a1,-40(s0)
 620:	fcc42a23          	sw	a2,-44(s0)
 624:	fdc42703          	lw	a4,-36(s0)
 628:	00100793          	li	a5,1
 62c:	00f71a63          	bne	a4,a5,640 <DM_set_reg+0x34>
 630:	000087b7          	lui	a5,0x8
 634:	01878793          	addi	a5,a5,24 # 8018 <A+0x2018>
 638:	fef42623          	sw	a5,-20(s0)
 63c:	0100006f          	j	64c <DM_set_reg+0x40>
 640:	000087b7          	lui	a5,0x8
 644:	11878793          	addi	a5,a5,280 # 8118 <A+0x2118>
 648:	fef42623          	sw	a5,-20(s0)
 64c:	fdc42703          	lw	a4,-36(s0)
 650:	00100793          	li	a5,1
 654:	00f71a63          	bne	a4,a5,668 <DM_set_reg+0x5c>
 658:	000087b7          	lui	a5,0x8
 65c:	01c78793          	addi	a5,a5,28 # 801c <A+0x201c>
 660:	fef42423          	sw	a5,-24(s0)
 664:	0100006f          	j	674 <DM_set_reg+0x68>
 668:	000087b7          	lui	a5,0x8
 66c:	11c78793          	addi	a5,a5,284 # 811c <A+0x211c>
 670:	fef42423          	sw	a5,-24(s0)
 674:	fd442703          	lw	a4,-44(s0)
 678:	fe842783          	lw	a5,-24(s0)
 67c:	00e7a023          	sw	a4,0(a5)
 680:	fd842703          	lw	a4,-40(s0)
 684:	fec42783          	lw	a5,-20(s0)
 688:	00e7a023          	sw	a4,0(a5)
 68c:	00000013          	nop
 690:	02c12403          	lw	s0,44(sp)
 694:	03010113          	addi	sp,sp,48
 698:	00008067          	ret

0000069c <DM_busy>:
 69c:	fd010113          	addi	sp,sp,-48
 6a0:	02812623          	sw	s0,44(sp)
 6a4:	03010413          	addi	s0,sp,48
 6a8:	fca42e23          	sw	a0,-36(s0)
 6ac:	fdc42703          	lw	a4,-36(s0)
 6b0:	00100793          	li	a5,1
 6b4:	00f71a63          	bne	a4,a5,6c8 <DM_busy+0x2c>
 6b8:	000087b7          	lui	a5,0x8
 6bc:	02478793          	addi	a5,a5,36 # 8024 <A+0x2024>
 6c0:	fef42623          	sw	a5,-20(s0)
 6c4:	0100006f          	j	6d4 <DM_busy+0x38>
 6c8:	000087b7          	lui	a5,0x8
 6cc:	12478793          	addi	a5,a5,292 # 8124 <A+0x2124>
 6d0:	fef42623          	sw	a5,-20(s0)
 6d4:	fec42783          	lw	a5,-20(s0)
 6d8:	0007a783          	lw	a5,0(a5)
 6dc:	0ff7f793          	andi	a5,a5,255
 6e0:	00078513          	mv	a0,a5
 6e4:	02c12403          	lw	s0,44(sp)
 6e8:	03010113          	addi	sp,sp,48
 6ec:	00008067          	ret

000006f0 <DM_get_reg>:
 6f0:	fd010113          	addi	sp,sp,-48
 6f4:	02112623          	sw	ra,44(sp)
 6f8:	02812423          	sw	s0,40(sp)
 6fc:	03010413          	addi	s0,sp,48
 700:	fca42e23          	sw	a0,-36(s0)
 704:	fcb42c23          	sw	a1,-40(s0)
 708:	fdc42703          	lw	a4,-36(s0)
 70c:	00100793          	li	a5,1
 710:	00f71a63          	bne	a4,a5,724 <DM_get_reg+0x34>
 714:	000087b7          	lui	a5,0x8
 718:	01878793          	addi	a5,a5,24 # 8018 <A+0x2018>
 71c:	fef42423          	sw	a5,-24(s0)
 720:	0100006f          	j	730 <DM_get_reg+0x40>
 724:	000087b7          	lui	a5,0x8
 728:	11878793          	addi	a5,a5,280 # 8118 <A+0x2118>
 72c:	fef42423          	sw	a5,-24(s0)
 730:	fdc42503          	lw	a0,-36(s0)
 734:	f69ff0ef          	jal	ra,69c <DM_busy>
 738:	00050793          	mv	a5,a0
 73c:	00078463          	beqz	a5,744 <DM_get_reg+0x54>
 740:	ff1ff06f          	j	730 <DM_get_reg+0x40>
 744:	00000013          	nop
 748:	fdc42703          	lw	a4,-36(s0)
 74c:	00100793          	li	a5,1
 750:	00f71a63          	bne	a4,a5,764 <DM_get_reg+0x74>
 754:	000087b7          	lui	a5,0x8
 758:	02078793          	addi	a5,a5,32 # 8020 <A+0x2020>
 75c:	fef42623          	sw	a5,-20(s0)
 760:	0100006f          	j	770 <DM_get_reg+0x80>
 764:	000087b7          	lui	a5,0x8
 768:	12078793          	addi	a5,a5,288 # 8120 <A+0x2120>
 76c:	fef42623          	sw	a5,-20(s0)
 770:	fec42783          	lw	a5,-20(s0)
 774:	0007a783          	lw	a5,0(a5)
 778:	00078513          	mv	a0,a5
 77c:	02c12083          	lw	ra,44(sp)
 780:	02812403          	lw	s0,40(sp)
 784:	03010113          	addi	sp,sp,48
 788:	00008067          	ret

0000078c <bootloader>:
 78c:	fd010113          	addi	sp,sp,-48
 790:	02112623          	sw	ra,44(sp)
 794:	02812423          	sw	s0,40(sp)
 798:	02912223          	sw	s1,36(sp)
 79c:	03010413          	addi	s0,sp,48
 7a0:	000017b7          	lui	a5,0x1
 7a4:	94878793          	addi	a5,a5,-1720 # 948 <main>
 7a8:	fef42423          	sw	a5,-24(s0)
 7ac:	959ff0ef          	jal	ra,104 <UART_check>
 7b0:	00050793          	mv	a5,a0
 7b4:	00079463          	bnez	a5,7bc <bootloader+0x30>
 7b8:	ff5ff06f          	j	7ac <bootloader+0x20>
 7bc:	00000013          	nop
 7c0:	875ff0ef          	jal	ra,34 <UART_read_data>
 7c4:	fea42223          	sw	a0,-28(s0)
 7c8:	93dff0ef          	jal	ra,104 <UART_check>
 7cc:	00050793          	mv	a5,a0
 7d0:	00079463          	bnez	a5,7d8 <bootloader+0x4c>
 7d4:	ff5ff06f          	j	7c8 <bootloader+0x3c>
 7d8:	00000013          	nop
 7dc:	fe442783          	lw	a5,-28(s0)
 7e0:	00879493          	slli	s1,a5,0x8
 7e4:	851ff0ef          	jal	ra,34 <UART_read_data>
 7e8:	00050793          	mv	a5,a0
 7ec:	00f487b3          	add	a5,s1,a5
 7f0:	fef42223          	sw	a5,-28(s0)
 7f4:	911ff0ef          	jal	ra,104 <UART_check>
 7f8:	00050793          	mv	a5,a0
 7fc:	00079463          	bnez	a5,804 <bootloader+0x78>
 800:	ff5ff06f          	j	7f4 <bootloader+0x68>
 804:	00000013          	nop
 808:	fe442783          	lw	a5,-28(s0)
 80c:	00879493          	slli	s1,a5,0x8
 810:	825ff0ef          	jal	ra,34 <UART_read_data>
 814:	00050793          	mv	a5,a0
 818:	00f487b3          	add	a5,s1,a5
 81c:	fef42223          	sw	a5,-28(s0)
 820:	8e5ff0ef          	jal	ra,104 <UART_check>
 824:	00050793          	mv	a5,a0
 828:	00079463          	bnez	a5,830 <bootloader+0xa4>
 82c:	ff5ff06f          	j	820 <bootloader+0x94>
 830:	00000013          	nop
 834:	fe442783          	lw	a5,-28(s0)
 838:	00879493          	slli	s1,a5,0x8
 83c:	ff8ff0ef          	jal	ra,34 <UART_read_data>
 840:	00050793          	mv	a5,a0
 844:	00f487b3          	add	a5,s1,a5
 848:	fef42223          	sw	a5,-28(s0)
 84c:	fe842783          	lw	a5,-24(s0)
 850:	fef42623          	sw	a5,-20(s0)
 854:	0c40006f          	j	918 <bootloader+0x18c>
 858:	fec42783          	lw	a5,-20(s0)
 85c:	fef42023          	sw	a5,-32(s0)
 860:	8a5ff0ef          	jal	ra,104 <UART_check>
 864:	00050793          	mv	a5,a0
 868:	00079463          	bnez	a5,870 <bootloader+0xe4>
 86c:	ff5ff06f          	j	860 <bootloader+0xd4>
 870:	00000013          	nop
 874:	fc0ff0ef          	jal	ra,34 <UART_read_data>
 878:	fca42e23          	sw	a0,-36(s0)
 87c:	889ff0ef          	jal	ra,104 <UART_check>
 880:	00050793          	mv	a5,a0
 884:	00079463          	bnez	a5,88c <bootloader+0x100>
 888:	ff5ff06f          	j	87c <bootloader+0xf0>
 88c:	00000013          	nop
 890:	fdc42783          	lw	a5,-36(s0)
 894:	00879493          	slli	s1,a5,0x8
 898:	f9cff0ef          	jal	ra,34 <UART_read_data>
 89c:	00050793          	mv	a5,a0
 8a0:	00f487b3          	add	a5,s1,a5
 8a4:	fcf42e23          	sw	a5,-36(s0)
 8a8:	85dff0ef          	jal	ra,104 <UART_check>
 8ac:	00050793          	mv	a5,a0
 8b0:	00079463          	bnez	a5,8b8 <bootloader+0x12c>
 8b4:	ff5ff06f          	j	8a8 <bootloader+0x11c>
 8b8:	00000013          	nop
 8bc:	fdc42783          	lw	a5,-36(s0)
 8c0:	00879493          	slli	s1,a5,0x8
 8c4:	f70ff0ef          	jal	ra,34 <UART_read_data>
 8c8:	00050793          	mv	a5,a0
 8cc:	00f487b3          	add	a5,s1,a5
 8d0:	fcf42e23          	sw	a5,-36(s0)
 8d4:	831ff0ef          	jal	ra,104 <UART_check>
 8d8:	00050793          	mv	a5,a0
 8dc:	00079463          	bnez	a5,8e4 <bootloader+0x158>
 8e0:	ff5ff06f          	j	8d4 <bootloader+0x148>
 8e4:	00000013          	nop
 8e8:	fdc42783          	lw	a5,-36(s0)
 8ec:	00879493          	slli	s1,a5,0x8
 8f0:	f44ff0ef          	jal	ra,34 <UART_read_data>
 8f4:	00050793          	mv	a5,a0
 8f8:	00f487b3          	add	a5,s1,a5
 8fc:	fcf42e23          	sw	a5,-36(s0)
 900:	fe042783          	lw	a5,-32(s0)
 904:	fdc42703          	lw	a4,-36(s0)
 908:	00e7a023          	sw	a4,0(a5)
 90c:	fec42783          	lw	a5,-20(s0)
 910:	00478793          	addi	a5,a5,4
 914:	fef42623          	sw	a5,-20(s0)
 918:	fe442703          	lw	a4,-28(s0)
 91c:	fe842783          	lw	a5,-24(s0)
 920:	00f707b3          	add	a5,a4,a5
 924:	fec42703          	lw	a4,-20(s0)
 928:	f2e7d8e3          	bge	a5,a4,858 <bootloader+0xcc>
 92c:	01c0006f          	j	948 <main>
 930:	00000013          	nop
 934:	02c12083          	lw	ra,44(sp)
 938:	02812403          	lw	s0,40(sp)
 93c:	02412483          	lw	s1,36(sp)
 940:	03010113          	addi	sp,sp,48
 944:	00008067          	ret

00000948 <main>:
 948:	81010113          	addi	sp,sp,-2032
 94c:	7e112623          	sw	ra,2028(sp)
 950:	7e812423          	sw	s0,2024(sp)
 954:	7f010413          	addi	s0,sp,2032
 958:	c2010113          	addi	sp,sp,-992
 95c:	00100793          	li	a5,1
 960:	fef407a3          	sb	a5,-17(s0)
 964:	000067b7          	lui	a5,0x6
 968:	0007c783          	lbu	a5,0(a5) # 6000 <A>
 96c:	00078513          	mv	a0,a5
 970:	939ff0ef          	jal	ra,2a8 <set_led>
 974:	f90ff0ef          	jal	ra,104 <UART_check>
 978:	00050793          	mv	a5,a0
 97c:	00078863          	beqz	a5,98c <main+0x44>
 980:	eb4ff0ef          	jal	ra,34 <UART_read_data>
 984:	00050793          	mv	a5,a0
 988:	fef407a3          	sb	a5,-17(s0)
 98c:	fef44783          	lbu	a5,-17(s0)
 990:	05700713          	li	a4,87
 994:	06e78663          	beq	a5,a4,a00 <main+0xb8>
 998:	05700713          	li	a4,87
 99c:	02f74063          	blt	a4,a5,9bc <main+0x74>
 9a0:	03800713          	li	a4,56
 9a4:	04e78463          	beq	a5,a4,9ec <main+0xa4>
 9a8:	05600713          	li	a4,86
 9ac:	04e78463          	beq	a5,a4,9f4 <main+0xac>
 9b0:	02000713          	li	a4,32
 9b4:	08e78863          	beq	a5,a4,a44 <main+0xfc>
 9b8:	0940006f          	j	a4c <main+0x104>
 9bc:	08600713          	li	a4,134
 9c0:	06e78a63          	beq	a5,a4,a34 <main+0xec>
 9c4:	08600713          	li	a4,134
 9c8:	00f74863          	blt	a4,a5,9d8 <main+0x90>
 9cc:	08500713          	li	a4,133
 9d0:	04e78a63          	beq	a5,a4,a24 <main+0xdc>
 9d4:	0780006f          	j	a4c <main+0x104>
 9d8:	0a400713          	li	a4,164
 9dc:	02e78863          	beq	a5,a4,a0c <main+0xc4>
 9e0:	0a600713          	li	a4,166
 9e4:	02e78a63          	beq	a5,a4,a18 <main+0xd0>
 9e8:	0640006f          	j	a4c <main+0x104>
 9ec:	da1ff0ef          	jal	ra,78c <bootloader>
 9f0:	0680006f          	j	a58 <main+0x110>
 9f4:	00100513          	li	a0,1
 9f8:	1ec000ef          	jal	ra,be4 <listener_mode>
 9fc:	05c0006f          	j	a58 <main+0x110>
 a00:	00200513          	li	a0,2
 a04:	1e0000ef          	jal	ra,be4 <listener_mode>
 a08:	0500006f          	j	a58 <main+0x110>
 a0c:	00100513          	li	a0,1
 a10:	338000ef          	jal	ra,d48 <send_echo_query>
 a14:	0440006f          	j	a58 <main+0x110>
 a18:	00200513          	li	a0,2
 a1c:	32c000ef          	jal	ra,d48 <send_echo_query>
 a20:	0380006f          	j	a58 <main+0x110>
 a24:	00000593          	li	a1,0
 a28:	00100513          	li	a0,1
 a2c:	b89ff0ef          	jal	ra,5b4 <ETHERNET_set_RX_mode>
 a30:	0280006f          	j	a58 <main+0x110>
 a34:	00100593          	li	a1,1
 a38:	00100513          	li	a0,1
 a3c:	b79ff0ef          	jal	ra,5b4 <ETHERNET_set_RX_mode>
 a40:	0180006f          	j	a58 <main+0x110>
 a44:	250000ef          	jal	ra,c94 <retranslator_mode>
 a48:	0100006f          	j	a58 <main+0x110>
 a4c:	fef44783          	lbu	a5,-17(s0)
 a50:	00078513          	mv	a0,a5
 a54:	855ff0ef          	jal	ra,2a8 <set_led>
 a58:	f1dff06f          	j	974 <main+0x2c>

00000a5c <init_packet>:
 a5c:	fc010113          	addi	sp,sp,-64
 a60:	02112e23          	sw	ra,60(sp)
 a64:	02812c23          	sw	s0,56(sp)
 a68:	04010413          	addi	s0,sp,64
 a6c:	fca42623          	sw	a0,-52(s0)
 a70:	000017b7          	lui	a5,0x1
 a74:	ffc7a703          	lw	a4,-4(a5) # ffc <init_arp+0x290>
 a78:	fee42423          	sw	a4,-24(s0)
 a7c:	ffc78793          	addi	a5,a5,-4
 a80:	0047d783          	lhu	a5,4(a5)
 a84:	fef41623          	sh	a5,-20(s0)
 a88:	000017b7          	lui	a5,0x1
 a8c:	0047a703          	lw	a4,4(a5) # 1004 <init_arp+0x298>
 a90:	fee42023          	sw	a4,-32(s0)
 a94:	00478793          	addi	a5,a5,4
 a98:	0047d783          	lhu	a5,4(a5)
 a9c:	fef41223          	sh	a5,-28(s0)
 aa0:	00800793          	li	a5,8
 aa4:	fcf40e23          	sb	a5,-36(s0)
 aa8:	00600793          	li	a5,6
 aac:	fcf40ea3          	sb	a5,-35(s0)
 ab0:	fcc42783          	lw	a5,-52(s0)
 ab4:	0007a783          	lw	a5,0(a5)
 ab8:	00078713          	mv	a4,a5
 abc:	fe844783          	lbu	a5,-24(s0)
 ac0:	00078593          	mv	a1,a5
 ac4:	00070513          	mv	a0,a4
 ac8:	05c000ef          	jal	ra,b24 <set_destanation_MAC_addr>
 acc:	fcc42783          	lw	a5,-52(s0)
 ad0:	0007a783          	lw	a5,0(a5)
 ad4:	00078713          	mv	a4,a5
 ad8:	fe044783          	lbu	a5,-32(s0)
 adc:	00078593          	mv	a1,a5
 ae0:	00070513          	mv	a0,a4
 ae4:	080000ef          	jal	ra,b64 <set_source_MAC_addr>
 ae8:	fcc42783          	lw	a5,-52(s0)
 aec:	0007a783          	lw	a5,0(a5)
 af0:	00078713          	mv	a4,a5
 af4:	fdc44783          	lbu	a5,-36(s0)
 af8:	00078593          	mv	a1,a5
 afc:	00070513          	mv	a0,a4
 b00:	0a4000ef          	jal	ra,ba4 <set_protocol_type>
 b04:	fcc40793          	addi	a5,s0,-52
 b08:	00078513          	mv	a0,a5
 b0c:	260000ef          	jal	ra,d6c <init_arp>
 b10:	00000013          	nop
 b14:	03c12083          	lw	ra,60(sp)
 b18:	03812403          	lw	s0,56(sp)
 b1c:	04010113          	addi	sp,sp,64
 b20:	00008067          	ret

00000b24 <set_destanation_MAC_addr>:
 b24:	fe010113          	addi	sp,sp,-32
 b28:	00112e23          	sw	ra,28(sp)
 b2c:	00812c23          	sw	s0,24(sp)
 b30:	02010413          	addi	s0,sp,32
 b34:	fea42623          	sw	a0,-20(s0)
 b38:	feb42423          	sw	a1,-24(s0)
 b3c:	00500693          	li	a3,5
 b40:	00000613          	li	a2,0
 b44:	fe842583          	lw	a1,-24(s0)
 b48:	fec42503          	lw	a0,-20(s0)
 b4c:	de8ff0ef          	jal	ra,134 <copy_array>
 b50:	00000013          	nop
 b54:	01c12083          	lw	ra,28(sp)
 b58:	01812403          	lw	s0,24(sp)
 b5c:	02010113          	addi	sp,sp,32
 b60:	00008067          	ret

00000b64 <set_source_MAC_addr>:
 b64:	fe010113          	addi	sp,sp,-32
 b68:	00112e23          	sw	ra,28(sp)
 b6c:	00812c23          	sw	s0,24(sp)
 b70:	02010413          	addi	s0,sp,32
 b74:	fea42623          	sw	a0,-20(s0)
 b78:	feb42423          	sw	a1,-24(s0)
 b7c:	00b00693          	li	a3,11
 b80:	00600613          	li	a2,6
 b84:	fe842583          	lw	a1,-24(s0)
 b88:	fec42503          	lw	a0,-20(s0)
 b8c:	da8ff0ef          	jal	ra,134 <copy_array>
 b90:	00000013          	nop
 b94:	01c12083          	lw	ra,28(sp)
 b98:	01812403          	lw	s0,24(sp)
 b9c:	02010113          	addi	sp,sp,32
 ba0:	00008067          	ret

00000ba4 <set_protocol_type>:
 ba4:	fe010113          	addi	sp,sp,-32
 ba8:	00112e23          	sw	ra,28(sp)
 bac:	00812c23          	sw	s0,24(sp)
 bb0:	02010413          	addi	s0,sp,32
 bb4:	fea42623          	sw	a0,-20(s0)
 bb8:	feb42423          	sw	a1,-24(s0)
 bbc:	00d00693          	li	a3,13
 bc0:	00c00613          	li	a2,12
 bc4:	fe842583          	lw	a1,-24(s0)
 bc8:	fec42503          	lw	a0,-20(s0)
 bcc:	d68ff0ef          	jal	ra,134 <copy_array>
 bd0:	00000013          	nop
 bd4:	01c12083          	lw	ra,28(sp)
 bd8:	01812403          	lw	s0,24(sp)
 bdc:	02010113          	addi	sp,sp,32
 be0:	00008067          	ret

00000be4 <listener_mode>:
 be4:	9f010113          	addi	sp,sp,-1552
 be8:	60112623          	sw	ra,1548(sp)
 bec:	60812423          	sw	s0,1544(sp)
 bf0:	61010413          	addi	s0,sp,1552
 bf4:	00050793          	mv	a5,a0
 bf8:	9ef40fa3          	sb	a5,-1537(s0)
 bfc:	9ff44783          	lbu	a5,-1537(s0)
 c00:	00078513          	mv	a0,a5
 c04:	95dff0ef          	jal	ra,560 <ETHERNET_rx_ready>
 c08:	00050793          	mv	a5,a0
 c0c:	06078a63          	beqz	a5,c80 <listener_mode+0x9c>
 c10:	9ff44783          	lbu	a5,-1537(s0)
 c14:	00078513          	mv	a0,a5
 c18:	8a9ff0ef          	jal	ra,4c0 <ETHERNET_data_count>
 c1c:	fea42423          	sw	a0,-24(s0)
 c20:	a0c40793          	addi	a5,s0,-1524
 c24:	00078593          	mv	a1,a5
 c28:	00100513          	li	a0,1
 c2c:	f94ff0ef          	jal	ra,3c0 <ETHERNET_read_data>
 c30:	fe042623          	sw	zero,-20(s0)
 c34:	03c0006f          	j	c70 <listener_mode+0x8c>
 c38:	00000013          	nop
 c3c:	bc8ff0ef          	jal	ra,4 <UART_check_busy>
 c40:	00050793          	mv	a5,a0
 c44:	fe079ce3          	bnez	a5,c3c <listener_mode+0x58>
 c48:	fec42783          	lw	a5,-20(s0)
 c4c:	00279793          	slli	a5,a5,0x2
 c50:	ff040713          	addi	a4,s0,-16
 c54:	00f707b3          	add	a5,a4,a5
 c58:	a1c7a783          	lw	a5,-1508(a5)
 c5c:	00078513          	mv	a0,a5
 c60:	c3cff0ef          	jal	ra,9c <UART_send_word>
 c64:	fec42783          	lw	a5,-20(s0)
 c68:	00178793          	addi	a5,a5,1
 c6c:	fef42623          	sw	a5,-20(s0)
 c70:	fe842783          	lw	a5,-24(s0)
 c74:	4027d793          	srai	a5,a5,0x2
 c78:	fec42703          	lw	a4,-20(s0)
 c7c:	faf74ee3          	blt	a4,a5,c38 <listener_mode+0x54>
 c80:	00000013          	nop
 c84:	60c12083          	lw	ra,1548(sp)
 c88:	60812403          	lw	s0,1544(sp)
 c8c:	61010113          	addi	sp,sp,1552
 c90:	00008067          	ret

00000c94 <retranslator_mode>:
 c94:	a0010113          	addi	sp,sp,-1536
 c98:	5e112e23          	sw	ra,1532(sp)
 c9c:	5e812c23          	sw	s0,1528(sp)
 ca0:	60010413          	addi	s0,sp,1536
 ca4:	00100513          	li	a0,1
 ca8:	8b9ff0ef          	jal	ra,560 <ETHERNET_rx_ready>
 cac:	00050793          	mv	a5,a0
 cb0:	02078e63          	beqz	a5,cec <retranslator_mode+0x58>
 cb4:	a0c40793          	addi	a5,s0,-1524
 cb8:	00078593          	mv	a1,a5
 cbc:	00100513          	li	a0,1
 cc0:	f00ff0ef          	jal	ra,3c0 <ETHERNET_read_data>
 cc4:	00100513          	li	a0,1
 cc8:	ff8ff0ef          	jal	ra,4c0 <ETHERNET_data_count>
 ccc:	fea42623          	sw	a0,-20(s0)
 cd0:	fec42783          	lw	a5,-20(s0)
 cd4:	00478713          	addi	a4,a5,4
 cd8:	a0c40793          	addi	a5,s0,-1524
 cdc:	00070613          	mv	a2,a4
 ce0:	00078593          	mv	a1,a5
 ce4:	00200513          	li	a0,2
 ce8:	df8ff0ef          	jal	ra,2e0 <ETHERNET_send_data>
 cec:	00200513          	li	a0,2
 cf0:	871ff0ef          	jal	ra,560 <ETHERNET_rx_ready>
 cf4:	00050793          	mv	a5,a0
 cf8:	02078e63          	beqz	a5,d34 <retranslator_mode+0xa0>
 cfc:	a0c40793          	addi	a5,s0,-1524
 d00:	00078593          	mv	a1,a5
 d04:	00200513          	li	a0,2
 d08:	eb8ff0ef          	jal	ra,3c0 <ETHERNET_read_data>
 d0c:	00200513          	li	a0,2
 d10:	fb0ff0ef          	jal	ra,4c0 <ETHERNET_data_count>
 d14:	fea42423          	sw	a0,-24(s0)
 d18:	fe842783          	lw	a5,-24(s0)
 d1c:	00478713          	addi	a4,a5,4
 d20:	a0c40793          	addi	a5,s0,-1524
 d24:	00070613          	mv	a2,a4
 d28:	00078593          	mv	a1,a5
 d2c:	00100513          	li	a0,1
 d30:	db0ff0ef          	jal	ra,2e0 <ETHERNET_send_data>
 d34:	00000013          	nop
 d38:	5fc12083          	lw	ra,1532(sp)
 d3c:	5f812403          	lw	s0,1528(sp)
 d40:	60010113          	addi	sp,sp,1536
 d44:	00008067          	ret

00000d48 <send_echo_query>:
 d48:	fe010113          	addi	sp,sp,-32
 d4c:	00812e23          	sw	s0,28(sp)
 d50:	02010413          	addi	s0,sp,32
 d54:	00050793          	mv	a5,a0
 d58:	fef407a3          	sb	a5,-17(s0)
 d5c:	00000013          	nop
 d60:	01c12403          	lw	s0,28(sp)
 d64:	02010113          	addi	sp,sp,32
 d68:	00008067          	ret

00000d6c <init_arp>:
 d6c:	fe010113          	addi	sp,sp,-32
 d70:	00812e23          	sw	s0,28(sp)
 d74:	02010413          	addi	s0,sp,32
 d78:	fea42623          	sw	a0,-20(s0)
 d7c:	fec42783          	lw	a5,-20(s0)
 d80:	03878793          	addi	a5,a5,56
 d84:	0007a023          	sw	zero,0(a5)
 d88:	fec42783          	lw	a5,-20(s0)
 d8c:	03c78793          	addi	a5,a5,60
 d90:	00100713          	li	a4,1
 d94:	00e7a023          	sw	a4,0(a5)
 d98:	fec42783          	lw	a5,-20(s0)
 d9c:	04078793          	addi	a5,a5,64
 da0:	00800713          	li	a4,8
 da4:	00e7a023          	sw	a4,0(a5)
 da8:	fec42783          	lw	a5,-20(s0)
 dac:	04478793          	addi	a5,a5,68
 db0:	0007a023          	sw	zero,0(a5)
 db4:	fec42783          	lw	a5,-20(s0)
 db8:	04878793          	addi	a5,a5,72
 dbc:	00600713          	li	a4,6
 dc0:	00e7a023          	sw	a4,0(a5)
 dc4:	fec42783          	lw	a5,-20(s0)
 dc8:	04c78793          	addi	a5,a5,76
 dcc:	00400713          	li	a4,4
 dd0:	00e7a023          	sw	a4,0(a5)
 dd4:	fec42783          	lw	a5,-20(s0)
 dd8:	05078793          	addi	a5,a5,80
 ddc:	0007a023          	sw	zero,0(a5)
 de0:	fec42783          	lw	a5,-20(s0)
 de4:	05478793          	addi	a5,a5,84
 de8:	00100713          	li	a4,1
 dec:	00e7a023          	sw	a4,0(a5)
 df0:	fec42783          	lw	a5,-20(s0)
 df4:	05878793          	addi	a5,a5,88
 df8:	03600713          	li	a4,54
 dfc:	00e7a023          	sw	a4,0(a5)
 e00:	fec42783          	lw	a5,-20(s0)
 e04:	05c78793          	addi	a5,a5,92
 e08:	03600713          	li	a4,54
 e0c:	00e7a023          	sw	a4,0(a5)
 e10:	fec42783          	lw	a5,-20(s0)
 e14:	06078793          	addi	a5,a5,96
 e18:	03600713          	li	a4,54
 e1c:	00e7a023          	sw	a4,0(a5)
 e20:	fec42783          	lw	a5,-20(s0)
 e24:	06478793          	addi	a5,a5,100
 e28:	03600713          	li	a4,54
 e2c:	00e7a023          	sw	a4,0(a5)
 e30:	fec42783          	lw	a5,-20(s0)
 e34:	06878793          	addi	a5,a5,104
 e38:	03600713          	li	a4,54
 e3c:	00e7a023          	sw	a4,0(a5)
 e40:	fec42783          	lw	a5,-20(s0)
 e44:	06c78793          	addi	a5,a5,108
 e48:	03600713          	li	a4,54
 e4c:	00e7a023          	sw	a4,0(a5)
 e50:	fec42783          	lw	a5,-20(s0)
 e54:	07078793          	addi	a5,a5,112
 e58:	03600713          	li	a4,54
 e5c:	00e7a023          	sw	a4,0(a5)
 e60:	fec42783          	lw	a5,-20(s0)
 e64:	07478793          	addi	a5,a5,116
 e68:	03600713          	li	a4,54
 e6c:	00e7a023          	sw	a4,0(a5)
 e70:	fec42783          	lw	a5,-20(s0)
 e74:	07878793          	addi	a5,a5,120
 e78:	03600713          	li	a4,54
 e7c:	00e7a023          	sw	a4,0(a5)
 e80:	fec42783          	lw	a5,-20(s0)
 e84:	07c78793          	addi	a5,a5,124
 e88:	03600713          	li	a4,54
 e8c:	00e7a023          	sw	a4,0(a5)
 e90:	fec42783          	lw	a5,-20(s0)
 e94:	08078793          	addi	a5,a5,128
 e98:	0007a023          	sw	zero,0(a5)
 e9c:	fec42783          	lw	a5,-20(s0)
 ea0:	08478793          	addi	a5,a5,132
 ea4:	0007a023          	sw	zero,0(a5)
 ea8:	fec42783          	lw	a5,-20(s0)
 eac:	08878793          	addi	a5,a5,136
 eb0:	0007a023          	sw	zero,0(a5)
 eb4:	fec42783          	lw	a5,-20(s0)
 eb8:	08c78793          	addi	a5,a5,140
 ebc:	0007a023          	sw	zero,0(a5)
 ec0:	fec42783          	lw	a5,-20(s0)
 ec4:	09078793          	addi	a5,a5,144
 ec8:	0007a023          	sw	zero,0(a5)
 ecc:	fec42783          	lw	a5,-20(s0)
 ed0:	09478793          	addi	a5,a5,148
 ed4:	0007a023          	sw	zero,0(a5)
 ed8:	fec42783          	lw	a5,-20(s0)
 edc:	09878793          	addi	a5,a5,152
 ee0:	0007a023          	sw	zero,0(a5)
 ee4:	fec42783          	lw	a5,-20(s0)
 ee8:	09c78793          	addi	a5,a5,156
 eec:	00100713          	li	a4,1
 ef0:	00e7a023          	sw	a4,0(a5)
 ef4:	fec42783          	lw	a5,-20(s0)
 ef8:	0a078793          	addi	a5,a5,160
 efc:	01000713          	li	a4,16
 f00:	00e7a023          	sw	a4,0(a5)
 f04:	fec42783          	lw	a5,-20(s0)
 f08:	0a478793          	addi	a5,a5,164
 f0c:	01100713          	li	a4,17
 f10:	00e7a023          	sw	a4,0(a5)
 f14:	fec42783          	lw	a5,-20(s0)
 f18:	0a878793          	addi	a5,a5,168
 f1c:	0007a023          	sw	zero,0(a5)
 f20:	fec42783          	lw	a5,-20(s0)
 f24:	0ac78793          	addi	a5,a5,172
 f28:	0007a023          	sw	zero,0(a5)
 f2c:	fec42783          	lw	a5,-20(s0)
 f30:	0b078793          	addi	a5,a5,176
 f34:	0007a023          	sw	zero,0(a5)
 f38:	fec42783          	lw	a5,-20(s0)
 f3c:	0b478793          	addi	a5,a5,180
 f40:	0007a023          	sw	zero,0(a5)
 f44:	fec42783          	lw	a5,-20(s0)
 f48:	0b878793          	addi	a5,a5,184
 f4c:	0007a023          	sw	zero,0(a5)
 f50:	fec42783          	lw	a5,-20(s0)
 f54:	0bc78793          	addi	a5,a5,188
 f58:	0007a023          	sw	zero,0(a5)
 f5c:	fec42783          	lw	a5,-20(s0)
 f60:	0c078793          	addi	a5,a5,192
 f64:	0007a023          	sw	zero,0(a5)
 f68:	fec42783          	lw	a5,-20(s0)
 f6c:	0c478793          	addi	a5,a5,196
 f70:	0007a023          	sw	zero,0(a5)
 f74:	fec42783          	lw	a5,-20(s0)
 f78:	0c878793          	addi	a5,a5,200
 f7c:	0007a023          	sw	zero,0(a5)
 f80:	fec42783          	lw	a5,-20(s0)
 f84:	0cc78793          	addi	a5,a5,204
 f88:	0007a023          	sw	zero,0(a5)
 f8c:	fec42783          	lw	a5,-20(s0)
 f90:	0d078793          	addi	a5,a5,208
 f94:	0007a023          	sw	zero,0(a5)
 f98:	fec42783          	lw	a5,-20(s0)
 f9c:	0d478793          	addi	a5,a5,212
 fa0:	0007a023          	sw	zero,0(a5)
 fa4:	fec42783          	lw	a5,-20(s0)
 fa8:	0d878793          	addi	a5,a5,216
 fac:	0007a023          	sw	zero,0(a5)
 fb0:	fec42783          	lw	a5,-20(s0)
 fb4:	0dc78793          	addi	a5,a5,220
 fb8:	0007a023          	sw	zero,0(a5)
 fbc:	fec42783          	lw	a5,-20(s0)
 fc0:	0e078793          	addi	a5,a5,224
 fc4:	0007a023          	sw	zero,0(a5)
 fc8:	fec42783          	lw	a5,-20(s0)
 fcc:	0e478793          	addi	a5,a5,228
 fd0:	0007a023          	sw	zero,0(a5)
 fd4:	fec42783          	lw	a5,-20(s0)
 fd8:	0e878793          	addi	a5,a5,232
 fdc:	0007a023          	sw	zero,0(a5)
 fe0:	fec42783          	lw	a5,-20(s0)
 fe4:	0ec78793          	addi	a5,a5,236
 fe8:	0007a023          	sw	zero,0(a5)
 fec:	00000013          	nop
 ff0:	01c12403          	lw	s0,28(sp)
 ff4:	02010113          	addi	sp,sp,32
 ff8:	00008067          	ret

Disassembly of section .srodata:

00000ffc <.srodata>:
     ffc:	ffff                	0xffff
     ffe:	ffff                	0xffff
    1000:	ffff                	0xffff
    1002:	0000                	unimp
    1004:	3412                	fld	fs0,288(sp)
    1006:	7856                	flw	fa6,116(sp)
    1008:	          	0xcdab

Disassembly of section .sdata:

00006000 <A>:
    6000:	37    	Address 0x0000000000006000 is out of bounds.

    6004:	 

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	fmsub.d	ft6,ft6,ft4,ft7,rmm
   4:	2820                	fld	fs0,80(s0)
   6:	29554e47          	fmsub.s	ft8,fa0,fs5,ft5,rmm
   a:	3820                	fld	fs0,112(s0)
   c:	322e                	fld	ft4,232(sp)
   e:	302e                	fld	ft0,232(sp)
	...
