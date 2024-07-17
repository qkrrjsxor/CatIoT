# 배급기(제작중)
![20240717_164723](https://github.com/user-attachments/assets/88971741-d553-4afc-947f-2bba0dfba818)

## 담당자
- 박승헌, 전혜림
  
## 배급기 구조
![image](https://github.com/user-attachments/assets/25d0c663-767e-4bcf-bc83-004323eb3d59)

## 사용한 모듈
- STM32103RBT6
- ESP8266(ESP-01)
- Loadcell 500g & Loadcell Converter(24bit)
- SG90 (서보모터)

### STM32 Pin Configuration
![image](https://github.com/user-attachments/assets/b68358f0-2f42-485c-bae5-f5cc40b891c9)

1. ESP-8266 (USART3)
- PB10 (TX) <-> ESP(RX)
- PB11 (RX) <-> ESP(TX)

2. Loadcell Converter
- PC2 : GPIO INPUT (DT PIN)
- PC3 : GPIO OUTPUT (SDK PIN)

3. Servo
- PA7(TIM2) : PWN Generator
