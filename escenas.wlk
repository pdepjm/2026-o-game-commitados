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
class EstudianteSentado inherits Visual(posicion = game.at(6, 2)) { }

const estudianteMostrador = new EstudianteSentado(rutaImagen = "juegor1/estudiante_Mostrador3.png")
const mariaMostrador      = new EstudianteSentado(rutaImagen = "juegor2/maria_Mostrador.png")
const matiasMostrador     = new EstudianteSentado(rutaImagen = "jugador3/matias_Mostrador.png")

// Imagen de referencia del pedido
class PedidoReferencia inherits Visual(posicion = game.at(8, 2)) { }

const pedidoReferencia1 = new PedidoReferencia(rutaImagen = cafeConMedialunas.image())
const pedidoReferencia2 = new PedidoReferencia(rutaImagen = hamburguesaCompleta.image())
const pedidoReferencia3 = new PedidoReferencia(rutaImagen = heladoOreoBanana.image())

// Pantallas de resultado
class PantallaResultado inherits Visual(posicion = game.origin()) { }

const pedidoCorrecto1 = new PantallaResultado(rutaImagen = "juegor1/Pedido_Correcto.png")
const pedidoFueraDeTiempo1 = new PantallaResultado(rutaImagen = "juegor1/Pedido_SinTiempo.png")

const pedidoCorrecto2 = new PantallaResultado(rutaImagen = "juegor2/Pedido_Correcto.png")
const pedidoFueraDeTiempo2 = new PantallaResultado(rutaImagen = "juegor2/Pedido_SinTiempo.png")

const pedidoFueraDeTiempo3 = new PantallaResultado(rutaImagen = "jugador3/Pedido_SinTiempo.png")
const pedidoCorrecto3 = new PantallaResultado(rutaImagen = "jugador3/Pedido_Correcto.png")

// Pantalla final
const pantallaFinal = new PantallaResultado(rutaImagen = "fondos/Final.png")


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