import wollok.game.*    
import ingredientes.*

object mostrador { // Mostrador de Cafeteria

    method position() = game.origin()
    method image() = "fondos/fondo_Mostrador.png"
}

object estudianteMostrador{  // Estudiante en el mostrador

    method position() = game.at(6, 2)
    method image() = "juegor1/estudiante_Mostrador3.png"


}

object pedidoReferencia1 {  // Cafe + medialunas

    method position() = game.at(8,2)
    method image() = "juegor1/Cafe_Con_Medialunas.png"
}


// Nivel 1) Estudiante


object estudiante {
    const pedido = [cafe, medialunas]
    const entregado = []

    method hacerPedido() {

        game.say(estudianteMostrador, "Hola, quisiera un café con medialunas")
        game.addVisual(pedidoReferencia1)    
        
        }

    method recibirIngredientes(ingrediente) {
        if (not pedido.contains(ingrediente)) {
            game.say(estudianteMostrador, "Esto no lo pedí")
        } else if (entregado.contains(ingrediente)) {
            game.say(estudianteMostrador, "Ya me lo diste")
        } else {
            entregado.add(ingrediente)
            game.say(estudianteMostrador, "Bien")
        }
    }

    method reiniciar() {
        entregado.clear()
    }

    method resultadoCorrecto() = entregado.size() == pedido.size()
}


