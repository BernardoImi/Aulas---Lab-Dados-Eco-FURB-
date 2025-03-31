#AULA 6

#FAZER GRÁFICOS 
# ggplot2 (faz parte do pacote tidyverse)

#install.packages("tidyverse")
library("tidyverse")

#DADOS EM PAINEL

grafpainel <- ggplot(basepib,
                     mapping = aes(y = NY.GDP.MKTP.CD,
                                   x = year)) +
  geom_point()

print(grafpainel)

#CORTE TRANSVERSAL 

grafcorte <- ggplot(basepib2023,
                     mapping = aes(y = NY.GDP.MKTP.CD,
                                   x = year)) +
  geom_point()

print(grafcorte)

#CORTE TEMPORAL

graftemporal <- ggplot(dadospibbr,
                    mapping = aes(y = NY.GDP.MKTP.CD,
                                  x = year)) +
  geom_point()

print(graftemporal)

#AUTO ESTUDO GRÁFICOS

#DADOS EM PAINEL 

library(ggplot2)

library(ggplot2)

grafpainel_import <- ggplot(import_mat_prim,
                            mapping = aes(y = TM.VAL.AGRI.ZS.UN, x = year)) +
  geom_line(color = "steelblue", linewidth = 1, alpha = 0.8) +  # Linha contínua
  geom_point(color = "steelblue", size = 2) +  # Opcional: adiciona pontos às linhas
  labs(
    title = "Evolução do PIB ao Longo dos Anos",
    subtitle = "Dados de Importação de Matérias-Primas",
    x = "Ano",
    y = "PIB (US$ corrente)",
    caption = "Fonte: Banco Mundial (TM.VAL.AGRI.ZS.UN)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 10, hjust = 0.5),
    axis.title = element_text(size = 10),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank())


print(grafpainel_import)


#CORTE TRANSVERSAL

grafcorte_import <- ggplot(import_mat_prim_2022,
                            mapping = aes(y = TM.VAL.AGRI.ZS.UN, x = year)) +
  geom_line(color = "steelblue", linewidth = 1, alpha = 0.8) +  # Linha contínua
  geom_point(color = "steelblue", size = 2) +  # Opcional: adiciona pontos às linhas
  labs(
    title = "Evolução do PIB ao Longo dos Anos",
    subtitle = "Dados de Importação de Matérias-Primas",
    x = "Ano",
    y = "PIB (US$ corrente)",
    caption = "Fonte: Banco Mundial (TM.VAL.AGRI.ZS.UN)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 10, hjust = 0.5),
    axis.title = element_text(size = 10),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank())

print(grafcorte_import)

#CORTE TEMPORAL

graftemporal_import <- ggplot(import_mat_prim_br,
                           mapping = aes(y = TM.VAL.AGRI.ZS.UN, x = year)) +
  geom_line(color = "steelblue", linewidth = 1, alpha = 0.8) +  # Linha contínua
  geom_point(color = "steelblue", size = 2) +  # Opcional: adiciona pontos às linhas
  labs(
    title = "Evolução do PIB ao Longo dos Anos",
    subtitle = "Dados de Importação de Matérias-Primas",
    x = "Ano",
    y = "PIB (US$ corrente)",
    caption = "Fonte: Banco Mundial (TM.VAL.AGRI.ZS.UN)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 10, hjust = 0.5),
    axis.title = element_text(size = 10),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank())

print(graftemporal_import)
