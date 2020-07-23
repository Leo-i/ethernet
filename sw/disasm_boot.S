
main.elf:     file format elf32-littleriscv


Disassembly of section .text:

00000000 <UART_check_busy-0x4>:
   0:	0650006f          	j	864 <main>

00000004 <UART_check_busy>:
   4:	fe010113          	addi	sp,sp,-32
   8:	00812e23          	sw	s0,28(sp)
   c:	02010413          	addi	s0,sp,32
  10:	000087b7          	lui	a5,0x8
  14:	20878793          	addi	a5,a5,520 # 8208 <__global_pointer$+0x6174>
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
  44:	20078793          	addi	a5,a5,512 # 8200 <__global_pointer$+0x616c>
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
  78:	20478793          	addi	a5,a5,516 # 8204 <__global_pointer$+0x6170>
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
  b0:	20478793          	addi	a5,a5,516 # 8204 <__global_pointer$+0x6170>
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
 114:	20c78793          	addi	a5,a5,524 # 820c <__global_pointer$+0x6178>
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
 190:	02c12403          	lw	s0,44(sp)
 194:	03010113          	addi	sp,sp,48
 198:	00008067          	ret

0000019c <delay_us>:
 19c:	fd010113          	addi	sp,sp,-48
 1a0:	02812623          	sw	s0,44(sp)
 1a4:	03010413          	addi	s0,sp,48
 1a8:	fca42e23          	sw	a0,-36(s0)
 1ac:	fdc42783          	lw	a5,-36(s0)
 1b0:	00179793          	slli	a5,a5,0x1
 1b4:	fef42423          	sw	a5,-24(s0)
 1b8:	fe042623          	sw	zero,-20(s0)
 1bc:	0100006f          	j	1cc <delay_us+0x30>
 1c0:	fec42783          	lw	a5,-20(s0)
 1c4:	00178793          	addi	a5,a5,1
 1c8:	fef42623          	sw	a5,-20(s0)
 1cc:	fec42703          	lw	a4,-20(s0)
 1d0:	fe842783          	lw	a5,-24(s0)
 1d4:	fef746e3          	blt	a4,a5,1c0 <delay_us+0x24>
 1d8:	00000013          	nop
 1dc:	02c12403          	lw	s0,44(sp)
 1e0:	03010113          	addi	sp,sp,48
 1e4:	00008067          	ret

000001e8 <delay>:
 1e8:	fd010113          	addi	sp,sp,-48
 1ec:	02812623          	sw	s0,44(sp)
 1f0:	03010413          	addi	s0,sp,48
 1f4:	fca42e23          	sw	a0,-36(s0)
 1f8:	fe042623          	sw	zero,-20(s0)
 1fc:	0100006f          	j	20c <delay+0x24>
 200:	fec42783          	lw	a5,-20(s0)
 204:	00178793          	addi	a5,a5,1
 208:	fef42623          	sw	a5,-20(s0)
 20c:	fec42703          	lw	a4,-20(s0)
 210:	fdc42783          	lw	a5,-36(s0)
 214:	fef746e3          	blt	a4,a5,200 <delay+0x18>
 218:	00000013          	nop
 21c:	02c12403          	lw	s0,44(sp)
 220:	03010113          	addi	sp,sp,48
 224:	00008067          	ret

00000228 <set_led>:
 228:	fd010113          	addi	sp,sp,-48
 22c:	02812623          	sw	s0,44(sp)
 230:	03010413          	addi	s0,sp,48
 234:	fca42e23          	sw	a0,-36(s0)
 238:	000087b7          	lui	a5,0x8
 23c:	30078793          	addi	a5,a5,768 # 8300 <__global_pointer$+0x626c>
 240:	fef42623          	sw	a5,-20(s0)
 244:	fec42783          	lw	a5,-20(s0)
 248:	fdc42703          	lw	a4,-36(s0)
 24c:	00e7a023          	sw	a4,0(a5)
 250:	00000013          	nop
 254:	02c12403          	lw	s0,44(sp)
 258:	03010113          	addi	sp,sp,48
 25c:	00008067          	ret

