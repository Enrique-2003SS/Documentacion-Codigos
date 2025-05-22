setwd("C:/Users/SIGEH/Desktop/Lalo/Gob/Proyectos")


###
tomas_c1 = sf::read_sf("Tomas_Clandestinas_Actualizacion_Mapa/Datos/Tomas Clandestinas/Antes_Octubre24/tomas_cland_2024.shp")
tomas_c2 = sf::read_sf("Tomas_Clandestinas_Actualizacion_Mapa/Datos/Tomas Clandestinas/Octubre24_Febrero2025/Octubre-febrero_tomas_clandestinas.shp")

tomas_c1 = tomas_c1 |> dplyr::select(MEDIDOR:FECHA_A)
tomas_c2 = tomas_c2 |> dplyr::select(MEDIDOR_RE:FECHA_ALTA)
colnames(tomas_c1) = colnames(tomas_c2)

tomas = rbind(tomas_c1, tomas_c2)
sf::write_sf(tomas, "Tomas_Clandestinas_Actualizacion_Mapa/Datos/Tomas Clandestinas/Actualizado Join/tomas_clandestinas.shp")

