import wollok.game.*    
import visuales.*
import ingredientes.*
import sonidos.*


object mostrador inherits Visual(rutaImagen = "fondos/fondo_Mostrador.png", posicion = game.origin()) { }

// Estudiantes sentados: son un Visual que por defecto aparece en la celda (6, 2)
class EstudianteSentado inherits Visual(posicion = game.at(6, 2)) { }

const estudianteMostrador = new EstudianteSentado(rutaImagen = "juegor1/estudiante_Mostrador3.png")
const mariaMostrador      = new EstudianteSentado(rutaImagen = "juegor2/maria_Mostrador.png")
const matiasMostrador     = new EstudianteSentado(rutaImagen = "jugador3/matias_Mostrador.png")


// Pedidos de referencias: vusual que por defecto aparece en la celda (8, 2)
class PedidoReferencia inherits Visual(posicion = game.at(8, 2)) { }

const pedidoReferencia1 = new PedidoReferencia(rutaImagen = "juegor1/Cafe_Con_Medialunas.png")
const pedidoReferencia2 = new PedidoReferencia(rutaImagen = "juegor2/hamburguesa.png")
const pedidoReferencia3 = new PedidoReferencia(rutaImagen = "jugador3/helado_cremaOreo_bananaSplit.png")


// CLIENTES
class Cliente {
    const pedido
    const mensaje
    const property estudianteEnMostrador
    const property pedidoReferencia
    const entregado = []

    method decir(texto) {
        game.say(estudianteEnMostrador, texto)
    }

    method hacerPedido() {
        self.decir(mensaje)
        game.addVisual(pedidoReferencia)    
    }

    // lo que pasa cuando le dan un ingrediente que no pidio
    method reaccionarAlError(nivel)

    method recibirIngredientes(ingrediente, nivel) {  
        if (not pedido.contains(ingrediente)) {
            self.reaccionarAlError(nivel)
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

// Personalidades: cada una es una subclase que redefine (override) reaccionarAlError
class ClientePaciente inherits Cliente {
    override method reaccionarAlError(nivel) {
        self.decir("Esto no lo pedí")
    }
}

class ClienteExigente inherits Cliente {
    override method reaccionarAlError(nivel) {
        self.decir("¡Eso no lo pedí! -5 segundos")
        nivel.restarTiempo(5)
    }
}

class ClienteCopado inherits Cliente {
    override method reaccionarAlError(nivel) {
        self.decir("No pasa nada, gracias igual")
    }
}

const estudiante = new ClienteExigente(
    pedido = [cafe, medialunas],
    mensaje = "Hola, quisiera un café con medialunas",
    estudianteEnMostrador = estudianteMostrador, // cliente sentado
    pedidoReferencia = pedidoReferencia1 // pedido del cliente
)

const maria = new ClientePaciente(
    pedido = [carne, cebolla, lechuga, panInferior, panSuperior, queso],
    mensaje = "Hola buenas, quiero ordenar una Hamburguesa completa",
    estudianteEnMostrador = mariaMostrador, 
    pedidoReferencia = pedidoReferencia2 
)

const matias = new ClienteCopado(
    pedido = [cremaOreo, bananaSplit, jarabeChocolate],
    mensaje = "Hola, quisiera un helado de Crema Oreo y Banana split con jarabe de chocolate",
    estudianteEnMostrador = matiasMostrador, 
    pedidoReferencia = pedidoReferencia3
)
