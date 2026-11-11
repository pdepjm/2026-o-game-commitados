import wollok.game.*
import visuales.*
import ingredientes.*
import botones.*
import sonidos.*
import recetas.*


const mostrador = new Visual(rutaImagen = "fondos/fondo_Mostrador.png", posicion = game.origin())

const panelIngredientes = new Visual(rutaImagen = "fondos/panel_ingredientes.png", posicion = game.at(13, 3))

//donde se colocan los ingredientes
const panel = new Grilla(columnas = [13, 14, 15], filas = [7, 6, 5, 4, 3])

// donde se coloca las fotos de referencia 
const vitrina = new Grilla(columnas = [8, 10], filas = [2])

// Cliente sentado en el mostrador
const posicionCliente = game.at(6, 2)

const estudianteMostrador = new Visual(rutaImagen = "juegor1/estudiante_Mostrador3.png", posicion = posicionCliente)
const mariaMostrador      = new Visual(rutaImagen = "juegor2/maria_Mostrador.png",       posicion = posicionCliente)
const matiasMostrador     = new Visual(rutaImagen = "jugador3/matias_Mostrador.png",     posicion = posicionCliente)

// Imagen de referencia del pedido
const posicionReferencia = game.at(8, 2)

const pedidoReferencia1 = new Visual(rutaImagen = cafeConMedialunas.image(),   posicion = posicionReferencia)
const pedidoReferencia2 = new Visual(rutaImagen = hamburguesaCompleta.image(), posicion = posicionReferencia)
const pedidoReferencia3 = new Visual(rutaImagen = heladoOreoBanana.image(),    posicion = posicionReferencia)

// Pantallas de resultado (ocupan toda la pantalla, por eso usan la posicion por defecto de Visual: el origen)
const pedidoCorrecto1 = new Visual(rutaImagen = "juegor1/Pedido_Correcto.png")
const pedidoFueraDeTiempo1 = new Visual(rutaImagen = "juegor1/Pedido_SinTiempo.png")

const pedidoCorrecto2 = new Visual(rutaImagen = "juegor2/Pedido_Correcto.png")
const pedidoFueraDeTiempo2 = new Visual(rutaImagen = "juegor2/Pedido_SinTiempo.png")

const pedidoFueraDeTiempo3 = new Visual(rutaImagen = "jugador3/Pedido_SinTiempo.png")
const pedidoCorrecto3 = new Visual(rutaImagen = "jugador3/Pedido_Correcto.png")

// Pantalla final
const pantallaFinal = new Visual(rutaImagen = "fondos/Final.png")


class Escena {
    const visualCliente
    // ingredientes que se ofrecen aunque el cliente no los pida
    const extras
    const property pantallaCorrecto
    const property pantallaSinTiempo

    const property ingredientes = []
    const property enLaVitrina = []

    method prepararPara(cliente) {
        ingredientes.clear()
        ingredientes.addAll((cliente.ingredientesPedidos() + extras).withoutDuplicates().take(panel.capacidad()).randomized())
        panel.acomodar(ingredientes)

        enLaVitrina.clear()
        enLaVitrina.addAll(cliente.recetasPedidas().take(vitrina.capacidad()))
        vitrina.acomodar(enLaVitrina)
    }

    method visuales() = [mostrador, panelIngredientes, visualCliente] + ingredientes + enLaVitrina + [botonEnviar]

    method clickeables() = ingredientes + [botonEnviar]

    method decir(texto) {
        pantalla.decir(visualCliente, texto)
    }

    method sonarAcierto() {
        sonidos.ingredienteCorrecto()
    }
}

const escena1 = new Escena(
    visualCliente = estudianteMostrador,
    extras = bebidas + panaderia,
    pantallaCorrecto = pedidoCorrecto1,
    pantallaSinTiempo = pedidoFueraDeTiempo1
)

const escena2 = new Escena(
    visualCliente = mariaMostrador,
    extras = hamburgueseria + bebidas,
    pantallaCorrecto = pedidoCorrecto2,
    pantallaSinTiempo = pedidoFueraDeTiempo2
)

const escena3 = new Escena(
    visualCliente = matiasMostrador,
    extras = sabores + toppings,
    pantallaCorrecto = pedidoCorrecto3,
    pantallaSinTiempo = pedidoFueraDeTiempo3
)