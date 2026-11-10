import clientes.*
import escenas.*
import pedidos.*
import recetas.*



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
    const pedido
    const reloj
    const property escena
    const avisarA 

    method seAcaboElTiempo() = reloj.seAcabo()

    method tiempoRestante() = reloj.restante()

    // Iniciar (o reintentar) siempre deja el nivel desde cero
    method iniciar() {
        reloj.iniciar()
        cliente.atender(pedido)
        escena.prepararPara(cliente)
        self.decir(cliente.mensaje())
    }

    method recibirIngrediente(ingrediente) {
        cliente.recibirIngrediente(ingrediente, self)
    }

    method enviarPedido() {
        if (cliente.resultadoCorrecto()) {
                avisarA.nivelCompletado()
        } else {
            cliente.reaccionarAlPedidoIncompleto(self)
        }
    }

    method descontarTiempo() {
        self.restarTiempo(1)
    }

    method restarTiempo(cantidad) {
        const quedabaTiempo = not reloj.seAcabo()
        reloj.restar(cantidad)
        if (quedabaTiempo and reloj.seAcabo()) { avisarA.sinTiempo() }
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
   // method prepararEscena() { escena.prepararPara(cliente) }
    method visuales() = escena.visuales()
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

    const recetasIniciales = 1
    const nivelesPorRecetaExtra = 2

    const generador = new GeneradorDePedidos(carta = carta, sorteador = azar)

    const escenarios = [
        new Escenario(cliente = estudiante, escena = escena1),
        new Escenario(cliente = maria,      escena = escena2),
        new Escenario(cliente = matias,     escena = escena3)
    ]

   method crearNiveles(cantidad, avisado) = (1..cantidad).map({ numero => self.nivelNumero(numero, avisado) })
   method nivelNumero(numero, avisado) {
        const escenario = escenarios.get((numero - 1) % escenarios.size())
        return new Nivel(
            cliente = escenario.cliente(),
            escena = escenario.escena(),
            pedido = generador.generar(self.recetasDelNivel(numero)),
            reloj = new Temporizador(segundosIniciales = self.segundosDelNivel(numero)),
            avisarA = avisado
        )
    }
    method segundosDelNivel(numero) =
        (segundosIniciales - (numero - 1) * segundosQueSeRestanPorNivel).max(segundosMinimos)
    method recetasDelNivel(numero) =
        recetasIniciales + (numero - 1).div(nivelesPorRecetaExtra)
}