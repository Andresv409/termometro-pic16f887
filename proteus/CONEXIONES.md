# Conexiones del circuito

Pines según `firmware/main.c`. El microcontrolador es U1, PIC16F887 (DIL40), a 20 MHz.

## Sensor DHT11 (U3)

| DHT11 | Conexión |
|---|---|
| VDD | +5 V |
| DATA | **RC2, pin 17**, con pull-up de 4.7 kΩ (R4) a +5 V |
| GND | Tierra |

> En el esquemático original DATA iba a RC5 (pin 24), lo que causaba el error E1. RC5 debe quedar libre.

## LCD por I2C

| PIC | PCF8574A (U2) |
|---|---|
| RC3/SCL, pin 18 | SCL, con pull-up de 4.7 kΩ (R1) a +5 V |
| RC4/SDA, pin 23 | SDA, con pull-up de 4.7 kΩ (R2) a +5 V |

A0, A1 y A2 del PCF8574A van a tierra (dirección 0x38).

| PCF8574A | LCD LM016L |
|---|---|
| P0 | RS |
| P1 | RW |
| P2 | E |
| P4 | D4 |
| P5 | D5 |
| P6 | D6 |
| P7 | D7 |

P3 controla la luz de fondo. D0 a D3 del LCD van a tierra.

## Tarjeta SD (SD1)

| PIC | SD |
|---|---|
| RB0, pin 33 | DO (MISO) |
| RB1, pin 34 | DI (MOSI) |
| RB2, pin 35 | CLK |
| RB3, pin 36 | CS |

## Botones

Cada botón conecta el pin a tierra. El firmware activa las resistencias pull-up internas.

| PIC | Función |
|---|---|
| RB4, pin 37 | Vista anterior |
| RB5, pin 38 | Tomar muestra ahora |
| RB6, pin 39 | Vista siguiente |

RB7 (pin 40) no se usa.

## Reset

RE3/MCLR (pin 1) con pull-up de 10 kΩ (R3) a +5 V y botón a tierra.

## Opcionales

| Componente | Conexión | Sin él |
|---|---|---|
| RTC DS1307 | SDA y SCL en el mismo bus I2C | La vista RELOJ muestra `--` |
| LED de actividad | RD0, pin 19 | Sin indicador de actividad |