00000260 <ETHERNET_send_data>:
 260:	fd010113          	addi	sp,sp,-48
 264:	02812623          	sw	s0,44(sp)
 268:	03010413          	addi	s0,sp,48
 26c:	fca42e23          	sw	a0,-36(s0)
 270:	fcb42c23          	sw	a1,-40(s0)
 274:	fcc42a23          	sw	a2,-44(s0)
 278:	fdc42703          	lw	a4,-36(s0)
 27c:	00100793          	li	a5,1
 280:	00f71863          	bne	a4,a5,290 <ETHERNET_send_data+0x30>
 284:	000087b7          	lui	a5,0x8
 288:	fef42623          	sw	a5,-20(s0)
 28c:	0100006f          	j	29c <ETHERNET_send_data+0x3c>
 290:	000087b7          	lui	a5,0x8
 294:	10078793          	addi	a5,a5,256 # 8100 <__global_pointer$+0x606c>
 298:	fef42623          	sw	a5,-20(s0)
 29c:	a0a017b7          	lui	a5,0xa0a01
 2a0:	b0878793          	addi	a5,a5,-1272 # a0a00b08 <__global_pointer$+0xa09fea74>
 2a4:	fef42223          	sw	a5,-28(s0)
 2a8:	fe442783          	lw	a5,-28(s0)
 2ac:	04000713          	li	a4,64
 2b0:	00e7a023          	sw	a4,0(a5)
 2b4:	fd442783          	lw	a5,-44(s0)
 2b8:	0027d793          	srli	a5,a5,0x2
 2bc:	fef42023          	sw	a5,-32(s0)
 2c0:	fe042423          	sw	zero,-24(s0)
 2c4:	0600006f          	j	324 <ETHERNET_send_data+0xc4>
 2c8:	fe842703          	lw	a4,-24(s0)
 2cc:	fe042783          	lw	a5,-32(s0)
 2d0:	02f71463          	bne	a4,a5,2f8 <ETHERNET_send_data+0x98>
 2d4:	fe842783          	lw	a5,-24(s0)
 2d8:	00279793          	slli	a5,a5,0x2
 2dc:	fd842703          	lw	a4,-40(s0)
 2e0:	00f707b3          	add	a5,a4,a5
 2e4:	0007a783          	lw	a5,0(a5)
 2e8:	00078713          	mv	a4,a5
 2ec:	fe442783          	lw	a5,-28(s0)
 2f0:	00e7a023          	sw	a4,0(a5)
 2f4:	0240006f          	j	318 <ETHERNET_send_data+0xb8>
 2f8:	fe842783          	lw	a5,-24(s0)
 2fc:	00279793          	slli	a5,a5,0x2
 300:	fd842703          	lw	a4,-40(s0)
 304:	00f707b3          	add	a5,a4,a5
 308:	0007a783          	lw	a5,0(a5)
 30c:	00078713          	mv	a4,a5
 310:	fec42783          	lw	a5,-20(s0)
 314:	00e7a023          	sw	a4,0(a5)
 318:	fe842783          	lw	a5,-24(s0)
 31c:	00178793          	addi	a5,a5,1
 320:	fef42423          	sw	a5,-24(s0)
 324:	fe842703          	lw	a4,-24(s0)
 328:	fe042783          	lw	a5,-32(s0)
 32c:	f8e7dee3          	bge	a5,a4,2c8 <ETHERNET_send_data+0x68>
 330:	00000013          	nop
 334:	02c12403          	lw	s0,44(sp)
 338:	03010113          	addi	sp,sp,48
 33c:	00008067          	ret

