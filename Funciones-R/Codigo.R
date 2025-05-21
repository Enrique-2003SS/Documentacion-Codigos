datos = readxl::read_excel("C:/Users/SIGEH/Desktop/Lalo/Gob/Documentacion Codigos/Summarize/Datos/24_MM_PUB_4t.xlsx")
colnames(datos)[1:2] = c("No", "cve_ent")

datos = datos |> 
  dplyr::mutate(cve_ent = gsub("Hidalgo", "", cve_ent),
                cve_ent = stringr::str_trim(cve_ent))

datos = datos |> 
  dplyr::mutate(ent = "Hidalgo")

datos = datos |> 
  dplyr::mutate(C_Mun = substring(C_Mun, first = 1, last = 3)) |>
  dplyr::rename(cve_mun = C_Mun)

municipios = sf::read_sf("C:/Users/SIGEH/Desktop/Lalo/Gob/Importantes_documentos_usar/Municipios/municipiosjair.shp")

municipios = municipios |> dplyr::select(CVE_MUN, NOM_MUN) |> sf::st_drop_geometry()
datos = merge(x = datos, y = municipios, by.x = "cve_mun", by.y = "CVE_MUN", all.x = T)
datos = datos |> dplyr::select(No, cve_ent, ent, cve_mun, NOM_MUN, Localidad:entrega) |> 
  dplyr::arrange(No) |>
  dplyr::rename(nom_mun = NOM_MUN)




#### Desde aqui ya no esta comentado
datos = datos |> dplyr::mutate(CP =  `C_P       Programa Presupuestario`,
                               CP = substr(x = CP, start = 1, stop = 5))

datos = datos |> dplyr::rename(Programa_Presupuestario = `C_P       Programa Presupuestario`) |>
  dplyr::mutate(Programa_Presupuestario = substr(x = Programa_Presupuestario, start = 6, stop = nchar(Programa_Presupuestario)),
                Programa_Presupuestario = stringr::str_trim(Programa_Presupuestario)) 



datos = datos |> dplyr::rename(Monto = `Cantidad    Monto           Año`) |>
  dplyr::mutate(Cantidad = Monto,
                Cantidad = sub(x = Cantidad, pattern = "\\$.*", replacement = ""),
                Cantidad = stringr::str_trim(Cantidad))


datos = datos |> dplyr::mutate(Monto = sub(x = Monto, pattern = ".*\\$", replacement = ""),
                               Monto = gsub(x = Monto, pattern = ",", replacement = ""),
                               Monto = as.numeric(Monto))

datos = datos |> dplyr::rename(Año_entrega = `_entrega     mes_`,
                               Mes_entrega = `Entrega     Dia_`,
                               Dia_entrega = entrega)


datos = datos |> dplyr::select(No:Sexo, CP, Programa_Presupuestario, Subprograma, `Vertiente / Apoyo         Descripcion o comentario`, Cantidad, Monto, Año_entrega, Mes_entrega, Dia_entrega)


datos = datos |> dplyr::mutate(Localidad = stringr::str_trim(Localidad),
                               Localidad = gsub(x = Localidad, pattern = "  ", replacement = " "))

# Pendiente quitar la M del final en la columna de nombre_s

### Realizar lo solicitado

datos = datos |> dplyr::mutate(ID = paste0(cve_ent, cve_mun, "-", tolower(stringi::stri_trans_general(Localidad, "Latin-ASCII"))))

  interes = datos |> dplyr::select(ID, Monto) |>
  dplyr::group_by(ID) |> dplyr::summarise(conteo = dplyr::n(), Monto = sum(Monto))
  
