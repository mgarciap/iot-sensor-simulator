IoT (Internet of Things) input sensor simulator
====================

# Description
This application is part of a Proof of Concept that involves 3 components:
- MQTT Service Broker (https://registry.hub.docker.com/u/mgarciap/mosquitto/)
- Node Red (https://registry.hub.docker.com/u/mgarciap/node-red/), an extremmilly hot web based IoT modeling app which you can use to conect to the Service Broker and debug what it is going on under the hook (among some other awesome things)
- This app which will simulate an magical device which will help you mesure how full is your beer glass and refill it when empty (simulating an input sensor)


# How to run it
There are two alternatives
- Hard one: you'll have to pull every image and run the containers
- Easy one: use fig.sh [1] with a provided configuration file which will download the images, configure access between containers and run them

## Easy one

Install FIG following instructions in www.fig.sh

```
git clone https://github.com/mgarciap/iot-sensor-simulator.git
cd iot-sensor-simulator
fig up
```

Open your browser and go to <you container ip>:9393 and enjoy a cold beer.

You can also check out Node red: <you container ip>:1880


[1] Still didn't migrated to Docker Compese, sorry. It is almost the same
