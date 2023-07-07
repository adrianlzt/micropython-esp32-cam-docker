# Micropython build for ESP32

Project to build the ESP32 port of Micropython using Docker.

To build micropython:
```
docker build -t micropython-esp32 .
```

To flash the built firmware:
```
docker run --device /dev/ttyACM0 --rm micropython-esp32 idf.py -p /dev/ttyACM0 flash
```
