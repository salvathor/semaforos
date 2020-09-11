import UIKit

/*
 Estructura:

 El semáforo está compuesto por:

 - Un contador (valor) que le permite al semáforo saber cuántos subprocesos pueden usar su (s) recurso (s)
 - Una cola FIFO para rastrear los subprocesos que esperan el recurso
 
 
 Solicitud de recursos: wait()

 Cuando el semáforo recibe una solicitud, comprueba si su valor (parametro) es mayor a cero. En caso de ser asi, el semáforo lo decrementa y da luz verde al hilo. De lo contrario, manda el hilo al final de su cola;
 
 
 Liberación de recursos: signal()

 Una vez que el semáforo recibe una señal, comprueba si su cola FIFO tiene subprocesos, si los hay, entonces el semáforo lanza el primer hilo y le da luz verde de lo contrario incrementa su contador.


 Declaracion:
  let semaphore = DispatchSemaphore(value: 1)

 Solicitud de recurso:
  semaphore.wait()

 Liberacion de recurso:
  semaphore.signal()
 
  */

//Ejemplo sin semaforos

//let prioridadAlta = DispatchQueue.global(qos: .utility)
//let prioridadBaja = DispatchQueue.global(qos: .utility)
//
//func asyncTask(queue: DispatchQueue, p: String){
//  queue.async {
//    for i in 0...10{
//      print(p,i)
//    }
//  }
//}

//asyncTask(queue: prioridadAlta, p: "🟢")
//asyncTask(queue: prioridadBaja, p: "🔴")

//Ejemplo con semaforos

let prioridad1 = DispatchQueue.global(qos: .utility)
let prioridad2 = DispatchQueue.global(qos: .utility)

let semaforo = DispatchSemaphore(value: 2)

func asyncTask(queue: DispatchQueue, p: String){
  queue.async {

    print("\(p) en espera")
    semaforo.wait()

    for i in 0...10{
      print(p,i)
    }

    print("\(p) liberado")
    semaforo.signal()
  }
}

asyncTask(queue: prioridad1, p: "🟢")
asyncTask(queue: prioridad2, p: "🔴")
asyncTask(queue: prioridad1, p: "🟣")
asyncTask(queue: prioridad2, p: "🟡")
