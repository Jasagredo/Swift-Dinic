public class GrafoDeNivel {
    public var nodos = [Nodo]()
    public var distancia = [String:Int]()
    public var sumidero: Nodo?
    public var fuente: Nodo?
    private var red: RedResidual
    fileprivate var consolidado: Bool

    //Constructor
    public init(_ red: RedResidual){
        for nodo in red.nodos{
            self.nodos.append(Nodo(nodo.id))
        }
        self.red = red
        self.consolidado = false
    }

    //Recorrido BFS para la obtención de los niveles
    public func consolidar(){
        self.consolidado = true
        self.fuente = self.nodoConId(red.fuente!.id)
        self.sumidero = self.nodoConId(red.sumidero!.id)
        for nodo in red.nodos{
            let nodoAux = Nodo(nodo.id)
            for arista in nodo.vecinos {
                nodoAux.vecinos.append(Arista(nodoConId(arista.vecino.id),arista.capacidad))
            }
        }

        var queue = Queue<Nodo>()
        var padre = [String:Nodo]()
        queue.enqueue(red.fuente!)

        var nodosVisitados = [String:Bool]()

        for v in red.nodos
        {
            nodosVisitados[v.id] = false
            distancia[v.id] = nil
            padre[v.id] = nil
        }
        nodosVisitados[self.fuente!.id] = true
        distancia[self.fuente!.id] = 0
        padre[self.fuente!.id] = nil
        while !queue.isEmpty {
            let nodo = queue.dequeue()!
            for arista in nodo.vecinos {
                if nodosVisitados[arista.vecino.id] == false {
                    nodosVisitados[arista.vecino.id] = true
                    distancia[arista.vecino.id] = distancia[nodo.id]! + 1
                    padre[arista.vecino.id] = nodo
                    queue.enqueue(arista.vecino)
                }
            }
        }
    }

    //Obtención de la distancia al sumidero
    public func distanciaSumidero() -> Int{
        if !consolidado {
            fatalError("Error. Grafo de nivel no consolidado")
        }
        if sumidero == nil {
            return 0
        }
        let aux = distancia.filter{ $0.0 == sumidero!.id }.first?.value
        return  aux ?? -1
    }

    //Acceso a un nodo con un id determinado
    public func nodoConId(_ id: String) -> Nodo {
        if !consolidado {
            fatalError("Error. Grafo de nivel no consolidado")
        }
        return nodos.filter { $0.id == id }.first!
    }


}

extension GrafoDeNivel: CustomStringConvertible {
    public var description: String {
        var t = ""
        for distancia in distancia {
            t = t + ("\(distancia.key) a distancia de \(distancia.value)\n")
        }
        return t
    }
}
