import os
import sys
import time
import serial

ser = serial.Serial(port='COM3',baudrate=115200, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE,timeout=1)

ser.write(bytearray.fromhex('11'))
ser.close()
