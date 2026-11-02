import clientes.*
import escenas.*


class Temporizador {
    const segundosIniciales
    var restante = 0

    method restante() = restante

    method iniciar() {
        restante = segundosIniciales
    }

    method restar(cantidad) {
        restante = (restante - cantidad).max(0)
    }

    method sumar(cantidad) {
        restante += cantidad
    }

    method seAcabo() = restante <= 0
}

class Nivel {
    const cliente
    const reloj
    const property escena
    var pedidoCompleto = false

    method pedidoCompleto() = pedidoCompleto

    method seAcaboElTiempo() = reloj.seAcabo()

    method tiempoRestante() = reloj.restante()

    // Iniciar (o reintentar) siempre deja el nivel desde cero
    method iniciar() {
        reloj.iniciar()
        cliente.reiniciar()
        pedidoCompleto = false
        self.decir(cliente.mensaje())
    }

    method recibirIngrediente(ingrediente) {
        cliente.recibirIngrediente(ingrediente, self)
    }

    method enviarPedido() {
        if (cliente.resultadoCorrecto()) {
            pedidoCompleto = true
        } else {
            cliente.reaccionarAlPedidoIncompleto(self)
        }
    }

    method descontarTiempo() {
        self.restarTiempo(1)
    }

    method restarTiempo(cantidad) {
        reloj.restar(cantidad)
    }

    method sumarTiempo(cantidad) {
        reloj.sumar(cantidad)
    }

    method decir(texto) {
        escena.decir(texto)
    }

    method ingredienteCorrecto() {
        escena.sonarAcierto()
    }
}

// Agrupa lo que cambia de un nivel a otro
class Escenario {
    const property cliente
    const property escena
}


object fabricaDeNiveles {
    const segundosIniciales = 30
    const segundosQueSeRestanPorNivel = 2
    const segundosMinimos = 10

    const escenarios = [
        new Escenario(cliente = estudiante, escena = escena1),
        new Escenario(cliente = maria,      escena = escena2),
        new Escenario(cliente = matias,     escena = escena3)
    ]

    method crearNiveles(cantidad) = (1..cantidad).map({ numero => self.nivelNumero(numero) })

    method nivelNumero(numero) {
        const escenario = escenarios.get((numero - 1) % escenarios.size())
        return new Nivel(
            cliente = escenario.cliente(),
            escena = escenario.escena(),
            reloj = new Temporizador(segundosIniciales = self.segundosDelNivel(numero))
        )
    }

    method segundosDelNivel(numero) =
        (segundosIniciales - (numero - 1) * segundosQueSeRestanPorNivel).max(segundosMinimos)
}