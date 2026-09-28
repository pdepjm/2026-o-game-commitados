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

class Estudiante {
    const pedido
    const mensaje
    const property estudianteEnMostrador
    const property pedidoReferencia
    var entregado = []

    method hacerPedido() {
        game.say(estudianteEnMostrador, mensaje)
        game.addVisual(pedidoReferencia)    
    }

    method recibirIngredientes(ingrediente) {
        if (not pedido.contains(ingrediente)) {
            game.say(estudianteEnMostrador, "Esto no lo pedí")
        } else if (entregado.contains(ingrediente)) {
            game.say(estudianteEnMostrador, "Ya me lo diste")
        } else {
            entregado.add(ingrediente)
            game.say(estudianteEnMostrador, "Bien")
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
    estudianteEnMostrador = estudianteMostrador,
    pedidoReferencia = pedidoReferencia1
)