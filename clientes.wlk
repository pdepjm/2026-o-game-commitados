import wollok.game.*    
import ingredientes.*


object mostrador {
    method position() = game.origin()
    method image() = "fondos/fondo_Mostrador.png"
}

object estudianteMostrador{
    method position() = game.at(6, 2)
    method image() = "juegor1/estudiante_Mostrador3.png"
}

object pedidoReferencia1 {
    method position() = game.at(8, 2)
    method image() = "juegor1/Cafe_Con_Medialunas.png"
}

object paciente {
    method reaccionarAlError(estudiante, nivel) {
        estudiante.decir("Esto no lo pedí")
    }
}

object exigente {
    method reaccionarAlError(estudiante, nivel) {
        estudiante.decir("¡Eso no lo pedí! -5 segundos")
        nivel.restarTiempo(5)
    }
}

object copado {
    method reaccionarAlError(estudiante, nivel) {
        estudiante.decir("No pasa nada, gracias igual")
    }
}

class Estudiante {
    const pedido
    const mensaje
    const personalidad
    const property estudianteEnMostrador
    const property pedidoReferencia
    var entregado = []

    method decir(texto) {
        game.say(estudianteEnMostrador, texto)
    }

    method hacerPedido() {
        self.decir(mensaje)
        game.addVisual(pedidoReferencia)    
    }

    method recibirIngredientes(ingrediente, nivel) {
        if (not pedido.contains(ingrediente)) {
            personalidad.reaccionarAlError(self, nivel)
        } else if (entregado.contains(ingrediente)) {
            self.decir("Ya me lo diste")
        } else {
            entregado.add(ingrediente)
            self.decir("Bien")
        }
    }

    method reiniciar() {
        entregado.clear()
    }

    method resultadoCorrecto() = entregado.size() == pedido.size()
}

const estudiante = new Estudiante(
    pedido = [cafe, medialunas],
    mensaje = "Hola, quisiera un café con medialunas",
    personalidad = exigente,
    estudianteEnMostrador = estudianteMostrador,
    pedidoReferencia = pedidoReferencia1
)