00000340 <ETHERNET_read_data>:
 340:	fc010113          	addi	sp,sp,-64
 344:	02812e23          	sw	s0,60(sp)
 348:	04010413          	addi	s0,sp,64
 34c:	fca42623          	sw	a0,-52(s0)
 350:	fcb42423          	sw	a1,-56(s0)
 354:	fcc42703          	lw	a4,-52(s0)
 358:	00100793          	li	a5,1
 35c:	00f71a63          	bne	a4,a5,370 <ETHERNET_read_data+0x30>
 360:	000087b7          	lui	a5,0x8
 364:	00878793          	addi	a5,a5,8 # 8008 <__global_pointer$+0x5f74>
 368:	fef42623          	sw	a5,-20(s0)
 36c:	0100006f          	j	37c <ETHERNET_read_data+0x3c>
 370:	000087b7          	lui	a5,0x8
 374:	10878793          	addi	a5,a5,264 # 8108 <__global_pointer$+0x6074>
 378:	fef42623          	sw	a5,-20(s0)
 37c:	a0a017b7          	lui	a5,0xa0a01
 380:	b0878793          	addi	a5,a5,-1272 # a0a00b08 <__global_pointer$+0xa09fea74>
 384:	fef42223          	sw	a5,-28(s0)
 388:	fe442783          	lw	a5,-28(s0)
 38c:	0007a783          	lw	a5,0(a5)
 390:	fef42023          	sw	a5,-32(s0)
 394:	fe042423          	sw	zero,-24(s0)
 398:	fec42783          	lw	a5,-20(s0)
 39c:	0007a783          	lw	a5,0(a5)
 3a0:	fcf42e23          	sw	a5,-36(s0)
 3a4:	fdc42703          	lw	a4,-36(s0)
 3a8:	a0a017b7          	lui	a5,0xa0a01
 3ac:	b0878793          	addi	a5,a5,-1272 # a0a00b08 <__global_pointer$+0xa09fea74>
 3b0:	02f70663          	beq	a4,a5,3dc <ETHERNET_read_data+0x9c>
 3b4:	fe842783          	lw	a5,-24(s0)
 3b8:	00279793          	slli	a5,a5,0x2
 3bc:	fc842703          	lw	a4,-56(s0)
 3c0:	00f707b3          	add	a5,a4,a5
 3c4:	fdc42703          	lw	a4,-36(s0)
 3c8:	00e7a023          	sw	a4,0(a5)
 3cc:	fe842783          	lw	a5,-24(s0)
 3d0:	00178793          	addi	a5,a5,1
 3d4:	fef42423          	sw	a5,-24(s0)
 3d8:	fc1ff06f          	j	398 <ETHERNET_read_data+0x58>
 3dc:	00000013          	nop
 3e0:	03c12403          	lw	s0,60(sp)
 3e4:	04010113          	addi	sp,sp,64
 3e8:	00008067          	ret

000003ec <ETHERNET_check_done>:
 3ec:	fd010113          	addi	sp,sp,-48
 3f0:	02812623          	sw	s0,44(sp)
 3f4:	03010413          	addi	s0,sp,48
 3f8:	fca42e23          	sw	a0,-36(s0)
 3fc:	fdc42703          	lw	a4,-36(s0)
 400:	00100793          	li	a5,1
 404:	00f71a63          	bne	a4,a5,418 <ETHERNET_check_done+0x2c>
 408:	000087b7          	lui	a5,0x8
 40c:	00478793          	addi	a5,a5,4 # 8004 <__global_pointer$+0x5f70>
 410:	fef42623          	sw	a5,-20(s0)
 414:	0100006f          	j	424 <ETHERNET_check_done+0x38>
 418:	000087b7          	lui	a5,0x8
 41c:	10478793          	addi	a5,a5,260 # 8104 <__global_pointer$+0x6070>
 420:	fef42623          	sw	a5,-20(s0)
 424:	fec42783          	lw	a5,-20(s0)
 428:	0007a783          	lw	a5,0(a5)
 42c:	00078513          	mv	a0,a5
 430:	02c12403          	lw	s0,44(sp)
 434:	03010113          	addi	sp,sp,48
 438:	00008067          	ret

0000043c <ETHERNET_data_count>:
 43c:	fd010113          	addi	sp,sp,-48
 440:	02812623          	sw	s0,44(sp)
 444:	03010413          	addi	s0,sp,48
 448:	fca42e23          	sw	a0,-36(s0)
 44c:	fdc42703          	lw	a4,-36(s0)
 450:	00100793          	li	a5,1
 454:	00f71a63          	bne	a4,a5,468 <ETHERNET_data_count+0x2c>
 458:	000087b7          	lui	a5,0x8
 45c:	01078793          	addi	a5,a5,16 # 8010 <__global_pointer$+0x5f7c>
 460:	fef42623          	sw	a5,-20(s0)
 464:	0100006f          	j	474 <ETHERNET_data_count+0x38>
 468:	000087b7          	lui	a5,0x8
 46c:	11078793          	addi	a5,a5,272 # 8110 <__global_pointer$+0x607c>
 470:	fef42623          	sw	a5,-20(s0)
 474:	fec42783          	lw	a5,-20(s0)
 478:	0007a783          	lw	a5,0(a5)
 47c:	00078513          	mv	a0,a5
 480:	02c12403          	lw	s0,44(sp)
 484:	03010113          	addi	sp,sp,48
 488:	00008067          	ret

