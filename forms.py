from wtforms import Form, StringField, IntegerField, SelectField, SelectMultipleField
from wtforms import validators 
import wtforms

class ClienteForm(Form):
    nombre = StringField('Nombre', [
        validators.DataRequired(message="El nombre es requerido"),
        validators.Length(min=2, max=100, message="Ingresa un nombre válido")
    ])
    direccion = StringField('Dirección', [
        validators.DataRequired(message="La dirección es requerida")
    ])
    telefono = StringField('Teléfono', [
        validators.DataRequired(message="El teléfono es requerido")
    ])
    fecha = StringField('Fecha', [
        validators.DataRequired(message="La fecha es requerida")
    ])

class PizzaForm(Form):
    tamano = SelectField('Tamaño', choices=[
        ('Chica', 'Chica $40'),
        ('Mediana', 'Mediana $80'),
        ('Grande', 'Grande $120')
    ], validators=[validators.DataRequired()])
    ingredientes = SelectMultipleField('Ingredientes', choices=[
        ('Jamon', 'Jamón $10'),
        ('Piña', 'Piña $10'),
        ('Champiñones', 'Champiñones $10')
    ])
    num_pizzas = IntegerField('Número de Pizzas', [
        validators.DataRequired(message="La cantidad es requerida"),
        validators.NumberRange(min=1, message="Debe ser al menos 1")
    ])

class ConsultaDiaForm(Form):
    dia = StringField('Día de la semana', [
        validators.DataRequired(message="El día es requerido")
    ])

class ConsultaMesForm(Form):
    mes = StringField('Mes', [
        validators.DataRequired(message="El mes es requerido")
    ])
