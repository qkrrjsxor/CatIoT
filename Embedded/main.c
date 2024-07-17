/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.c
  * @brief          : Main program body
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2024 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "tim.h"
#include "usart.h"
#include "gpio.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */
#include <string.h>
#include <stdio.h>
/* USER CODE END Includes */

/* Private typedef -----------------------------------------------------------*/
/* USER CODE BEGIN PTD */

/* USER CODE END PTD */

/* Private define ------------------------------------------------------------*/
/* USER CODE BEGIN PD */
#define HX711_DT_PIN GPIO_PIN_2
#define HX711_DT_PORT GPIOC
#define HX711_SCK_PIN GPIO_PIN_3
#define HX711_SCK_PORT GPIOC
/* USER CODE END PD */

/* Private macro -------------------------------------------------------------*/
/* USER CODE BEGIN PM */

/* USER CODE END PM */

/* Private variables ---------------------------------------------------------*/

/* USER CODE BEGIN PV */
char rx_buffer[100]; // ?��?�� 버퍼
/* USER CODE END PV */

/* Private function prototypes -----------------------------------------------*/
void SystemClock_Config(void);
/* USER CODE BEGIN PFP */
int32_t HX711_Read(void);
void HX711_Init(void);
/* USER CODE END PFP */

/* Private user code ---------------------------------------------------------*/
/* USER CODE BEGIN 0 */
int _read(int file, char *ptr, int len){
	HAL_UART_Receive(&huart2, (uint8_t*)ptr, 1, 0xFFFF);
	HAL_UART_Transmit(&huart2, (uint8_t*)ptr, 1, 100);
	return 1;
}

int _write(int file, char *ptr, int len){
	HAL_UART_Transmit(&huart2, (uint8_t*)ptr, len, 100);
	return len;
}

// ESP-01 UART
void send_AT_command(char* cmd)
{
  HAL_UART_Transmit(&huart3, (uint8_t*)cmd, strlen(cmd), HAL_MAX_DELAY);
}

/* USER CODE END 0 */

/**
  * @brief  The application entry point.
  * @retval int
  */
int main(void)
{

  /* USER CODE BEGIN 1 */

  /* USER CODE END 1 */

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* USER CODE BEGIN Init */

  /* USER CODE END Init */

  /* Configure the system clock */
  SystemClock_Config();

  /* USER CODE BEGIN SysInit */

  /* USER CODE END SysInit */

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_USART1_UART_Init();
  MX_USART3_UART_Init();
  MX_TIM3_Init();
  MX_USART2_UART_Init();
  /* USER CODE BEGIN 2 */
  HAL_TIM_PWM_Start(&htim3,TIM_CHANNEL_2); // Add PWM Servo Motor
  HX711_Init();
//  HAL_UART_Transmit(&huart2, "AT+RST\r\n", strlen("AT+RST\r\n"), HAL_MAX_DELAY);

  // ESP-01 Setting
  send_AT_command("AT\r\n");
  HAL_Delay(1000);
  send_AT_command("AT+CWMODE=1\r\n");
  HAL_Delay(5000);
  send_AT_command("AT+CWJAP=\"Park\",\"1q2w3e4r\"\r\n");
  HAL_Delay(10000);

  // Manual Setting
//  send_AT_command("AT+CWDHCP=1,0\r\n");  // DHCP 비활성화 (1: Station, 0: DHCP 비활성화)
//  HAL_Delay(1000);
//  send_AT_command("AT+CIPSTA=\"70.12.246.99\",\"70.12.240.1\",\"255.255.248.0\"\r\n");  // 고정 IP 주소, 게이트웨이 및 서브넷 마스크 설정
//  HAL_Delay(1000);
//  send_AT_command("AT+CIPDNS_DEF=\"168.126.63.1\"\r\n");  // 기본 DNS 서버 설정 (Google DNS 서버)
//  HAL_Delay(1000);
  send_AT_command("AT+CIPSTART=\"TCP\",\"192.168.165.161\",8080\r\n");
  HAL_Delay(5000);

  /* USER CODE END 2 */

  /* Infinite loop */
  /* USER CODE BEGIN WHILE */
  while (1)
  {
    /* USER CODE END WHILE */

    /* USER CODE BEGIN 3 */
	// Servo
	__HAL_TIM_SetCompare(&htim3, TIM_CHANNEL_2, 50);
	HAL_Delay(200);

	__HAL_TIM_SetCompare(&htim3, TIM_CHANNEL_2, 100);
	HAL_Delay(200);


	// AT+CIPSEND : Data length
	send_AT_command("AT+CIPSEND=8\r\n");
	HAL_Delay(1000);
	send_AT_command("Hello");
	HAL_Delay(1000);

	int32_t weight = HX711_Read();
	weight -= 175000;
	char str[32];
	sprintf(str, "%ld\r\n", weight);
	send_AT_command(str);
	HAL_UART_Transmit(&huart2, str, strlen(str), 100);
	HAL_Delay(1000); // 1�????????? ??�?????????
  }
  /* USER CODE END 3 */
}

