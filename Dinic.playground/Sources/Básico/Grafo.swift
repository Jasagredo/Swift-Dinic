public class Grafo {
    public var nodos: [Nodo]
    public var fuente: Nodo?
    public var sumidero: Nodo?

    //Constructor
    public init() {
        self.nodos = []
    }

    //Función insert
    public func añadirNodo(_ id: String) -> Nodo {
        let nodo = Nodo(id)
        nodos.append(nodo)
        return nodo
    }

    //Añadir una arista al grafo
    public func añadirArista(_ origen: Nodo, vecino: Nodo, capacidad: Int) {
        let arista = Arista(vecino, capacidad)
        origen.vecinos.append(arista)
    }

    //Devolver el nodo que tenga un determinado id
    public func nodoConId(_ id: String) -> Nodo {
        return nodos.filter { $0.id == id }.first!
    }

}

extension Grafo: Equatable {
    public static func == (_ lhs: Grafo, rhs: Grafo) -> Bool {
        return lhs.nodos == rhs.nodos
    }
}


extension Grafo: CustomStringConvertible {
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
