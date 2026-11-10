import ingredientes.*
import pedidos.*
import recetas.* 


class Cliente {

    const property pedido
    // Cada personalidad puede redefinir su saludo
    method saludo() = "Hola,"
    method mensaje() = self.saludo() + " " + pedido.descripcion()
    method recibirIngrediente(ingrediente, nivel) {
        if (not pedido.pide(ingrediente)) {
            self.reaccionarAlError(nivel)
        } else if (pedido.yaTiene(ingrediente)) {
            self.reaccionarAlRepetido(nivel)
        } else {
            pedido.agregar(ingrediente)
            nivel.ingredienteCorrecto()
            self.reaccionarAlCorrecto(nivel)
        }
    }

    method reaccionarAlError(nivel)

    method reaccionarAlRepetido(nivel) { nivel.decir("Ya me lo diste") }
    method reaccionarAlCorrecto(nivel) { nivel.decir("Bien") }
    method reaccionarAlPedidoIncompleto(nivel) { nivel.decir("Mi pedido está incompleto") }

    method ingredientesPedidos() = pedido.ingredientes()
    method recetasPedidas() = pedido.recetas()

    // ingredientes que todavía no recibio
    method ingredientesFaltantes() = pedido.faltantes()

    method reiniciar() {
        pedido.reiniciar()
    }

    method resultadoCorrecto() = pedido.estaCompleto()
}

// Tolera algunos errores y recién después se cansa
class ClientePaciente inherits Cliente {
    const erroresQueTolera = 2
    var errores = 0

    override method reaccionarAlError(nivel) {
        errores += 1
        if (errores <= erroresQueTolera) {
            nivel.decir("Esto no lo pedí, tranqui, sigo esperando")
        } else {
            nivel.decir("Ya me estoy cansando... -2 segundos")
            nivel.restarTiempo(2)
        }
    }

    override method reiniciar() {
        super()
        errores = 0
    }
}

// los errores y los repetidos restan tiempo
class ClienteExigente inherits Cliente {
    var errores = 0

    method penalizar(motivo, nivel) {
        errores += 1
        const segundos = 3 + (errores - 1) * 2
        nivel.decir(motivo + " -" + segundos + " segundos")
        nivel.restarTiempo(segundos)
    }

    override method reaccionarAlError(nivel) {
        self.penalizar("¡Eso no lo pedí!", nivel)
    }

    override method reaccionarAlRepetido(nivel) {
        self.penalizar("¡Eso ya me lo diste!", nivel)
    }

    override method reiniciar() {
        super()
        errores = 0
    }
}

// Avisa qué ingrediente falta y premia ingredintes correcto con tiempo extra
class ClienteCopado inherits Cliente {

    override method reaccionarAlError(nivel) {
        if (self.ingredientesFaltantes().isEmpty()) {
            nivel.decir("No pasa nada, ya tengo todo. ¡Mandalo!")
        } else {
            nivel.decir("No pasa nada, me falta " + self.ingredientesFaltantes().first().textoParaMostrar())
        }
    }

    override method reaccionarAlCorrecto(nivel) {
        nivel.decir("¡Genial! +1 segundo")
        nivel.sumarTiempo(1)
    }

    override method reaccionarAlPedidoIncompleto(nivel) {
        nivel.decir("Todavía me falta " + self.ingredientesFaltantes().first().textoParaMostrar())
    }
}

// CLIENTES DEL JUEGO
const estudiante = new ClienteExigente(
    pedido = new Pedido(recetas = [cafeConMedialunas, heladoOreoBanana])
)
const maria = new ClientePaciente(
    pedido = new Pedido(recetas = [hamburguesaCompleta,cafeConMedialunas])
)

const matias = new ClienteCopado(
    pedido = new Pedido(recetas = [heladoOreoBanana])
)