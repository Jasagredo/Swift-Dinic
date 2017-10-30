public class RedResidual {
    public var nodos: [Nodo]
    public var fuente: Nodo?
    public var sumidero: Nodo?
    public var aristasRecorridas: [String:Int]

    //Constructor
    public init(_ grafo: Grafo, _ flujo: Flujo){
        self.aristasRecorridas = [String:Int]()
        self.nodos = [Nodo]()
        //Copia de los nodos
        for nodo in grafo.nodos{
            self.nodos.append(Nodo(nodo.id))
            self.aristasRecorridas[nodo.id] = 0
        }
        //Copia de la fuente y del sumidero
        self.fuente = self.nodoConId(grafo.fuente!.id)
        self.sumidero = self.nodoConId(grafo.sumidero!.id)
        //Cálculo de la capacidad residual y creación de la arista si cf > 0
        for nodo in grafo.nodos {
            for arista in nodo.vecinos {
                if flujo.getFlujo(origen: nodo.id, fin: arista.vecino.id) != nil {
                    let cf = arista.capacidad - flujo.getFlujo(origen: nodo.id, fin: arista.vecino.id)!
                    if cf > 0 {
                        self.nodoConId(nodo.id).vecinos.append(Arista(nodoConId(arista.vecino.id), cf))
                    }
                }
            }
        }
    }

    //Acceso a un nodo con un id determinado
    public func nodoConId(_ id: String) -> Nodo {
        return nodos.filter { $0.id == id }.first!
    }
}

extension RedResidual: CustomStringConvertible {
    public var description: String {
        var t = ""
        for nodo in nodos {
            for arista in nodo.vecinos {
                t = t + "\n\(nodo) - \(arista.capacidad) -> \(arista.vecino)"
            }
        }
        return t
    }
}
