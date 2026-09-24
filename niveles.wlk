
import wollok.game.*    
import ingredientes.*
import clientes.*


object imagenIntro{

    // Posicion
    method position() = game.origin()

    // Imagen: Intro 
    method image() = "fondos/Intro.png"


}

// BOTONES

object botonIntro{

    method position() = game.at(5, 1)
  
    method image() = "botones/boton_Intro.png"


}

object botonEnviar{

    method position() = game.at(15, 1)
    method image() = "botones/boton_enviarPedido3.png"


}

object botonSeguir{

    method position() = game.at(9, 0)
    method image() = "botones/boton_Seguir.png"

}

object botonReintentar{

    method position() = game.at(9, 0)
    method image() = "botones/boton_Reintentar.png"

}

// PEDIDOS

object pedidoCorrecto1{

    method position() = game.origin()
    method image() = "juegor1/Pedido_Correcto.png"

}

object pedidoFueraDeTiempo1{

    method position() = game.origin()
    method image() = "juegor1/Pedido_SinTiempo.png"

}

///////////////////////// Nivel 1 //////////////////////////////////////7

object nivel1 {
    var estado = "intro"     // intro, jugando, correcto, sinTiempo
    var tiempo = 30          // tiempo restante
    const segundos = 30      // tiempo máximo

    const property listaIngredientes = ingredientes1.lista()

    // Método que recibe los clicks

    method clickPantalla(posicion) {
    if (estado == "intro") {
        self.procesarIntro()
    } else if (estado == "jugando") {
        self.procesarJuego(posicion)
    } else if (estado == "correcto") {
        self.procesarCorrecto(posicion)
    } else if (estado == "sinTiempo") {
        self.procesarSinTiempo(posicion)
    }
    }

    //  Estados (Intro,Jugando,Correcto,Sin Tiempo)

    method procesarIntro() {
        game.removeVisual(imagenIntro)
        game.removeVisual(botonIntro)
        self.empezar()
    }

    method procesarJuego(posicion) {

            // si clickeo en boton enviar
        if (posicion == botonEnviar.position()) {
            if (estudiante.resultadoCorrecto()) { 
                         // Pedido completo
                self.terminarNivel("correcto", pedidoCorrecto1, botonSeguir)
            } else { 
                         // Pedido incompleto
            game.say(estudianteMostrador, "Mi pedido está incompleto")
            
            }
        } 
              
        else {   // si clikeo en ingredientes 

            listaIngredientes.forEach({ ingrediente =>
                if (ingrediente.position() == posicion) estudiante.recibirIngredientes(ingrediente)
            })
        }
    }

        // clickeo en botonSeguir de pedidoCorrecto1
    method procesarCorrecto(posicion) {
        if (posicion == botonSeguir.position()) {
          //    INICIA NIVEL 2
        }
    }
       // clickeo en botonReintentar SinTiempo
    method procesarSinTiempo(posicion) {
        if (posicion == botonReintentar.position()) {
            self.reintentar()
        }
    }

    // --- Tiempo ---
    method pasoUnSegundo() {

            // Se ejecuta cada segundo desde onTick
        if (estado == "jugando") {
            tiempo = tiempo - 1
            if (tiempo <= 0) {
                self.terminarNivel("sinTiempo", pedidoFueraDeTiempo1, botonReintentar)
            }
        }
    }

    //  (Inicio,Fin,Reintentar)

    method empezar() {
        estado = "jugando"
        tiempo = segundos

        game.addVisual(mostrador)
        game.addVisual(estudianteMostrador)
        listaIngredientes.forEach({ ing => game.addVisual(ing) })
        game.addVisual(botonEnviar)
        estudiante.hacerPedido()  

    }

    method terminarNivel(nuevoEstado, fondo, boton) {
        estado = nuevoEstado
        
        // limpiar pantalla
        game.removeVisual(mostrador)
        game.removeVisual(estudianteMostrador)
        game.removeVisual(botonEnviar)
        game.removeVisual(pedidoReferencia1)   
        listaIngredientes.forEach({ ing => game.removeVisual(ing) })
        
        // resultado y boton 
        game.addVisual(fondo)
        game.addVisual(boton)

    }

    method reintentar() {

        game.removeVisual(pedidoFueraDeTiempo1)
        game.removeVisual(botonReintentar)
        estudiante.reiniciar()
        self.empezar()  // reinicia nivel
    }
}