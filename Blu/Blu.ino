#include <BLEDevice.h>
#include <BLEServer.h>
#include <BLEUtils.h>
#include <BLE2902.h>
#include <ESP32Servo.h>
#include "utils.h"

#define bleServerName "FLUTTER_BLE"
#define SERVICE_UUID "91bad492-b950-4226-aa2b-4ede9fa42f59"
#define direct "D"
#define NUM_LINK_INDEX 1
#define NUM_POS_INDEX 2
#define NUM_LINK 3

const uint8_t servoPin = 5;
const uint8_t q2Pin = 4;
const uint8_t q1Pin = 19;
const uint8_t ledPin = 21;

// Timer variables
unsigned long lastTime = 0;
unsigned long timerDelay = 30000;

Servo base;
Servo q2;
Servo q1;
const int servoVelocity = 10;
int baseLastAngValue = 0;

// Flags
bool deviceConnected = false;
bool isConnecting = false;
bool newPos = false;

DATA x = 0;
DATA *last = &x;

//----- Configurando o BLE
BLECharacteristic positionCh("cba1d466-344c-4be3-ab3f-189f80dd7518", BLECharacteristic::PROPERTY_WRITE);
BLEDescriptor positionDescriptior(BLEUUID((uint16_t)0x2902));
BLEServer *pServer;
BLEService *pService;

class ServerCallback : public BLEServerCallbacks
{
    void onConnect(BLEServer *server)
    {
        Serial.println("Conectado!");
        deviceConnected = true;
        isConnecting = false;
        digitalWrite(ledPin, HIGH);
    }

    void onDisconnect(BLEServer *server)
    {
        Serial.println("Disconectado");
        deviceConnected = false;
        isConnecting = false;
        digitalWrite(ledPin, LOW);
    }
};

void setup()
{
    Serial.begin(115200);
    base.attach(servoPin);
    q1.attach(q1Pin);
    q2.attach(q2Pin);
    base.write(80);
    q2.write(30);
    q1.write(30);
    pinMode(ledPin, OUTPUT);

    Serial.println("Ultima: " + (String)(baseLastAngValue));
    Serial.println("Ultima: " + (String)(baseLastAngValue));
    Serial.println("Iniciando servidor " + (String)(bleServerName));
    BLEDevice::init(bleServerName);
    BLEDevice::setMTU(128);
    initBLE();
}

void initBLE()
{
    isConnecting = true;

    if (pService == nullptr && pServer == nullptr)
    {
        pServer = BLEDevice::createServer();
        pServer->setCallbacks(new ServerCallback());
    }

    pService = pServer->createService(SERVICE_UUID);
    pService->addCharacteristic(&positionCh);
    positionDescriptior.setValue("Positions");
    positionCh.addDescriptor(&positionDescriptior);

    // Start the service
    pService->start();

    // Start advertising
    BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
    pAdvertising->addServiceUUID(SERVICE_UUID);
    pServer->getAdvertising()->start();
    Serial.println("Waiting a client connection to notify...");
}

void loop()
{
    if (deviceConnected)
    {
        int i = 0;
        DATA *data = positionCh.getData();
        if (dataIsNotEqual(data, last))
        {
            ROBOT *robot = createRobot(data);
            int length = getDataLength(robot->numPos, robot->numLink);
            moveRobot(robot);
            recordLastValue(data, length);
        }
    }
    reconnect();
    delay(500);
}

void recordLastValue(DATA *d, int length)
{
    memcpy(last, d, length * sizeof(DATA));
}

void moveRobot(ROBOT *robot)
{
    for (int i = 0; i < robot->numPos; i++)
    {
        POSITION *p = getRobotPos(robot, i);
        Serial.println("Pos " + (String)i);
        printLink(p, robot->numLink);
        base.write((int) p[0]);
        q1.write((int) p[1]);
        q2.write((int) p[2]);
        delay(3000);
    }
}

int moveServo(Servo s, int value, int lastValue)
{
    Serial.println("Ultima10: " + (String)(lastValue));
    if ((lastValue + 1) == value || (lastValue - 1) == value)
        return lastValue;

    if (lastValue < value)
        for (int newPos = lastValue; newPos < value; newPos += servoVelocity)
        {
            Serial.println("Final: " + (String)value + "\nnewPos: " + (String)newPos);
            s.write(newPos > value ? value : newPos);
            delay(100);
        }
    else
        for (uint newPos = lastValue; newPos > value; newPos -= servoVelocity)
        {
            Serial.println("Final: " + (String)value + "\nnewPos: " + (String)newPos);
            s.write(newPos < value ? value : newPos);
            delay(100);
        }
    return value;
}

bool dataIsNotEqual(DATA *cur, DATA *last)
{
    if (cur == nullptr || last == nullptr)
        return false;
    int i = 0;
    for (int i = 0; cur[i] != NULL; i++)
    {
        if (cur[i] != last[i])
            return true;
    }
    return false;
}

void reconnect()
{
    if (!deviceConnected && !isConnecting)
        initBLE();
}