/**
  * @brief System Clock Configuration
  * @retval None
  */
void SystemClock_Config(void)
{
  RCC_OscInitTypeDef RCC_OscInitStruct = {0};
  RCC_ClkInitTypeDef RCC_ClkInitStruct = {0};

  /** Initializes the RCC Oscillators according to the specified parameters
  * in the RCC_OscInitTypeDef structure.
  */
  RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI;
  RCC_OscInitStruct.HSIState = RCC_HSI_ON;
  RCC_OscInitStruct.HSICalibrationValue = RCC_HSICALIBRATION_DEFAULT;
  RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
  RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSI_DIV2;
  RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL16;
  if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
  {
    Error_Handler();
  }

  /** Initializes the CPU, AHB and APB buses clocks
  */
  RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK|RCC_CLOCKTYPE_SYSCLK
                              |RCC_CLOCKTYPE_PCLK1|RCC_CLOCKTYPE_PCLK2;
  RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
  RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
  RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV2;
  RCC_ClkInitStruct.APB2CLKDivider = RCC_HCLK_DIV1;

  if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_2) != HAL_OK)
  {
    Error_Handler();
  }
}

/* USER CODE BEGIN 4 */
// Load Cell
void HX711_Init(void)
{
    // GPIO 초기?��
    GPIO_InitTypeDef GPIO_InitStruct = {0};

    // SCK ?? ?��?��
    GPIO_InitStruct.Pin = HX711_SCK_PIN;
    GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
    HAL_GPIO_Init(HX711_SCK_PORT, &GPIO_InitStruct);

    // DT ?? ?��?��
    GPIO_InitStruct.Pin = HX711_DT_PIN;
    GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    HAL_GPIO_Init(HX711_DT_PORT, &GPIO_InitStruct);

    // SCK ???�� LOW�?? ?��?��
    HAL_GPIO_WritePin(HX711_SCK_PORT, HX711_SCK_PIN, GPIO_PIN_RESET);
}

int32_t HX711_Read(void)
{
    int32_t count = 0;
    uint8_t i;

    // ?��?��?�� �??�?? ??�??
    while (HAL_GPIO_ReadPin(HX711_DT_PORT, HX711_DT_PIN) == GPIO_PIN_SET);

    for (i = 0; i < 24; i++)
    {
        HAL_GPIO_WritePin(HX711_SCK_PORT, HX711_SCK_PIN, GPIO_PIN_SET);
        count = count << 1;
        HAL_GPIO_WritePin(HX711_SCK_PORT, HX711_SCK_PIN, GPIO_PIN_RESET);
        if (HAL_GPIO_ReadPin(HX711_DT_PORT, HX711_DT_PIN))
            count++;
    }

    // 추�??��?�� ?��?�� ?��?��
    HAL_GPIO_WritePin(HX711_SCK_PORT, HX711_SCK_PIN, GPIO_PIN_SET);
//    count = count ^ 0x800000;  // �???�� 비트 ?��?��
    HAL_GPIO_WritePin(HX711_SCK_PORT, HX711_SCK_PIN, GPIO_PIN_RESET);

    return count;
}
/* USER CODE END 4 */

/**
  * @brief  This function is executed in case of error occurrence.
  * @retval None
  */
void Error_Handler(void)
{
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */
  __disable_irq();
  while (1)
  {
  }
  /* USER CODE END Error_Handler_Debug */
}

#ifdef  USE_FULL_ASSERT
/**
  * @brief  Reports the name of the source file and the source line number
  *         where the assert_param error has occurred.
  * @param  file: pointer to the source file name
  * @param  line: assert_param error line source number
  * @retval None
  */
void assert_failed(uint8_t *file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */
}
#endif /* USE_FULL_ASSERT */
