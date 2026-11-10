import wollok.game.*
import visuales.*

class Ingrediente inherits Clickeable {
    const nombreIngrediente

    // Texto para mostrar 
    const textoIngrediente = null

    method textoParaMostrar() = if (textoIngrediente == null) nombreIngrediente else textoIngrediente

    override method clickear(juego) {
        juego.nivelActual().recibirIngrediente(self)
    }
}

// INGREDIENTES NIVEL 1
const agua = new Ingrediente(nombreIngrediente = "agua", rutaImagen = "juegor1/agua.png", posicion = game.at(13, 7))
const te = new Ingrediente(nombreIngrediente = "te", textoIngrediente = "té", rutaImagen = "juegor1/te.png", posicion = game.at(14, 7))
const cafe = new Ingrediente(nombreIngrediente = "cafe", textoIngrediente = "café", rutaImagen = "juegor1/cafe.png", posicion = game.at(15, 7))
const gaseosa = new Ingrediente(nombreIngrediente = "gaseosa", rutaImagen = "juegor1/gaseosa.png", posicion = game.at(13, 6))
const pan = new Ingrediente(nombreIngrediente = "pan", rutaImagen = "juegor1/pan.png", posicion = game.at(14, 6))
const galletas = new Ingrediente(nombreIngrediente = "galletas", rutaImagen = "juegor1/galletas.png", posicion = game.at(15, 6))
const medialunas = new Ingrediente(nombreIngrediente = "medialunas", rutaImagen = "juegor1/medialunas.png", posicion = game.at(13, 5))

object ingredientes1 {
    const property lista = [agua, gaseosa, cafe, galletas, te, pan, medialunas]
}

// INGREDIENTES NIVEL 2
const carne = new Ingrediente(nombreIngrediente = "carne", rutaImagen = "juegor2/carne_cocida.png", posicion = game.at(13, 7))
const cebolla = new Ingrediente(nombreIngrediente = "cebolla", rutaImagen = "juegor2/cebolla_cortada.png", posicion = game.at(14, 7))
const lechuga = new Ingrediente(nombreIngrediente = "lechuga", rutaImagen = "juegor2/lechuga_1_cruda.png", posicion = game.at(15, 7))
const panInferior = new Ingrediente(nombreIngrediente = "panInferior", textoIngrediente = "pan inferior", rutaImagen = "juegor2/pan_inferior.png", posicion = game.at(13, 6))
const panSuperior = new Ingrediente(nombreIngrediente = "panSuperior", textoIngrediente = "pan superior", rutaImagen = "juegor2/pan_superior.png", posicion = game.at(14, 6))
const queso = new Ingrediente(nombreIngrediente = "queso", rutaImagen = "juegor2/queso.png", posicion = game.at(15, 6))
const anana = new Ingrediente(nombreIngrediente = "anana", textoIngrediente = "ananá", rutaImagen = "juegor2/anana.png", posicion = game.at(13, 5))
const quesoAzul = new Ingrediente(nombreIngrediente = "quesoAzul", textoIngrediente = "queso azul", rutaImagen = "juegor2/queso_azul.png", posicion = game.at(14, 5))
const huevoFrito = new Ingrediente(nombreIngrediente = "huevoFrito", textoIngrediente = "huevo frito", rutaImagen = "juegor2/huevo_frito.png", posicion = game.at(15, 5))

object ingredientes2 {
    const property lista = [carne, agua , cebolla, lechuga, panInferior, panSuperior, queso, anana, quesoAzul, huevoFrito]
}

// INGREDIENTES NIVEL 3
const bananaSplit = new Ingrediente(nombreIngrediente = "bananaSplit", textoIngrediente = "banana split", rutaImagen = "jugador3/sabor_bananaSplit.png", posicion = game.at(13, 7))
const chocolate = new Ingrediente(nombreIngrediente = "chocolate", rutaImagen = "jugador3/sabor_chocolate.png", posicion = game.at(14, 7))
const cremaOreo = new Ingrediente(nombreIngrediente = "cremaOreo", textoIngrediente = "crema Oreo", rutaImagen = "jugador3/sabor_cremaOreo.png", posicion = game.at(15, 7))
const durazno = new Ingrediente(nombreIngrediente = "durazno", rutaImagen = "jugador3/sabor_durazno.png", posicion = game.at(13, 6))
const frutilla = new Ingrediente(nombreIngrediente = "frutilla", rutaImagen = "jugador3/sabor_frutilla.png", posicion = game.at(14, 6))
const melon = new Ingrediente(nombreIngrediente = "melon", textoIngrediente = "melón", rutaImagen = "jugador3/sabor_melon.png", posicion = game.at(15, 6))
const mentaGranizada = new Ingrediente(nombreIngrediente = "mentaGranizada", textoIngrediente = "menta granizada", rutaImagen = "jugador3/sabor_mentaGranizada.png", posicion = game.at(13, 5))
const multifruta = new Ingrediente(nombreIngrediente = "multifruta", rutaImagen = "jugador3/sabor_multifruta.png", posicion = game.at(14, 5))
const naranja = new Ingrediente(nombreIngrediente = "naranja", rutaImagen = "jugador3/sabor_naranja.png", posicion = game.at(15, 5))
const chispasChocolate = new Ingrediente(nombreIngrediente = "chispasChocolate", textoIngrediente = "chispas de chocolate", rutaImagen = "jugador3/topping_chispasDeChocolate.png", posicion = game.at(13, 4))
const granas = new Ingrediente(nombreIngrediente = "granas", rutaImagen = "jugador3/topping_granas.png", posicion = game.at(14, 4))
const jarabeChocolate = new Ingrediente(nombreIngrediente = "jarabeChocolate", textoIngrediente = "jarabe de chocolate", rutaImagen = "jugador3/topping_jarabeDeChocolate.png", posicion = game.at(15, 4))
const jarabeFrutilla = new Ingrediente(nombreIngrediente = "jarabeFrutilla", textoIngrediente = "jarabe de frutilla", rutaImagen = "jugador3/topping_jarabeDeFrutilla.png", posicion = game.at(13, 3))
const obleas = new Ingrediente(nombreIngrediente = "obleas", rutaImagen = "jugador3/topping_obleasVainilla.png", posicion = game.at(14, 3))

object ingredientes3 {
    const property lista = [bananaSplit, chocolate, cremaOreo, durazno, frutilla, melon, mentaGranizada, multifruta, naranja, chispasChocolate, granas, jarabeChocolate, jarabeFrutilla, obleas]
}