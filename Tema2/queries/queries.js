
//Escriu una consulta per mostrar tots els documents en la col·lecció Restaurants.
db.inventory.find({})

//Escriu una consulta per mostrar el restaurant_id, name, borough i cuisine de tots els documents en la col·lecció Restaurants.
db.restaurante.find({restaurant_id}, {name}, {borough}, {cuisine})



