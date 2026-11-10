import wollok.game.*
import visuales.*

// INTRO
const imagenIntro = new Visual(rutaImagen = "fondos/Intro.png", posicion = game.origin())

// BOTONES
const botonIntro = new Visual(rutaImagen = "botones/boton_Intro.png", posicion = game.at(5, 1))

object botonEnviar inherits Clickeable(rutaImagen = "botones/boton_enviarPedido3.png", posicion = game.at(15, 1)) {
    override method clickear(juego) {
        juego.nivelActual().enviarPedido()
    }
}

object botonSeguir inherits Clickeable(rutaImagen = "botones/boton_Seguir.png", posicion = game.at(9, 0)) {
    override method clickear(juego) {
        juego.avanzar()
    }
}

object botonReintentar inherits Clickeable(rutaImagen = "botones/boton_Reintentar.png", posicion = game.at(9, 0)) {
    override method clickear(juego) {
        juego.reintentar()
    }
}

object botonReiniciar inherits Clickeable(rutaImagen = "botones/boton_Reiniciar.png", posicion = game.at(5, 1)) {
    override method clickear(juego) {
        juego.reiniciar()
    }
}