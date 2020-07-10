#!/usr/bin/python3
import os
import sys
import time
import serial
import re

ser = serial.Serial(port='COM3',baudrate=115200, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE,timeout=1)
print('Bootloader ready')
ser.reset_input_buffer()
ser.reset_output_buffer()

ser.write(bytearray.fromhex('38'))
time.sleep(0.01)
print('Bootloader start')
ser.write(bytearray.fromhex('00'))
ser.write(bytearray.fromhex('00'))
ser.write(bytearray.fromhex('07'))
ser.write(bytearray.fromhex('14'))


after_main = False
f = open('dump', 'r')
for line in f:
    if after_main and re.match(r'[0-9,a,b,c,d,e,f]{8}',line[6:14]):
        print(line[6:14])
        ser.write(bytearray.fromhex(line[6:14]))
    elif line[10:14] == "main":
        after_main = True
    

print('Programming done!')
ser.close()
f.close()