public class Nodo {
    public var vecinos: [Arista]

    public var id: String

    //Constructor
    public init(_ id: String) {
        self.id = id
        vecinos = []
    }

    //Generador de copia
    public init(copia: Nodo){
        self.vecinos = [Arista]()
        self.id = copia.id
        for arista in copia.vecinos {
            vecinos.append(Arista(copia: arista))
        }
    }

    //Borrar una arista de un nodo
    public func quitar(_ arista: Arista) {
        vecinos.remove(at: vecinos.index { $0 === arista }!)
    }
}

extension Nodo: CustomStringConvertible {
    public var description: String {
        return "Nodo(id: \(id))"
    }
}

extension Nodo: Equatable{
    public static func == (_ lhs: Nodo, rhs: Nodo) -> Bool {
        return lhs.id == rhs.id && lhs.vecinos == rhs.vecinos
    }
}
