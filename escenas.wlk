import wollok.game.*
import visuales.*
import ingredientes.*
import botones.*
import sonidos.*
import recetas.*



object mostrador inherits Visual(rutaImagen = "fondos/fondo_Mostrador.png", posicion = game.origin()) { }

const panelIngredientes = new Visual(rutaImagen = "fondos/panel_ingredientes.png", posicion = game.at(13, 3))

// Cliente sentado en el mostrador
class EstudianteSentado inherits Visual(posicion = game.at(6, 2)) { }

const estudianteMostrador = new EstudianteSentado(rutaImagen = "juegor1/estudiante_Mostrador3.png")
const mariaMostrador      = new EstudianteSentado(rutaImagen = "juegor2/maria_Mostrador.png")
const matiasMostrador     = new EstudianteSentado(rutaImagen = "jugador3/matias_Mostrador.png")

// Imagen de referencia del pedido
class PedidoReferencia inherits Visual(posicion = game.at(8, 2)) { }

const pedidoReferencia1 = new PedidoReferencia(rutaImagen = cafeConMedialunas.imagen())
const pedidoReferencia2 = new PedidoReferencia(rutaImagen = hamburguesaCompleta.imagen())
const pedidoReferencia3 = new PedidoReferencia(rutaImagen = heladoOreoBanana.imagen())

// Pantallas de resultado
class PantallaResultado inherits Visual(posicion = game.origin()) { }

const pedidoCorrecto1 = new PantallaResultado(rutaImagen = "juegor1/Pedido_Correcto.png")
const pedidoFueraDeTiempo1 = new PantallaResultado(rutaImagen = "juegor1/Pedido_SinTiempo.png")

const pedidoCorrecto2 = new PantallaResultado(rutaImagen = "juegor2/Pedido_Correcto.png")
const pedidoFueraDeTiempo2 = new PantallaResultado(rutaImagen = "juegor2/Pedido_SinTiempo.png")

const pedidoFueraDeTiempo3 = new PantallaResultado(rutaImagen = "jugador3/Pedido_SinTiempo.png")

// Pantalla final
const pantallaFinal = new PantallaResultado(rutaImagen = "fondos/Final.png")


class Escena {
    const visualCliente
    const referencia
    const ingredientes
    const property pantallaCorrecto
    const property pantallaSinTiempo

    method visuales() = [mostrador, panelIngredientes, visualCliente] + ingredientes + [botonEnviar, referencia]

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
    referencia = pedidoReferencia1,
    ingredientes = ingredientes1.lista(),
    pantallaCorrecto = pedidoCorrecto1,
    pantallaSinTiempo = pedidoFueraDeTiempo1
)

const escena2 = new Escena(
    visualCliente = mariaMostrador,
    referencia = pedidoReferencia2,
    ingredientes = ingredientes2.lista(),
    pantallaCorrecto = pedidoCorrecto2,
    pantallaSinTiempo = pedidoFueraDeTiempo2
)

const escena3 = new Escena(
    visualCliente = matiasMostrador,
    referencia = pedidoReferencia3,
    ingredientes = ingredientes3.lista(),
    pantallaCorrecto = pantallaFinal,
    pantallaSinTiempo = pedidoFueraDeTiempo3
)