import wollok.game.*    

class Ingrediente {
    const nombreIngrediente
    const rutaImagen
    const posicion

    method nombre() = nombreIngrediente
    method image() = rutaImagen
    method position() = posicion

    method clickear(nivel) {
        nivel.recibirIngrediente(self)
    }
}

const agua = new Ingrediente(nombreIngrediente = "agua", rutaImagen = "juegor1/agua.png", posicion = game.at(1, 0))
const te = new Ingrediente(nombreIngrediente = "te", rutaImagen = "juegor1/te.png", posicion = game.at(3, 0))
const cafe = new Ingrediente(nombreIngrediente = "cafe", rutaImagen = "juegor1/cafe.png", posicion = game.at(5, 0))
const gaseosa = new Ingrediente(nombreIngrediente = "gaseosa", rutaImagen = "juegor1/gaseosa.png", posicion = game.at(7, 0))
const pan = new Ingrediente(nombreIngrediente = "pan", rutaImagen = "juegor1/pan.png", posicion = game.at(9, 0))
const galletas = new Ingrediente(nombreIngrediente = "galletas", rutaImagen = "juegor1/galletas.png", posicion = game.at(11, 0))
const medialunas = new Ingrediente(nombreIngrediente = "medialunas", rutaImagen = "juegor1/medialunas.png", posicion = game.at(12, 0))

object ingredientes1 {
    const property lista = [agua, gaseosa, cafe, galletas, te, pan, medialunas]
}

// Ingredientes Nivel 2
// estaListo()
