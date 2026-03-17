from flask import render_template, request, redirect, url_for, flash, session
from models import db, Clientes, Pizzas, Pedidos, DetallePedido
from forms import ClienteForm
from . import pedidos
import datetime

PRECIOS_TAMANO = {
    'Chica': 40,
    'Mediana': 80,
    'Grande': 120
}

PRECIOS_INGREDIENTE = {
    'Jamon': 10,
    'Piña': 10,
    'Champiñones': 10
}

ARCHIVO_CARRITO = "carrito.txt"


def leer_carrito():
    carrito = []
    try:
        with open(ARCHIVO_CARRITO, "r", encoding="utf-8") as f:
            for linea in f:
                datos = linea.strip().split("|")
                item = {
                    "tamano": datos[0],
                    "ingredientes": datos[1],
                    "num_pizzas": int(datos[2]),
                    "subtotal": float(datos[3])
                }
                carrito.append(item)
    except FileNotFoundError:
        pass
    return carrito


def guardar_item(item):
    with open(ARCHIVO_CARRITO, "a", encoding="utf-8") as f:
        linea = f"{item['tamano']}|{item['ingredientes']}|{item['num_pizzas']}|{item['subtotal']}\n"
        f.write(linea)


def eliminar_item(idx):
    carrito = leer_carrito()

    if 0 <= idx < len(carrito):
        carrito.pop(idx)

    with open(ARCHIVO_CARRITO, "w", encoding="utf-8") as f:
        for item in carrito:
            linea = f"{item['tamano']}|{item['ingredientes']}|{item['num_pizzas']}|{item['subtotal']}\n"
            f.write(linea)


def limpiar_carrito():
    open(ARCHIVO_CARRITO, "w").close()


@pedidos.route("/", methods=["GET", "POST"])
def pedido():

    form = ClienteForm(request.form)

    if request.method == "POST":

        accion = request.form.get("accion")

        if accion == "agregar":

            session['cliente_temp'] = {
                "nombre": request.form.get("nombre"),
                "direccion": request.form.get("direccion"),
                "telefono": request.form.get("telefono"),
                "fecha": request.form.get("fecha")
            }

            tamano = request.form.get("tamano")
            ingredientes = request.form.getlist("ingredientes")

            ingredientes_str = ", ".join(ingredientes) if ingredientes else "Queso"

            num = int(request.form.get("num_pizzas", 1))

            precio_base = PRECIOS_TAMANO.get(tamano, 0)

            precio_ing = sum(
                PRECIOS_INGREDIENTE.get(i, 0)
                for i in ingredientes
            )

            subtotal = (precio_base + precio_ing) * num

            item = {
                "tamano": tamano,
                "ingredientes": ingredientes_str,
                "num_pizzas": num,
                "subtotal": subtotal
            }

            guardar_item(item)

            return redirect(url_for("pedidos.pedido"))

        elif accion == "quitar":

            idx = int(request.form.get("idx"))

            eliminar_item(idx)

            return redirect(url_for("pedidos.pedido"))

        elif accion == "terminar":

            if not form.validate():

                flash("Completa todos los datos del cliente.")

                carrito = leer_carrito()
                total_actual = sum(item['subtotal'] for item in carrito)

                return render_template(
                    "pedidos/pedido.html",
                    carrito=carrito,
                    total_actual=total_actual,
                    cliente_temp=session.get("cliente_temp", {}),
                    form=form
                )

            nombre = form.nombre.data
            direccion = form.direccion.data
            telefono = form.telefono.data
            fecha_str = form.fecha.data

            fecha = datetime.datetime.strptime(
                fecha_str, "%Y-%m-%d"
            ).date()

            carrito = leer_carrito()

            if not carrito:

                flash("Agrega al menos una pizza antes de terminar el pedido.")

                return redirect(url_for("pedidos.pedido"))

            total = sum(item['subtotal'] for item in carrito)

            cliente = Clientes(
                nombre=nombre,
                direccion=direccion,
                telefono=telefono
            )

            db.session.add(cliente)
            db.session.flush()

            pedido = Pedidos(
                id_cliente=cliente.id_cliente,
                fecha=fecha,
                total=total
            )

            db.session.add(pedido)
            db.session.flush()

            for item in carrito:

                pizza = Pizzas(
                    tamano=item['tamano'],
                    ingredientes=item['ingredientes'],
                    precio=item['subtotal']
                )

                db.session.add(pizza)
                db.session.flush()

                detalle = DetallePedido(
                    id_pedido=pedido.id_pedido,
                    id_pizza=pizza.id_pizza,
                    cantidad=item['num_pizzas'],
                    subtotal=item['subtotal']
                )

                db.session.add(detalle)

            db.session.commit()

            limpiar_carrito()

            session.pop("cliente_temp", None)

            flash(f"Pedido registrado correctamente. Total a pagar: ${total}")

            return redirect(url_for("pedidos.pedido"))

    carrito = leer_carrito()

    total_actual = sum(item['subtotal'] for item in carrito)

    cliente_temp = session.get("cliente_temp", {})

    return render_template(
        "pedidos/pedido.html",
        carrito=carrito,
        total_actual=total_actual,
        cliente_temp=cliente_temp,
        form=form
    )