import wollok.game.*    

// Ingredientes Nivel 1
object agua{

    method nombre() = "agua"
    method image() = "juegor1/agua.png"
    method position() = game.at(1, 0)


}

object te{

    method nombre() = "te"
    method image() = "juegor1/te.png"
    method position() = game.at(3, 0)

}

object cafe{

    method nombre() = "cafe"
    method image() = "juegor1/cafe.png"
    method position() = game.at(5, 0)

}


object gaseosa{

    method nombre() = "gaseosa"
    method image() = "juegor1/gaseosa.png"
    method position() = game.at(7, 0)


}

object pan{

    method nombre() = "pan"
    method image() = "juegor1/pan.png"
    method position() = game.at(9, 0)


}

object galletas {

  method nombre() = "galletas"
  method image() = "juego1/galletas.png"
  method position() = game.at(11, 0)

}
object medialunas{

    method nombre() = "medialunas"
    method image() = "juegor1/medialunas.png"
    method position() = game.at(12, 0)

}

object ingredientes1{

    const property lista = [agua,gaseosa,cafe,galletas,te,pan,medialunas]

}


// Ingredientes Nivel 2

// estaListo()