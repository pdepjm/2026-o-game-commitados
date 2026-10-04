import wollok.game.*

object sonidos {

    // Musica de la cafeteria  (Todo el juego)
    var musica = null

    method iniciarMusica() {
        if (musica == null) {
            musica = game.sound("Sonidos/Bar_Ambiente.mp3")
            musica.shouldLoop(true)
            musica.volume(0.4)
            musica.play()
        }
    }

    method efecto(sonido, volumen) {
        const audio = game.sound(sonido)
        audio.volume(volumen)
        audio.play()
    }

    // Efectos de sonidos para: 
    method ingredienteCorrecto() { self.efecto("Sonidos/Ingrediente_Correcto.mp3", 0.3) }
    method pedidoCorrecto()      { self.efecto("Sonidos/Pedido_Correcto.wav", 0.1) }
    method sinTiempo()           { self.efecto("Sonidos/Pedido_Sin_Tiempo.wav", 0.1) }


}