public class Arista {
    public var vecino: Nodo
    public var capacidad: Int

    //Inicializador
    public init(_ vecino: Nodo, _ capacidad: Int) {
        self.vecino = vecino
        self.capacidad = capacidad
    }

    //Generador de copias
    public init(copia: Arista){
        self.vecino = copia.vecino
        self.capacidad = copia.capacidad
    }
}

extension Arista: Equatable { //Comparación entre aristas
    static public func == (_ lhs: Arista, rhs: Arista) -> Bool {
        return lhs.vecino == rhs.vecino && lhs.capacidad == rhs.capacidad
    }
}
