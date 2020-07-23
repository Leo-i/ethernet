
void set_led(int led){
    int *p = (LED_BASE_ADDR + LED_CTRL);
    *p = led;
}
