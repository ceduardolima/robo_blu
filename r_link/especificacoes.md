# Especificações do projeto de robótica

## App

### Robo e Juntas
No app você poderá cria seus próprios robos. Para criar um robo, você deverá definir as juntas, que poderão ser: Rotativa ou translação. Onde em ambas você irá definir os parâmetros DH, seus limites inferiores e superiores e o sentido do movimento.  
  
 Assim a classe das juntas será:  
 ```
 abstract class Link {
   double a;
   double alpha
   Bounds? bounds;
   String name;
   bool inverse = false;
   
   int calculate()
 }
 
 class RLink extends Link {

 }
 
 
 class PLink {
  
 }
 ```
 
 O Robo será:
 
 ```
 class Robot {
 	String name;
 	List<int> initialPosition;
 	List<Link> links;
 	
 	int linksQuantity();
 	Pos toolPosition();
 }
 ```
 
 
 ### Lista de movimentações
 O app deverá listar as posições do robo em sequência e enviar para o controlador para que o robo seja controlado. Para isso, será preciso definir uma lista de posições dos angulos.  
 A classe que armazenará uma posição específica do Robo será:  
 
 ```
 class RobotPosition {
   int linksQuantity;
   List<int> possitions;
   String toSerial(); 
 }
 ```
   
 Após a lista de ser enviada, o app deverá esperar a resposta do controlador para indicar se o processo foi feito com sucesso.
 
 