import botones.*
import sonidos.*


object estadoIntro {
    method procesarClick(juego, posicion) {
        // También se inicia desde el programa; si ya estaba iniciada, no hace nada
        sonidos.iniciarMusica()
        juego.empezar()
    }

    method pasoUnSegundo(juego) { }
}

object estadoJugando {
    method procesarClick(juego, posicion) {
        juego.clickearElemento(posicion, juego.nivelActual().escena().clickeables())
        juego.verificarNivel()
    }

    method pasoUnSegundo(juego) {
        juego.nivelActual().descontarTiempo()
        juego.verificarNivel()
    }
}

class EstadoConBoton {
    const property boton

    method procesarClick(juego, posicion) {
        juego.clickearElemento(posicion, [boton])
    }

    method pasoUnSegundo(juego) { }
}

object estadoSinTiempo inherits EstadoConBoton(boton = botonReintentar) { }

object estadoCorrecto inherits EstadoConBoton(boton = botonSeguir) { }

object estadoFinal inherits EstadoConBoton(boton = botonReiniciar) { }