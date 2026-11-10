class Pedido {
    const property recetas
    const entregado = []

    method ingredientes() = recetas.flatMap({ receta => receta.ingredientes() }).withoutDuplicates()
    method descripcion() = recetas.map({ receta => receta.nombre() }).join(" y ")
    method imagenes() = recetas.map({ receta => receta.image() })

    method pide(ingrediente) = self.ingredientes().contains(ingrediente)
    method yaTiene(ingrediente) = entregado.contains(ingrediente)
    method agregar(ingrediente) { entregado.add(ingrediente) }

    method faltantes() = self.ingredientes().filter({ ingrediente => not entregado.contains(ingrediente) })
    method estaCompleto() = self.faltantes().isEmpty()

    method reiniciar() { entregado.clear() }
}

// Sabe elegir al azar. Se inyecta para poder testear sin azar.
object azar {
    method unoDe(opciones) = opciones.anyOne()
}

// Arma pedidos nuevos tomando recetas de la carta, sin repetir
class GeneradorDePedidos {
    const carta
    const sorteador

    method generar(cuantasRecetas) = new Pedido(recetas = self.elegirRecetas(cuantasRecetas))

    method elegirRecetas(cuantas) {
        const elegidas = []
        cuantas.min(carta.recetas().size()).times({ i =>
            elegidas.add(sorteador.unoDe(self.disponibles(elegidas)))
        })
        return elegidas
    }

    method disponibles(yaElegidas) = carta.recetas().filter({ receta => not yaElegidas.contains(receta) })
}