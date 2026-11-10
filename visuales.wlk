import wollok.game.*

class Visual {
    const rutaImagen
    var posicion = game.origin()

    method image() = rutaImagen
    method position() = posicion

    method moverA(nuevaPosicion) {
        posicion = nuevaPosicion
    }
}


class Clickeable inherits Visual {
    method clickear(juego)
}
class Grilla {
    const columnas
    const filas

    method celdas() = filas.flatMap({ fila => columnas.map({ columna => game.at(columna, fila) }) })

    method capacidad() = self.celdas().size()

    method acomodar(visuales) {
        const celdas = self.celdas()
        var proxima = 0
        visuales.take(self.capacidad()).forEach({ visual =>
            visual.moverA(celdas.get(proxima))
            proxima = proxima + 1
        })
    }
}

object pantalla {

    method mostrar(visuales) {
        visuales.forEach({ visual => game.addVisual(visual) })
    }

    
    method ocultar(visuales) {
        visuales.forEach({ visual => game.removeVisual(visual) })
    }

    method decir(visual, texto) {
        game.say(visual, texto)
    }
}