0000048c <ETHERNET_protocol>:
 48c:	fd010113          	addi	sp,sp,-48
 490:	02812623          	sw	s0,44(sp)
 494:	03010413          	addi	s0,sp,48
 498:	fca42e23          	sw	a0,-36(s0)
 49c:	fdc42703          	lw	a4,-36(s0)
 4a0:	00100793          	li	a5,1
 4a4:	00f71a63          	bne	a4,a5,4b8 <ETHERNET_protocol+0x2c>
 4a8:	000087b7          	lui	a5,0x8
 4ac:	01478793          	addi	a5,a5,20 # 8014 <__global_pointer$+0x5f80>
 4b0:	fef42623          	sw	a5,-20(s0)
 4b4:	0100006f          	j	4c4 <ETHERNET_protocol+0x38>
 4b8:	000087b7          	lui	a5,0x8
 4bc:	11478793          	addi	a5,a5,276 # 8114 <__global_pointer$+0x6080>
 4c0:	fef42623          	sw	a5,-20(s0)
 4c4:	fec42783          	lw	a5,-20(s0)
 4c8:	0007a783          	lw	a5,0(a5)
 4cc:	00078513          	mv	a0,a5
 4d0:	02c12403          	lw	s0,44(sp)
 4d4:	03010113          	addi	sp,sp,48
 4d8:	00008067          	ret

000004dc <ETHERNET_rx_ready>:
 4dc:	fd010113          	addi	sp,sp,-48
 4e0:	02812623          	sw	s0,44(sp)
 4e4:	03010413          	addi	s0,sp,48
 4e8:	fca42e23          	sw	a0,-36(s0)
 4ec:	fdc42703          	lw	a4,-36(s0)
 4f0:	00100793          	li	a5,1
 4f4:	00f71a63          	bne	a4,a5,508 <ETHERNET_rx_ready+0x2c>
 4f8:	000087b7          	lui	a5,0x8
 4fc:	00c78793          	addi	a5,a5,12 # 800c <__global_pointer$+0x5f78>
 500:	fef42623          	sw	a5,-20(s0)
 504:	0100006f          	j	514 <ETHERNET_rx_ready+0x38>
 508:	000087b7          	lui	a5,0x8
 50c:	10c78793          	addi	a5,a5,268 # 810c <__global_pointer$+0x6078>
 510:	fef42623          	sw	a5,-20(s0)
 514:	fec42783          	lw	a5,-20(s0)
 518:	0007a783          	lw	a5,0(a5)
 51c:	00078513          	mv	a0,a5
 520:	02c12403          	lw	s0,44(sp)
 524:	03010113          	addi	sp,sp,48
 528:	00008067          	ret

0000052c <DM_set_reg>:
 52c:	fd010113          	addi	sp,sp,-48
 530:	02812623          	sw	s0,44(sp)
 534:	03010413          	addi	s0,sp,48
 538:	fca42e23          	sw	a0,-36(s0)
 53c:	fcb42c23          	sw	a1,-40(s0)
 540:	fcc42a23          	sw	a2,-44(s0)
 544:	fdc42703          	lw	a4,-36(s0)
 548:	00100793          	li	a5,1
 54c:	00f71a63          	bne	a4,a5,560 <DM_set_reg+0x34>
 550:	000087b7          	lui	a5,0x8
 554:	01878793          	addi	a5,a5,24 # 8018 <__global_pointer$+0x5f84>
 558:	fef42623          	sw	a5,-20(s0)
 55c:	0100006f          	j	56c <DM_set_reg+0x40>
 560:	000087b7          	lui	a5,0x8
 564:	11878793          	addi	a5,a5,280 # 8118 <__global_pointer$+0x6084>
 568:	fef42623          	sw	a5,-20(s0)
 56c:	fdc42703          	lw	a4,-36(s0)
 570:	00100793          	li	a5,1
 574:	00f71a63          	bne	a4,a5,588 <DM_set_reg+0x5c>
 578:	000087b7          	lui	a5,0x8
 57c:	01c78793          	addi	a5,a5,28 # 801c <__global_pointer$+0x5f88>
 580:	fef42423          	sw	a5,-24(s0)
 584:	0100006f          	j	594 <DM_set_reg+0x68>
 588:	000087b7          	lui	a5,0x8
 58c:	11c78793          	addi	a5,a5,284 # 811c <__global_pointer$+0x6088>
 590:	fef42423          	sw	a5,-24(s0)
 594:	fd442703          	lw	a4,-44(s0)
 598:	fe842783          	lw	a5,-24(s0)
 59c:	00e7a023          	sw	a4,0(a5)
 5a0:	fd842703          	lw	a4,-40(s0)
 5a4:	fec42783          	lw	a5,-20(s0)
 5a8:	00e7a023          	sw	a4,0(a5)
 5ac:	00000013          	nop
 5b0:	02c12403          	lw	s0,44(sp)
 5b4:	03010113          	addi	sp,sp,48
 5b8:	00008067          	ret

