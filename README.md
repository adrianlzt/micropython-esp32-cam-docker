# Micropython build for ESP32 wiht camera

Project to build the ESP32 port of Micropython with camera using Docker.

It uses a [forked repo](https://github.com/adrianlzt/micropython-camera-driver) of github.com/lemariva/micropython-camera-driver to make it work with the latest code of micropython and the Lilygo Camera V1.6.2.

To build micropython:
```
docker build -t micropython-esp32 .
```

To flash the built firmware:
```
docker run --device /dev/ttyACM0 --rm micropython-esp32 idf.py -p /dev/ttyACM0 -D MICROPY_BOARD=ESP32_CAM -D MICROPY_BOARD_DIR=/root/micropython/ports/esp32/boards/ESP32_CAM -B build-ESP32_CAM flash
```
