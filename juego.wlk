import visuales.*
import botones.*
import niveles.*
import estados.*
import escenas.*
import sonidos.*

object juego {
    
    // Cantidad de niveles de la partida
    const cantidadDeNiveles = 4


    var nivelesPendientes = []
    var estado = estadoIntro

    var resultadoVisible = []

    method nivelActual() = nivelesPendientes.first()
    method esUltimoNivel() = nivelesPendientes.size() == 1

    method clickPantalla(posicion) { estado.procesarClick(self, posicion) }

    method pasoUnSegundo() { estado.pasoUnSegundo(self) }

    method clickearElemento(posicion, elementos) {
        elementos.forEach({ elemento =>
            if (elemento.position() == posicion) elemento.clickear(self)
        })
    }

    method nuevaPartida() {
        nivelesPendientes = fabricaDeNiveles.crearNiveles(cantidadDeNiveles, self)
    }

    // PANTALLA 
    method mostrarNivel() {
        pantalla.mostrar(self.nivelActual().visuales())
    }

    method limpiarPantalla() {
        pantalla.ocultar(self.nivelActual().visuales())
    }

    method mostrarIntro() {
        pantalla.mostrar([imagenIntro, botonIntro])
    }

    method ocultarIntro() {
        pantalla.ocultar([imagenIntro, botonIntro])
    }

    method ocultarResultado() {
        pantalla.ocultar(resultadoVisible)
        resultadoVisible = []
    }

    // FLUJO DEL JUEGO
    method empezar() {
        self.nuevaPartida()
        self.ocultarIntro()
        self.iniciarNivel()
    }

    method iniciarNivel() {
        estado = estadoJugando
        self.nivelActual().iniciar()
        self.mostrarNivel()
    }

    method terminarNivel(nuevoEstado, fondo) {
        estado = nuevoEstado
        self.limpiarPantalla()
        resultadoVisible = [fondo, nuevoEstado.boton()]
        pantalla.mostrar(resultadoVisible)
    }

    method sinTiempo() {
        sonidos.sinTiempo()
        self.terminarNivel(estadoSinTiempo, self.nivelActual().pantallaSinTiempo())
    }

    method nivelCompletado() {
        sonidos.pedidoCorrecto()
        if (self.esUltimoNivel()) {
            self.terminarNivel(estadoFinal, pantallaFinal)
        } else {
            self.terminarNivel(estadoCorrecto, self.nivelActual().pantallaCorrecto())
        }
    }

    method avanzar() {
        self.ocultarResultado()
        nivelesPendientes = nivelesPendientes.drop(1)
        self.iniciarNivel()
    }

    method reintentar() {
        self.ocultarResultado()
        self.iniciarNivel()
    }

    method reiniciar() {
        self.ocultarResultado()
        estado = estadoIntro
        self.mostrarIntro()
    }
}