000005bc <DM_busy>:
 5bc:	fd010113          	addi	sp,sp,-48
 5c0:	02812623          	sw	s0,44(sp)
 5c4:	03010413          	addi	s0,sp,48
 5c8:	fca42e23          	sw	a0,-36(s0)
 5cc:	fdc42703          	lw	a4,-36(s0)
 5d0:	00100793          	li	a5,1
 5d4:	00f71a63          	bne	a4,a5,5e8 <DM_busy+0x2c>
 5d8:	000087b7          	lui	a5,0x8
 5dc:	02478793          	addi	a5,a5,36 # 8024 <__global_pointer$+0x5f90>
 5e0:	fef42623          	sw	a5,-20(s0)
 5e4:	0100006f          	j	5f4 <DM_busy+0x38>
 5e8:	000087b7          	lui	a5,0x8
 5ec:	12478793          	addi	a5,a5,292 # 8124 <__global_pointer$+0x6090>
 5f0:	fef42623          	sw	a5,-20(s0)
 5f4:	fec42783          	lw	a5,-20(s0)
 5f8:	0007a783          	lw	a5,0(a5)
 5fc:	00078513          	mv	a0,a5
 600:	02c12403          	lw	s0,44(sp)
 604:	03010113          	addi	sp,sp,48
 608:	00008067          	ret

0000060c <DM_get_reg>:
 60c:	fd010113          	addi	sp,sp,-48
 610:	02112623          	sw	ra,44(sp)
 614:	02812423          	sw	s0,40(sp)
 618:	03010413          	addi	s0,sp,48
 61c:	fca42e23          	sw	a0,-36(s0)
 620:	fcb42c23          	sw	a1,-40(s0)
 624:	fdc42703          	lw	a4,-36(s0)
 628:	00100793          	li	a5,1
 62c:	00f71a63          	bne	a4,a5,640 <DM_get_reg+0x34>
 630:	000087b7          	lui	a5,0x8
 634:	01878793          	addi	a5,a5,24 # 8018 <__global_pointer$+0x5f84>
 638:	fef42423          	sw	a5,-24(s0)
 63c:	0100006f          	j	64c <DM_get_reg+0x40>
 640:	000087b7          	lui	a5,0x8
 644:	11878793          	addi	a5,a5,280 # 8118 <__global_pointer$+0x6084>
 648:	fef42423          	sw	a5,-24(s0)
 64c:	fdc42503          	lw	a0,-36(s0)
 650:	f6dff0ef          	jal	ra,5bc <DM_busy>
 654:	00050793          	mv	a5,a0
 658:	00078463          	beqz	a5,660 <DM_get_reg+0x54>
 65c:	ff1ff06f          	j	64c <DM_get_reg+0x40>
 660:	00000013          	nop
 664:	fdc42703          	lw	a4,-36(s0)
 668:	00100793          	li	a5,1
 66c:	00f71a63          	bne	a4,a5,680 <DM_get_reg+0x74>
 670:	000087b7          	lui	a5,0x8
 674:	02078793          	addi	a5,a5,32 # 8020 <__global_pointer$+0x5f8c>
 678:	fef42623          	sw	a5,-20(s0)
 67c:	0100006f          	j	68c <DM_get_reg+0x80>
 680:	000087b7          	lui	a5,0x8
 684:	12078793          	addi	a5,a5,288 # 8120 <__global_pointer$+0x608c>
 688:	fef42623          	sw	a5,-20(s0)
 68c:	fec42783          	lw	a5,-20(s0)
 690:	0007a783          	lw	a5,0(a5)
 694:	00078513          	mv	a0,a5
 698:	02c12083          	lw	ra,44(sp)
 69c:	02812403          	lw	s0,40(sp)
 6a0:	03010113          	addi	sp,sp,48
 6a4:	00008067          	ret

