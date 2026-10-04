import wollok.game.*    
import ingredientes.*
import sonidos.*


object mostrador {
    method position() = game.origin()
    method image() = "fondos/fondo_Mostrador.png"
}

// Estudiantes sentados
class EstudianteSentado {
    const rutaImagen
    const posicion = game.at(6, 2)

    method position() = posicion
    method image() = rutaImagen
}

const estudianteMostrador = new EstudianteSentado(rutaImagen = "juegor1/estudiante_Mostrador3.png")
const mariaMostrador      = new EstudianteSentado(rutaImagen = "juegor2/maria_Mostrador.png")
const matiasMostrador     = new EstudianteSentado(rutaImagen = "jugador3/matias_Mostrador.png")


// Pedidos de referencias
class PedidoReferencia {
    const rutaImagen
    const posicion = game.at(8, 2)

    method position() = posicion
    method image() = rutaImagen
}

const pedidoReferencia1 = new PedidoReferencia(rutaImagen = "juegor1/Cafe_Con_Medialunas.png")
const pedidoReferencia2 = new PedidoReferencia(rutaImagen = "juegor2/hamburguesa.png")
const pedidoReferencia3 = new PedidoReferencia(rutaImagen = "jugador3/helado_cremaOreo_bananaSplit.png")



// personalidad
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

    ///////////////////////// MODIFICAR recibirIngredientes////////////////////7

    method recibirIngredientes(ingrediente, nivel) {  
        if (not pedido.contains(ingrediente)) {
            personalidad.reaccionarAlError(self, nivel)
        } else if (entregado.contains(ingrediente)) {
            self.decir("Ya me lo diste")
        } else {
            entregado.add(ingrediente)
            sonidos.ingredienteCorrecto()
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
    estudianteEnMostrador = estudianteMostrador, // cliente sentado
    pedidoReferencia = pedidoReferencia1 // pedido del cliente
)

const maria = new Estudiante(
    pedido = [carne, cebolla, lechuga, panInferior, panSuperior, queso],
    mensaje = "Hola buenas, quiero ordenar una Hamburguesa completa",
    personalidad = paciente,
    estudianteEnMostrador = mariaMostrador, 
    pedidoReferencia = pedidoReferencia2 
)

const matias = new Estudiante(
    pedido = [cremaOreo, bananaSplit, jarabeChocolate],
    mensaje = "Hola, quisiera un helado de Crema Oreo y Banana split con jarabe de chocolate",
    personalidad = copado,
    estudianteEnMostrador = matiasMostrador, 
    pedidoReferencia = pedidoReferencia3
)