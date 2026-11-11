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
        juego.clickearElemento(posicion, juego.nivelActual().clickeables())
    }

    method pasoUnSegundo(juego) {
        juego.nivelActual().descontarTiempo()
    }
}

class EstadoConBoton {
    const property boton

    method procesarClick(juego, posicion) {
        juego.clickearElemento(posicion, [boton])
    }

    method pasoUnSegundo(juego) { }
}

const estadoSinTiempo = new EstadoConBoton(boton = botonReintentar)

const estadoCorrecto = new EstadoConBoton(boton = botonSeguir)

const estadoFinal = new EstadoConBoton(boton = botonReiniciar)