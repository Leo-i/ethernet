
void delay_ms(int time){
    int delay = time*982;
    for(int i = 0; i<delay;i++); // ms
}
void delay_us(int time){
    int delay = time << 1;
    for(int i = 0; i<delay;i++); // us
}
void delay(int time){
    for(int i = 0; i<time;i++); // 509 ns
}