import ingredientes.* 

class Receta {
    const property nombre
    const property imagen
    const property ingredientes
}

const cafeConMedialunas = new Receta(
    nombre = "un café con medialunas",
    imagen = "juegor1/Cafe_Con_Medialunas.png",
    ingredientes = [cafe, medialunas]
)

const hamburguesaCompleta = new Receta(
    nombre = "una hamburguesa completa",
    imagen = "juegor2/hamburguesa.png",
    ingredientes = [carne, cebolla, lechuga, panInferior, panSuperior, queso]
)

const heladoOreoBanana = new Receta(
    nombre = "un helado de crema Oreo y banana split con jarabe de chocolate",
    imagen = "jugador3/helado_cremaOreo_bananaSplit.png",
    ingredientes = [cremaOreo, bananaSplit, jarabeChocolate]
)

// Todo lo que se puede pedir en la cafeteria
object carta {
    const property recetas = [cafeConMedialunas, hamburguesaCompleta, heladoOreoBanana]
}