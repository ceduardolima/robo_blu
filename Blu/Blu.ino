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

// Timer variables
unsigned long lastTime = 0;
unsigned long timerDelay = 30000;

Servo base;
const int servoVelocity = 5;

// Flags
bool deviceConnected = false;
bool isConnecting = false;
bool newPos = false;

DATA x = 0;
DATA *last = &x;

//----- Configurando o BLE
BLECharacteristic positionCh("cba1d466-344c-4be3-ab3f-189f80dd7518", BLECharacteristic::PROPERTY_WRITE);
BLEDescriptor positionDescriptior(BLEUUID((uint16_t)0x2902));
void moveServo(Servo s, POSITION *p, uint8_t index)
{
}
BLEServer *pServer;
BLEService *pService;

class ServerCallback : public BLEServerCallbacks
{
    void onConnect(BLEServer *server)
    {
        Serial.println("Conectado!");
        deviceConnected = true;
        isConnecting = false;
    }

    void onDisconnect(BLEServer *server)
    {
        Serial.println("Disconectado");
        deviceConnected = false;
        isConnecting = false;
    }
};

void setup()
{
    Serial.begin(115200);
    base.attach(servoPin);
    base.write(0);
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
            uint8_t length = getDataLength(robot->numPos, robot->numLink);
            recordLastValue(data, length);
            moveRobot(robot);
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
        moveServo(base, p[0]);
        delay(50);
    }
}

void moveServo(Servo s, int value)
{
    int lastValue = s.read();
    if (lastValue < value)
        for (int newPos = lastValue; newPos < value; newPos += servoVelocity)
        {
            Serial.println("Final: " + (String)value + "\nnewPos: " + (String)newPos);
            s.write(newPos > value ? value : newPos);
            delay(50);
        }
    else
        for (uint newPos = lastValue; newPos > value; newPos -= servoVelocity)
        {
            Serial.println("Final: " + (String)value + "\nnewPos: " + (String)newPos);
            s.write(newPos < value ? value : newPos);
            delay(500);
        }
}

bool dataIsNotEqual(DATA *cur, DATA *last)
{
    if (cur == nullptr || last == nullptr)
        return false;
    DATA b = cur[0];
    int i = 0;
    for (int i = 0; b != NULL; i++)
        if (b != last[i])
            return true;
        else
            b = cur[i];
    return false;
}

void reconnect()
{
    if (!deviceConnected && !isConnecting)
        initBLE();
}
