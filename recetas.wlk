import ingredientes.* 
import visuales.* 


class Receta inherits Visual {
    const property nombre
    const property ingredientes
}

const cafeConMedialunas = new Receta(
    nombre = "un café con medialunas",
    rutaImagen = "juegor1/Cafe_Con_Medialunas.png",
    ingredientes = [cafe, medialunas]
)

const hamburguesaCompleta = new Receta(
    nombre = "una hamburguesa completa",
    rutaImagen = "juegor2/hamburguesa.png",
    ingredientes = [carne, cebolla, lechuga, panInferior, panSuperior, queso] //añadir tomate
)

const heladoOreoBanana = new Receta(
    nombre = "un helado de crema Oreo y banana split con jarabe de chocolate",
    rutaImagen = "jugador3/helado_cremaOreo_bananaSplit.png",
    ingredientes = [cremaOreo, bananaSplit, jarabeChocolate]
)

// Todo lo que se puede pedir en la cafeteria
object carta {
    const property recetas = [cafeConMedialunas, hamburguesaCompleta, heladoOreoBanana]
}