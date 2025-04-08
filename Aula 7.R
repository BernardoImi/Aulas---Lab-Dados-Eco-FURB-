# AULA 7

#EXECUÇÃO E CRIAÇÃO DOS PRÓPRIOS GRÁFICOS, COM BASE NOS DADOS DO WDI,
# COMO ORIENTADO PELO PROFESSOR 

library(tidyverse)
library(WDI)
library(ggplot2)

# Carregar os dados
import_mat_prim <- WDI(country = "all", indicator = "TM.VAL.AGRI.ZS.UN")
import_mat_prim_br <- WDI(country = "BR", indicator = "TM.VAL.AGRI.ZS.UN")

# Identificar maior e menor importador médio no período
import_summary <- import_mat_prim %>%
  group_by(country, iso2c) %>%
  summarize(mean_value = mean(TM.VAL.AGRI.ZS.UN, na.rm = TRUE)) %>%
  ungroup() %>%
  filter(!is.na(mean_value))

max_importer <- import_summary %>%
  filter(mean_value == max(mean_value, na.rm = TRUE)) %>%
  slice(1)

min_importer <- import_summary %>%
  filter(mean_value == min(mean_value, na.rm = TRUE)) %>%
  slice(1)

# Obter dados completos para maior e menor importador
max_importer_data <- import_mat_prim %>% 
  filter(iso2c == max_importer$iso2c)

min_importer_data <- import_mat_prim %>% 
  filter(iso2c == min_importer$iso2c)

# Criar o gráfico corrigido
grafpainel_import2 <- ggplot() +
  # Linha cinza para outros países (fundo)
  geom_line(data = import_mat_prim %>% 
              filter(!iso2c %in% c("BR", max_importer$iso2c, min_importer$iso2c)), 
            aes(x = year, y = TM.VAL.AGRI.ZS.UN, group = country),
            color = "gray80", alpha = 0.5) +
  # Linha verde escuro para maior importador
  geom_line(data = max_importer_data,
            aes(x = year, y = TM.VAL.AGRI.ZS.UN),
            color = "darkgreen", linewidth = 1.2, alpha = 0.8) +
  # Linha verde claro para menor importador
  geom_line(data = min_importer_data,
            aes(x = year, y = TM.VAL.AGRI.ZS.UN),
            color = "green3", linewidth = 1.2, alpha = 0.8) +
  # Linha vermelha para o Brasil
  geom_line(data = import_mat_prim_br, 
            aes(x = year, y = TM.VAL.AGRI.ZS.UN),
            color = "red", linewidth = 1.2) +
  # Pontos para cada série destacada
  geom_point(data = max_importer_data,
             aes(x = year, y = TM.VAL.AGRI.ZS.UN),
             color = "darkgreen", size = 2) +
  geom_point(data = min_importer_data,
             aes(x = year, y = TM.VAL.AGRI.ZS.UN),
             color = "green3", size = 2) +
  geom_point(data = import_mat_prim_br, 
             aes(x = year, y = TM.VAL.AGRI.ZS.UN),
             color = "red", size = 2.5) +
  labs(
    title = "Evolução das Importações Agrícolas (% do Total de Importações)",
    subtitle = paste("Destaques: Brasil (vermelho)", 
                     "Maior importador:", max_importer$country, "(verde escuro)",
                     "Menor importador:", min_importer$country, "(verde claro)"),
    x = "Ano",
    y = "Importações Agrícolas (% do total)",
    caption = "Fonte: Banco Mundial (TM.VAL.AGRI.ZS.UN)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 9, hjust = 0.5),
    axis.title = element_text(size = 10),
    panel.grid.major = element_line(color = "gray90"),
    panel.grid.minor = element_blank()
  ) +
  # Anotações para cada série destacada
  geom_label(data = import_mat_prim_br %>% filter(year == max(year, na.rm = TRUE)),
             aes(x = year, y = TM.VAL.AGRI.ZS.UN, label = "Brasil"),
             color = "red", nudge_y = 2, nudge_x = 1) +
  geom_label(data = max_importer_data %>% filter(year == max(year, na.rm = TRUE)),
             aes(x = year, y = TM.VAL.AGRI.ZS.UN, 
                 label = paste("Maior:", max_importer$country)),
             color = "darkgreen", nudge_y = 2, nudge_x = 1) +
  geom_label(data = min_importer_data %>% filter(year == max(year, na.rm = TRUE)),
             aes(x = year, y = TM.VAL.AGRI.ZS.UN, 
                 label = paste("Menor:", min_importer$country)),
             color = "green3", nudge_y = -2, nudge_x = 1)

