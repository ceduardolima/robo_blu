#define NUM_LINK_INDEX 1
#define NUM_POS_INDEX 2
//------------Funções utilitárias do robo
// Obtém o número de links
#define getNumOfLink(p) (p[NUM_LINK_INDEX]);
// Obtém o número de posições
#define getNumOfPositions(p) (p[NUM_POS_INDEX]);
// Obtém o tipo da cinemática
#define getKineticType(p) (p[0]);
// Obtém o tamanho do ponteiro DATA
#define getDataLength(numPos, numLink) ((3 + numLink * numPos));
// Obtém o ponteiro POSIÇÃO

// Tipos do robo
typedef uint8_t POSITION;
typedef uint8_t LINK;
typedef uint8_t DATA;

typedef struct
{
    POSITION *pos;
    uint numPos : 4;
    uint numLink : 4;
} ROBOT;

POSITION *getPos(DATA *data, ROBOT *robot, int index)
{
    return (&(data[3 + robot->numLink * index]));
}

ROBOT *createRobot(DATA *data)
{
    ROBOT *robot = (ROBOT *)malloc(sizeof(ROBOT));

    robot->numLink = getNumOfLink(data);
    robot->numPos = getNumOfPositions(data);
    robot->pos = getPos(data, robot, 0);
    return robot;
}

POSITION *getRobotPos(ROBOT *robot, uint index)
{
    return &(robot->pos[robot->numLink * index]);
}

void printLink(POSITION *p, uint8_t numLink)
{
    String linkStr = "";
    for (int i = 0; i < numLink; i++)
        linkStr += "Link " + ((String)i) + (String) ": " + (String)p[i] + (String) " ";
    Serial.println(linkStr);
}
