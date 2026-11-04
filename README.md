# Termómetro digital con PIC16F887

Estación de temperatura y humedad simulada en Proteus 8. Lee un sensor DHT11 cada 10 s, muestra 13 vistas en un LCD 16x2 por I2C y guarda los registros en una tarjeta microSD.

- **Universidad Cooperativa de Colombia**, Facultad de Ingeniería, Programa de Ingeniería de Software
- **Integrantes:** Dylan Nuñez, Andrés Vega, Giovanny Poveda
- **Docente:** Ing. Diego Restrepo
- **Video del proyecto:** https://youtu.be/WXi4rC4VkVw

## Contenido

| Ruta | Qué es |
|---|---|
| `firmware/main.c` | Código fuente depurado |
| `firmware/original/main_original.c` | Código original, para comparar |
| `firmware/build.bat` | Compila `main.c` con XC8 |
| `hex/termometro_depurado.hex` | Firmware ya compilado, listo para cargar en Proteus |
| `proteus/termometro_analitico_16f887.pdsprj` | Proyecto de Proteus, requiere los cambios indicados abajo |
| `proteus/CONEXIONES.md` | Lista de conexiones del circuito |
| `docs/` | Informe de simulación en PDF y Word |

## Requisitos

- Proteus 8 Professional, con los modelos PIC16F887, DHT11, PCF8574A, LM016L y tarjeta SD/MMC
- Solo para recompilar: MPLAB XC8 y el paquete `PIC16Fxxx_DFP`. Se compiló con XC8 v4.00 y el DFP 1.8.167

## Cómo probarlo

El proyecto incluido es la versión original y necesita tres cambios antes de simular. El reloj de U1 ya está en 20 MHz.

1. Abre `proteus/termometro_analitico_16f887.pdsprj` en Proteus.
2. Doble clic en **U1 (PIC16F887)** y, en **Program File**, selecciona `hex/termometro_depurado.hex`. La ruta guardada es de MPLAB X y no existe.
3. Doble clic en **SD1** y, en **Card Image File**, escribe `sdcard.mmc`. La ruta guardada no existe y provoca el error `Fatal simulation error(s) encountered`.
4. Borra el cable que sale del **pin 24 (RC5)** y conecta el **pin 17 (RC2)** a la línea **DATA** del DHT11. El cable cruza SCL y SDA, pero no debe quedar un punto de unión en esos cruces.
5. Guarda y ejecuta la simulación.

### Qué se espera ver

| Momento | LCD |
|---|---|
| Arranque | `I2C SCAN OK` y `LCD:0x38 DEV:01` (`DEV:02` si se agrega el DS1307) |
| Inicio | `PIC16F887 20MHz` y `INICIANDO...` |
| Funcionamiento | `T:xxC H:xx% OK` y `N:000000 SD:OK` |

Botones: RB4 vista anterior, RB6 vista siguiente, RB5 tomar una muestra ahora.

### Códigos de error del DHT11

| Código | Significado |
|---|---|
| E1 | El sensor no respondió al inicio de la lectura |
| E2 | Tiempo agotado leyendo los bits |
| E3 | Falló la suma de verificación |
| E4 | Valor fuera de rango |

## Estado del proyecto

- **Error E1 identificado:** el proyecto de Proteus conecta DATA a RC5 (pin 24), pero el firmware lee RC2 (pin 17). El detalle está en la sección 5 del informe.
- **Corrección pendiente de confirmar:** el proyecto se subió sin modificar. Todavía no se ha repetido la simulación con DATA en el pin 17.
- **Código depurado sin simular:** `main.c` compila sin errores, pero aún no se ha ejecutado en Proteus. Si falla, compara con `firmware/original/main_original.c`.
- **DS1307 ausente:** el reloj no estaba en el esquemático original. Sin él, la vista RELOJ muestra `--`.

## Recompilar

En Windows, desde la carpeta `firmware`:

```bat
build.bat "C:\ruta\al\pack\Microchip\PIC16Fxxx_DFP\1.8.167\xc8"
```

El `.hex` queda en `firmware/build/main.hex`. Para compilar con MPLAB X, crea un proyecto para el PIC16F887 con compilador XC8 y agrega `firmware/main.c`.
