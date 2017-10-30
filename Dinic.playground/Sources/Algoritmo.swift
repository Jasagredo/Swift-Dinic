public func encontrarFlujoBloqueante(_ rr: RedResidual, _ gn: GrafoDeNivel, _ fl: Flujo) -> () {
    while bloqFluxRec(rr, gn, rr.fuente!, Int.max, fl) != nil { //Ejecutamos hasta que no podamos recorrer más en esta red.
    }
}

public func bloqFluxRec(_ rr: RedResidual, _ gn: GrafoDeNivel, _ n: Nodo, _ fv: Int, _ fl: Flujo) -> Int?{
    //Si estamos en el sumidero, aceptamos el flujo que nos llegue
    if n == rr.sumidero! {
        return fv
    }
    //En caso contrario, recorremos las aristas que nos falten (Si una arista aún se puede recorrer, no se habrá sobrepasado su índice porque 
    // habrá habido un return antes del incremento de las aristas superadas)
    for arista in rr.aristasRecorridas[n.id]!..<n.vecinos.count {
        if gn.distancia[n.id]! + 1 == gn.distancia[n.vecinos[arista].vecino.id]! && n.vecinos[arista].capacidad > 0 {
            let edge = n.vecinos[arista]
            let faux = min(fv, edge.capacidad)
            //Obtenemos el flujo que hasta ahora podemos pasar por este camino y llamamos recursivamente al siguiente nodo
            let fvuel = bloqFluxRec(rr, gn, edge.vecino, faux, fl)
            if fvuel != nil {
                //En caso de que hayamos encontrado un camino actualizamos el flujo y cambiamos las capacidades
                fl.setFlujo(origen: n.id, fin: edge.vecino.id, flujo: fl.getFlujo(origen: n.id, fin: edge.vecino.id)! + fvuel!)
                n.vecinos[arista].capacidad = n.vecinos[arista].capacidad - fvuel!
                return fvuel
            }
        }
        rr.aristasRecorridas[n.id] = rr.aristasRecorridas[n.id]! + 1
    }
    return nil
}

public func dinic(_ grafo: Grafo, fuente: Nodo, sumidero: Nodo) -> (Int, Flujo) {
    let flujo = Flujo()
    var fin = false
    // f <- 0 forall e in E
    for nodo in grafo.nodos {
        for arista in nodo.vecinos {
            flujo.setFlujo(origen: nodo.id, fin: arista.vecino.id, flujo: 0)
        }
    }
    while !fin {
        //Obtenemos G_L desde G_f
        let rr = RedResidual(grafo, flujo)
        let gn = GrafoDeNivel(rr)
        gn.consolidar()
        if gn.distanciaSumidero() == -1 {   // if dist(t) = infty
            //Acabar el bucle y devolver el flujo
            fin = true
        } else {
            //Obtener flujo bloqueante y actualizar el flujo actual
            encontrarFlujoBloqueante(rr, gn, flujo)
        }
    }
    return (flujo.flujo(origen: fuente.id), flujo)
}