print(grafpainel_import2)

#CORTE TRANSVERSAL

library(tidyverse)
library(WDI)

# Obter dados de 2022
dados_import_2022 <- WDI(country = "all", 
                         indicator = "TM.VAL.AGRI.ZS.UN",
                         start = 2022, end = 2022)

# Obter dados de PIB para identificar as 20 maiores economias
dados_pib <- WDI(country = "all", indicator = "NY.GDP.MKTP.CD", 
                 start = 2022, end = 2022) %>%
  arrange(desc(NY.GDP.MKTP.CD)) %>%  # Ordenar por PIB em ordem decrescente
  head(20)  # Selecionar as 20 primeiras

# Identificar importadores extremos
maior_importador_2022 <- dados_import_2022 %>%
  filter(TM.VAL.AGRI.ZS.UN == max(TM.VAL.AGRI.ZS.UN, na.rm = TRUE))

menor_importador_2022 <- dados_import_2022 %>%
  filter(TM.VAL.AGRI.ZS.UN == min(TM.VAL.AGRI.ZS.UN, na.rm = TRUE))

# Combinar as 20 maiores economias com importadores extremos
paises_selecionados <- unique(c(
  dados_pib$iso2c,             # 20 maiores economias
  "BR",                        # Brasil
  maior_importador_2022$iso2c, # Maior importador
  menor_importador_2022$iso2c  # Menor importador
))

# Filtrar e preparar dados para o gráfico
dados_grafico <- dados_import_2022 %>%
  filter(iso2c %in% paises_selecionados) %>%
  mutate(destaque = case_when(
    country == "Brazil" ~ "Brasil",
    country == maior_importador_2022$country ~ "Maior Importador",
    country == menor_importador_2022$country ~ "Menor Importador",
    TRUE ~ "Top 20 Economia"
  )) %>%
  arrange(desc(TM.VAL.AGRI.ZS.UN))  # Ordenar por % de importação

# Criar o gráfico
grafico_focado <- ggplot(dados_grafico, 
                         aes(x = reorder(country, -TM.VAL.AGRI.ZS.UN), 
                             y = TM.VAL.AGRI.ZS.UN,
                             fill = destaque)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c(
    "Brasil" = "red",
    "Maior Importador" = "darkgreen",
    "Menor Importador" = "green3",
    "Top 20 Economia" = "gray70"
  )) +
  labs(
    title = "Importações Agrícolas em 2022 (% do Total de Importações)",
    subtitle = paste("20 maiores economias + extremos | Brasil em vermelho\n",
                     "Maior importador:", maior_importador_2022$country, "(verde escuro) |",
                     "Menor importador:", menor_importador_2022$country, "(verde claro)"),
    x = "País",
    y = "Importações Agrícolas (% do total)",
    caption = "Fonte: Banco Mundial (TM.VAL.AGRI.ZS.UN)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 8, hjust = 0.5),
    axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 7),
    legend.position = "none"  # Remove a legenda pois usamos o subtítulo
  ) +
  geom_text(aes(label = round(TM.VAL.AGRI.ZS.UN, 1)), 
            vjust = -0.5, size = 2.5)  # Adiciona valores nas barras

print(grafico_focado)

#CORTE TEMPORAL 

graftemporal_import <- ggplot(import_mat_prim_br,
                              mapping = aes(y = TM.VAL.AGRI.ZS.UN, x = year)) +
  geom_line(color = "steelblue", linewidth = 1, alpha = 0.8) +  # Linha contínua
  geom_point(color = "steelblue", size = 2) +  # Opcional: adiciona pontos às linhas
  labs(
    title = "Evolução do PIB ao Longo dos Anos",
    subtitle = "Dados de Importação de Matérias-Primas",
    x = "Ano",
    y = "Importações de matérias-primas agrícolas
        (% das importações de mercadorias)"
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
