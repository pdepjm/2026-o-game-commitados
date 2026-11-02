import wollok.game.*

class Visual {
    const rutaImagen
    const posicion

    method image() = rutaImagen
    method position() = posicion
}


class Clickeable inherits Visual {
    method clickear(juego)
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