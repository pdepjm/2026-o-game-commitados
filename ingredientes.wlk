import wollok.game.*
import visuales.*

class Ingrediente inherits Clickeable {
    const nombreIngrediente

        // Texto para mostrar: si no se indica otro, se usa el nombre
    const property textoIngrediente = nombreIngrediente

    override method clickear(juego) {
        juego.nivelActual().recibirIngrediente(self)
    }
}

const agua = new Ingrediente(nombreIngrediente = "agua", rutaImagen = "juegor1/agua.png")
const te = new Ingrediente(nombreIngrediente = "te", textoIngrediente = "té", rutaImagen = "juegor1/te.png")
const cafe = new Ingrediente(nombreIngrediente = "cafe", textoIngrediente = "café", rutaImagen = "juegor1/cafe.png")
const gaseosa = new Ingrediente(nombreIngrediente = "gaseosa", rutaImagen = "juegor1/gaseosa.png")
const pan = new Ingrediente(nombreIngrediente = "pan", rutaImagen = "juegor1/pan.png")
const galletas = new Ingrediente(nombreIngrediente = "galletas", rutaImagen = "juegor1/galletas.png")
const medialunas = new Ingrediente(nombreIngrediente = "medialunas", rutaImagen = "juegor1/medialunas.png")
const carne = new Ingrediente(nombreIngrediente = "carne", rutaImagen = "juegor2/carne_cocida.png")
const cebolla = new Ingrediente(nombreIngrediente = "cebolla", rutaImagen = "juegor2/cebolla_cortada.png")
const lechuga = new Ingrediente(nombreIngrediente = "lechuga", rutaImagen = "juegor2/lechuga_1_cruda.png")
const panInferior = new Ingrediente(nombreIngrediente = "panInferior", textoIngrediente = "pan inferior", rutaImagen = "juegor2/pan_inferior.png")
const panSuperior = new Ingrediente(nombreIngrediente = "panSuperior", textoIngrediente = "pan superior", rutaImagen = "juegor2/pan_superior.png")
const queso = new Ingrediente(nombreIngrediente = "queso", rutaImagen = "juegor2/queso.png")
const anana = new Ingrediente(nombreIngrediente = "anana", textoIngrediente = "ananá", rutaImagen = "juegor2/anana.png")
const quesoAzul = new Ingrediente(nombreIngrediente = "quesoAzul", textoIngrediente = "queso azul", rutaImagen = "juegor2/queso_azul.png")
const huevoFrito = new Ingrediente(nombreIngrediente = "huevoFrito", textoIngrediente = "huevo frito", rutaImagen = "juegor2/huevo_frito.png")
const bananaSplit = new Ingrediente(nombreIngrediente = "bananaSplit", textoIngrediente = "banana split", rutaImagen = "jugador3/sabor_bananaSplit.png")
const chocolate = new Ingrediente(nombreIngrediente = "chocolate", rutaImagen = "jugador3/sabor_chocolate.png")
const cremaOreo = new Ingrediente(nombreIngrediente = "cremaOreo", textoIngrediente = "crema Oreo", rutaImagen = "jugador3/sabor_cremaOreo.png")
const durazno = new Ingrediente(nombreIngrediente = "durazno", rutaImagen = "jugador3/sabor_durazno.png")
const frutilla = new Ingrediente(nombreIngrediente = "frutilla", rutaImagen = "jugador3/sabor_frutilla.png")
const melon = new Ingrediente(nombreIngrediente = "melon", textoIngrediente = "melón", rutaImagen = "jugador3/sabor_melon.png")
const mentaGranizada = new Ingrediente(nombreIngrediente = "mentaGranizada", textoIngrediente = "menta granizada", rutaImagen = "jugador3/sabor_mentaGranizada.png")
const multifruta = new Ingrediente(nombreIngrediente = "multifruta", rutaImagen = "jugador3/sabor_multifruta.png")
const naranja = new Ingrediente(nombreIngrediente = "naranja", rutaImagen = "jugador3/sabor_naranja.png")
const chispasChocolate = new Ingrediente(nombreIngrediente = "chispasChocolate", textoIngrediente = "chispas de chocolate", rutaImagen = "jugador3/topping_chispasDeChocolate.png")
const granas = new Ingrediente(nombreIngrediente = "granas", rutaImagen = "jugador3/topping_granas.png", posicion = game.at(14, 4))
const jarabeChocolate = new Ingrediente(nombreIngrediente = "jarabeChocolate", textoIngrediente = "jarabe de chocolate", rutaImagen = "jugador3/topping_jarabeDeChocolate.png")
const jarabeFrutilla = new Ingrediente(nombreIngrediente = "jarabeFrutilla", textoIngrediente = "jarabe de frutilla", rutaImagen = "jugador3/topping_jarabeDeFrutilla.png")
const obleas = new Ingrediente(nombreIngrediente = "obleas", rutaImagen = "jugador3/topping_obleasVainilla.png")


// Agrupados por tipo
const bebidas = [agua, te, cafe, gaseosa]
const panaderia = [pan, galletas, medialunas]
const hamburgueseria = [carne, cebolla, lechuga, panInferior, panSuperior, queso, anana, quesoAzul, huevoFrito]
const sabores = [bananaSplit, chocolate, cremaOreo, durazno, frutilla, melon, mentaGranizada, multifruta, naranja]
const toppings = [chispasChocolate, granas, jarabeChocolate, jarabeFrutilla, obleas]
