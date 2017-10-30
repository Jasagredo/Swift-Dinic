let grafo = Grafo()

//Creación de los nodos
grafo.añadirNodo("s")
grafo.añadirNodo("e1")
grafo.añadirNodo("e2")
grafo.añadirNodo("e3")
grafo.añadirNodo("e4")
grafo.añadirNodo("e5")
grafo.añadirNodo("t")

//Creación de las aristas
grafo.fuente = grafo.nodoConId("s")
grafo.añadirArista(grafo.nodoConId("s"), vecino: grafo.nodoConId("e1"), capacidad: 10)
grafo.añadirArista(grafo.nodoConId("s"), vecino: grafo.nodoConId("e2"), capacidad: 15)
grafo.añadirArista(grafo.nodoConId("e1"), vecino: grafo.nodoConId("e4"), capacidad: 7)
grafo.añadirArista(grafo.nodoConId("e1"), vecino: grafo.nodoConId("e3"), capacidad: 9)
grafo.añadirArista(grafo.nodoConId("e2"), vecino: grafo.nodoConId("e1"), capacidad: 16)
grafo.añadirArista(grafo.nodoConId("e2"), vecino: grafo.nodoConId("e5"), capacidad: 2)
grafo.añadirArista(grafo.nodoConId("e3"), vecino: grafo.nodoConId("e5"), capacidad: 20)
grafo.añadirArista(grafo.nodoConId("e4"), vecino: grafo.nodoConId("e3"), capacidad: 6)
grafo.añadirArista(grafo.nodoConId("e4"), vecino: grafo.nodoConId("t"), capacidad: 10)
grafo.añadirArista(grafo.nodoConId("e5"), vecino: grafo.nodoConId("t"), capacidad: 7)
grafo.sumidero = grafo.nodoConId("t")

//Ejecución del algoritmo
let fm = dinic(grafo, fuente: grafo.fuente!, sumidero: grafo.sumidero!)
print("Flujo máximo = \(fm.0)")
print("Flujos por la red: \(fm.1.matrizFlujo)")