# AULA 5

# API (Application Programming Interface)
# DADOS DO BANCO MUNDIAL (WORLD BANK)
# WORLD DEVELOPMENT INDICATORS (WDI)

# NA AULA PASSADA, ACESSAMOS O DADO DO PIB (PRODUTO INTERNO BRUTO)

dadospibbr <- WDI(country = "BR", 
                  indicator = "NY.GDP.MKTP.CD")


import_mat_prim <- WDI (country = "all",
                        indicator = "TM.VAL.AGRI.ZS.UN")

import_mat_prim_2022 <- WDI (country = "all",
                        indicator = "TM.VAL.AGRI.ZS.UN",
                        start = 2022, end = 2022)

import_mat_prim_br <- WDI (country = "BR",
                           indicator = "TM.VAL.AGRI.ZS.UN")

# DADOS EM PAINEL, CORTE TRANSVERSAL E SÉRIE TEMPORAL DOS DADOS
# DE IMPORTAÇÕES DE MATÉRIAS-PRIMAS AGRÍCOLAS 

