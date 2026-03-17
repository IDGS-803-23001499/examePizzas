from flask import render_template, request, flash
from models import db, Clientes, Pedidos
from . import ventas


@ventas.route("/", methods=["GET", "POST"])
def listado_ventas():

    resultados_dia = []
    resultados_mes = []
    total_mes = 0
    tipo_consulta = None

    DIAS_MAP = {
        "lunes": 2,
        "martes": 3,
        "miercoles": 4,
        "miércoles": 4,
        "jueves": 5,
        "viernes": 6,
        "sabado": 7,
        "sábado": 7,
        "domingo": 1
    }

    MESES_MAP = {
        "enero": 1,
        "febrero": 2,
        "marzo": 3,
        "abril": 4,
        "mayo": 5,
        "junio": 6,
        "julio": 7,
        "agosto": 8,
        "septiembre": 9,
        "octubre": 10,
        "noviembre": 11,
        "diciembre": 12
    }

    if request.method == "POST":
        tipo_consulta = request.form.get("tipo_consulta")
        if tipo_consulta == "dia":
            dia_nombre = request.form.get("dia", "").strip().lower()
            num_dia = DIAS_MAP.get(dia_nombre)
            if num_dia:
                resultados_dia = (
                    db.session.query(
                        Clientes.nombre,
                        Pedidos.fecha,
                        Pedidos.total,
                        Pedidos.id_pedido
                    )
                    .join(Pedidos, Pedidos.id_cliente == Clientes.id_cliente)
                    .filter(db.func.dayofweek(Pedidos.fecha) == num_dia)
                    .all()
                )
            else:
                flash("Día no reconocido. Ejemplo: lunes, martes, miércoles.")
        elif tipo_consulta == "mes":
            mes_nombre = request.form.get("mes", "").strip().lower()
            num_mes = MESES_MAP.get(mes_nombre)
            if num_mes:
                resultados_mes = (
                    db.session.query(
                        Clientes.nombre,
                        Pedidos.fecha,
                        Pedidos.total,
                        Pedidos.id_pedido
                    )
                    .join(Pedidos, Pedidos.id_cliente == Clientes.id_cliente)
                    .filter(db.func.month(Pedidos.fecha) == num_mes)
                    .all()
                )
                total_mes = sum(r.total for r in resultados_mes)
            else:
                flash("Mes no reconocido. Ejemplo: enero, febrero, marzo.")

    return render_template(
        "ventas/ventas.html",
        resultados_dia=resultados_dia,
        resultados_mes=resultados_mes,
        total_mes=total_mes,
        tipo_consulta=tipo_consulta
    )


@ventas.route("/detalle/<int:id_pedido>")
def detalle(id_pedido):
    from models import DetallePedido
    pedido = Pedidos.query.get_or_404(id_pedido)
    detalles = DetallePedido.query.filter_by(
        id_pedido=id_pedido
    ).all()
    return render_template(
        "ventas/detalle.html",
        pedido=pedido,
        detalles=detalles
    )