000006a8 <bootloader>:
 6a8:	fd010113          	addi	sp,sp,-48
 6ac:	02112623          	sw	ra,44(sp)
 6b0:	02812423          	sw	s0,40(sp)
 6b4:	02912223          	sw	s1,36(sp)
 6b8:	03010413          	addi	s0,sp,48
 6bc:	000017b7          	lui	a5,0x1
 6c0:	86478793          	addi	a5,a5,-1948 # 864 <main>
 6c4:	fef42423          	sw	a5,-24(s0)
 6c8:	a3dff0ef          	jal	ra,104 <UART_check>
 6cc:	00050793          	mv	a5,a0
 6d0:	00079463          	bnez	a5,6d8 <bootloader+0x30>
 6d4:	ff5ff06f          	j	6c8 <bootloader+0x20>
 6d8:	00000013          	nop
 6dc:	959ff0ef          	jal	ra,34 <UART_read_data>
 6e0:	fea42223          	sw	a0,-28(s0)
 6e4:	a21ff0ef          	jal	ra,104 <UART_check>
 6e8:	00050793          	mv	a5,a0
 6ec:	00079463          	bnez	a5,6f4 <bootloader+0x4c>
 6f0:	ff5ff06f          	j	6e4 <bootloader+0x3c>
 6f4:	00000013          	nop
 6f8:	fe442783          	lw	a5,-28(s0)
 6fc:	00879493          	slli	s1,a5,0x8
 700:	935ff0ef          	jal	ra,34 <UART_read_data>
 704:	00050793          	mv	a5,a0
 708:	00f487b3          	add	a5,s1,a5
 70c:	fef42223          	sw	a5,-28(s0)
 710:	9f5ff0ef          	jal	ra,104 <UART_check>
 714:	00050793          	mv	a5,a0
 718:	00079463          	bnez	a5,720 <bootloader+0x78>
 71c:	ff5ff06f          	j	710 <bootloader+0x68>
 720:	00000013          	nop
 724:	fe442783          	lw	a5,-28(s0)
 728:	00879493          	slli	s1,a5,0x8
 72c:	909ff0ef          	jal	ra,34 <UART_read_data>
 730:	00050793          	mv	a5,a0
 734:	00f487b3          	add	a5,s1,a5
 738:	fef42223          	sw	a5,-28(s0)
 73c:	9c9ff0ef          	jal	ra,104 <UART_check>
 740:	00050793          	mv	a5,a0
 744:	00079463          	bnez	a5,74c <bootloader+0xa4>
 748:	ff5ff06f          	j	73c <bootloader+0x94>
 74c:	00000013          	nop
 750:	fe442783          	lw	a5,-28(s0)
 754:	00879493          	slli	s1,a5,0x8
 758:	8ddff0ef          	jal	ra,34 <UART_read_data>
 75c:	00050793          	mv	a5,a0
 760:	00f487b3          	add	a5,s1,a5
 764:	fef42223          	sw	a5,-28(s0)
 768:	fe842783          	lw	a5,-24(s0)
 76c:	fef42623          	sw	a5,-20(s0)
 770:	0c40006f          	j	834 <bootloader+0x18c>
 774:	fec42783          	lw	a5,-20(s0)
 778:	fef42023          	sw	a5,-32(s0)
 77c:	989ff0ef          	jal	ra,104 <UART_check>
 780:	00050793          	mv	a5,a0
 784:	00079463          	bnez	a5,78c <bootloader+0xe4>
 788:	ff5ff06f          	j	77c <bootloader+0xd4>
 78c:	00000013          	nop
 790:	8a5ff0ef          	jal	ra,34 <UART_read_data>
 794:	fca42e23          	sw	a0,-36(s0)
 798:	96dff0ef          	jal	ra,104 <UART_check>
 79c:	00050793          	mv	a5,a0
 7a0:	00079463          	bnez	a5,7a8 <bootloader+0x100>
 7a4:	ff5ff06f          	j	798 <bootloader+0xf0>
 7a8:	00000013          	nop
 7ac:	fdc42783          	lw	a5,-36(s0)
 7b0:	00879493          	slli	s1,a5,0x8
 7b4:	881ff0ef          	jal	ra,34 <UART_read_data>
 7b8:	00050793          	mv	a5,a0
 7bc:	00f487b3          	add	a5,s1,a5
 7c0:	fcf42e23          	sw	a5,-36(s0)
 7c4:	941ff0ef          	jal	ra,104 <UART_check>
 7c8:	00050793          	mv	a5,a0
 7cc:	00079463          	bnez	a5,7d4 <bootloader+0x12c>
 7d0:	ff5ff06f          	j	7c4 <bootloader+0x11c>
 7d4:	00000013          	nop
 7d8:	fdc42783          	lw	a5,-36(s0)
 7dc:	00879493          	slli	s1,a5,0x8
 7e0:	855ff0ef          	jal	ra,34 <UART_read_data>
 7e4:	00050793          	mv	a5,a0
 7e8:	00f487b3          	add	a5,s1,a5
 7ec:	fcf42e23          	sw	a5,-36(s0)
 7f0:	915ff0ef          	jal	ra,104 <UART_check>
 7f4:	00050793          	mv	a5,a0
 7f8:	00079463          	bnez	a5,800 <bootloader+0x158>
 7fc:	ff5ff06f          	j	7f0 <bootloader+0x148>
 800:	00000013          	nop
 804:	fdc42783          	lw	a5,-36(s0)
 808:	00879493          	slli	s1,a5,0x8
 80c:	829ff0ef          	jal	ra,34 <UART_read_data>
 810:	00050793          	mv	a5,a0
 814:	00f487b3          	add	a5,s1,a5
 818:	fcf42e23          	sw	a5,-36(s0)
 81c:	fe042783          	lw	a5,-32(s0)
 820:	fdc42703          	lw	a4,-36(s0)
 824:	00e7a023          	sw	a4,0(a5)
 828:	fec42783          	lw	a5,-20(s0)
 82c:	00478793          	addi	a5,a5,4
 830:	fef42623          	sw	a5,-20(s0)
 834:	fe442703          	lw	a4,-28(s0)
 838:	fe842783          	lw	a5,-24(s0)
 83c:	00f707b3          	add	a5,a4,a5
 840:	fec42703          	lw	a4,-20(s0)
 844:	f2e7d8e3          	bge	a5,a4,774 <bootloader+0xcc>
 848:	01c0006f          	j	864 <main>
 84c:	00000013          	nop
 850:	02c12083          	lw	ra,44(sp)
 854:	02812403          	lw	s0,40(sp)
 858:	02412483          	lw	s1,36(sp)
 85c:	03010113          	addi	sp,sp,48
 860:	00008067          	ret

00000864 <main>:
 864:	ff010113          	addi	sp,sp,-16
 868:	00112623          	sw	ra,12(sp)
 86c:	00812423          	sw	s0,8(sp)
 870:	01010413          	addi	s0,sp,16
 874:	03700513          	li	a0,55
 878:	9b1ff0ef          	jal	ra,228 <set_led>
 87c:	00000013          	nop
 880:	00078513          	mv	a0,a5
 884:	00c12083          	lw	ra,12(sp)
 888:	00812403          	lw	s0,8(sp)
 88c:	01010113          	addi	sp,sp,16
 890:	00008067          	ret

Disassembly of section .comment:

00000000 <.comment>:
   0:	3a434347          	fmsub.d	ft6,ft6,ft4,ft7,rmm
   4:	2820                	fld	fs0,80(s0)
   6:	29554e47          	fmsub.s	ft8,fa0,fs5,ft5,rmm
   a:	3820                	fld	fs0,112(s0)
   c:	322e                	fld	ft4,232(sp)
   e:	302e                	fld	ft0,232(sp)
	...
