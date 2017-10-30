public class Flujo {
    public var matrizFlujo = Dictionary<String, Dictionary<String, Int>>()

    //Constructor
    public init(){
        
    }

    //Acceso al valor de un flujo
    public func getFlujo(origen: String, fin: String) -> Int?{
        return matrizFlujo[origen]?[fin]
    }

    //Actualización de un flujo
    public func setFlujo(origen: String, fin: String, flujo: Int) -> (){
        if matrizFlujo[origen] == nil {
            matrizFlujo[origen] = Dictionary<String, Int>()
        }
        matrizFlujo[origen]![fin] = flujo
    }

    //Obtener el flujo por la red
    public func flujo(origen: String) -> Int{
        var f = 0
        for flujoSaliente in matrizFlujo[origen]! {
            f = f + flujoSaliente.value
        }
        return f
    }
}
