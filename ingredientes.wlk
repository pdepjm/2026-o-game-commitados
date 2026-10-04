import wollok.game.*    

class Ingrediente {
    const nombreIngrediente
    const rutaImagen
    const posicion

    // getters de los ingredientes 

    method nombre() = nombreIngrediente
    method image() = rutaImagen
    method position() = posicion

    method clickear(nivel) {
        nivel.recibirIngrediente(self) // self es el ingrediente  clickeado
    }
}

// Ingredientes Nivel 1
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

const carne = new Ingrediente(nombreIngrediente = "carne", rutaImagen = "juegor2/carne_cocida.png", posicion = game.at(1, 0))
const cebolla = new Ingrediente(nombreIngrediente = "cebolla", rutaImagen = "juegor2/cebolla_cortada.png", posicion = game.at(3, 0))
const lechuga = new Ingrediente(nombreIngrediente = "lechuga", rutaImagen = "juegor2/lechuga_1_cruda.png", posicion = game.at(5, 0))
const panInferior = new Ingrediente(nombreIngrediente = "panInferior", rutaImagen = "juegor2/pan_inferior.png", posicion = game.at(7, 0))
const panSuperior = new Ingrediente(nombreIngrediente = "panSuperior", rutaImagen = "juegor2/pan_superior.png", posicion = game.at(9, 0))
const queso = new Ingrediente(nombreIngrediente = "queso", rutaImagen = "juegor2/queso.png", posicion = game.at(11, 0))

object ingredientes2 {
    const property lista = [carne, cebolla, lechuga, panInferior, panSuperior, queso]
}

// Ingredientes Nivel 3

const bananaSplit = new Ingrediente(nombreIngrediente = "bananaSplit", rutaImagen = "jugador3/sabor_bananaSplit.png", posicion = game.at(1, 0))
const chocolate = new Ingrediente(nombreIngrediente = "chocolate", rutaImagen = "jugador3/sabor_chocolate.png", posicion = game.at(3, 0))
const cremaOreo = new Ingrediente(nombreIngrediente = "cremaOreo", rutaImagen = "jugador3/sabor_cremaOreo.png", posicion = game.at(5, 0))
const durazno = new Ingrediente(nombreIngrediente = "durazno", rutaImagen = "jugador3/sabor_durazno.png", posicion = game.at(7, 0))
const frutilla = new Ingrediente(nombreIngrediente = "frutilla", rutaImagen = "jugador3/sabor_frutilla.png", posicion = game.at(9, 0))
const melon = new Ingrediente(nombreIngrediente = "melon", rutaImagen = "jugador3/sabor_melon.png", posicion = game.at(11, 0))
const mentaGranizada = new Ingrediente(nombreIngrediente = "mentaGranizada", rutaImagen = "jugador3/sabor_mentaGranizada.png", posicion = game.at(13, 0))

const multifruta = new Ingrediente(nombreIngrediente = "multifruta", rutaImagen = "jugador3/sabor_multifruta.png", posicion = game.at(1,1))
const naranja = new Ingrediente(nombreIngrediente = "naranja", rutaImagen = "jugador3/sabor_naranja.png", posicion = game.at(3,1))
const chispasChocolate = new Ingrediente(nombreIngrediente = "chispasChocolate", rutaImagen = "jugador3/topping_chispasDeChocolate.png", posicion = game.at(5, 1))
const granas = new Ingrediente(nombreIngrediente = "granas", rutaImagen = "jugador3/topping_granas.png", posicion = game.at(7, 1))
const jarabeChocolate = new Ingrediente(nombreIngrediente = "jarabeChocolate", rutaImagen = "jugador3/topping_jarabeDeChocolate.png", posicion = game.at(9, 1))
const jarabeFrutilla = new Ingrediente(nombreIngrediente = "jarabeFrutilla", rutaImagen = "jugador3/topping_jarabeDeFrutilla.png", posicion = game.at(11, 1))
const obleas = new Ingrediente(nombreIngrediente = "obleas", rutaImagen = "jugador3/topping_obleasVainilla.png", posicion = game.at(13, 1))

object ingredientes3 {
    const property lista = [bananaSplit, chocolate, cremaOreo, durazno, frutilla, melon, mentaGranizada, multifruta, naranja, chispasChocolate, granas, jarabeChocolate, jarabeFrutilla, obleas]
}

