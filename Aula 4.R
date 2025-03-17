# AULA 3

A <- 1+1 

# Pacote tidyverde

#install.packages("tidyverse")
library(tidyverse) # Carregar a biblioteca

#AULA 4

#WDI - WORLD DEVELOPMENT INDICATORS
#BASE DE DADOS DO BANCO MUNDIAL 

#install.packages("WDI")
library(WDI)
#SEMPRE PROCURAR AS VIGNETTES (PÁGINAS COM ORIENTAÇÕES DOS PACOTES)

#BAIXAR OS DADOS DO PIB 
#TUDO QUE PRODUZIDO EM UM PAÍS /ESTADO/ MUNICÍPIO 
#EM UM DETERMINADO PERÍODO

# GDP (current US$)(NY.GDP.MKTP.CD)
# GROSS DOMESTIC PRODUCT (GDP) EM DÓLARES NORTE-AMERICANOS 
# CÓDIGO NY.GDP.MKTP.CD


COD_GDP <- WDIsearch("gdp")
#É IMPORTANTE PROCURAR PELO PRÓPRIO  SITE DO BANCO MUNDIAL
#É MAIS EFICIENTE 

#COM O CÓDIGO, VAMOS BAIXAR OS DADOS

options(scipen = 999) # AJUSTAR NÚMEROS
basepib <- WDI(country = "all", 
               indicator = "NY.GDP.MKTP.CD")

basepib2023 <- WDI(country = "all", 
               indicator = "NY.GDP.MKTP.CD",
               start = 2023, end = 2023)


