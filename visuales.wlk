import wollok.game.*

// Clase base de todp lo que se dibuja en pantalla.
// asi que ese codigo se escribe una sola vez aca y las demas clases lo heredan
class Visual {
    const rutaImagen
    const posicion

    method image() = rutaImagen
    method position() = posicion
}

// Un visual que ademas se puede clickear
class Clickeable inherits Visual {
    method clickear(nivel)
}
