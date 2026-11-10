class Pedido {
    const property recetas
    const entregado = []

    method ingredientes() = recetas.flatMap({ receta => receta.ingredientes() }).withoutDuplicates()
    method descripcion() = recetas.map({ receta => receta.nombre() }).join(" y ")
    method imagenes() = recetas.map({ receta => receta.imagen() })

    method pide(ingrediente) = self.ingredientes().contains(ingrediente)
    method yaTiene(ingrediente) = entregado.contains(ingrediente)
    method agregar(ingrediente) { entregado.add(ingrediente) }

    method faltantes() = self.ingredientes().filter({ ingrediente => not entregado.contains(ingrediente) })
    method estaCompleto() = self.faltantes().isEmpty()

    method reiniciar() { entregado.clear() }
}