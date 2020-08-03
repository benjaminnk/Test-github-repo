install.packages("stringr")
install.packages("devtools")
install.packages("tydiverse")
library(stringr)
library(tidyverse)
library(dplyr)

``
read

#Step 2: Identify the file type you are importing. If it is a .txt, use the code below. If it is a .csv, use read.csv. The filepath should be within your working directory that you set above. Below the file is a .txt
data.MER <- read.delim("MER_Structured_Datasets_OU_IM_FY18-20_20200626_v2_1.txt", header = TRUE, sep = "\t",quote = "", dec = ".")

data.MER <- read_msd("MER_Structured_Datasets_OU_IM_FY18-20_20200626_v2_1.txt", save_rds=FALSE)
#data.ER <- read.delim("ER_Structured_Dataset_FY18-20_20201220_v2_5.txt", header = TRUE, sep = "\t", quote = "", dec = ".")
``


#MER Read in/
#Switch the type of character of one of the variables in order oto be able to bind them. in this
#case "Mechanism ID"for ER did no match the MER. Character to Integer
data.MER  <- data.MER %>% 
  dplyr::filter(disaggregate == "Total Numerator") %>%
  dplyr::select( - c('operatingunituid', 'pre_rgnlztn_hq_mech_code', 'prime_partner_duns',	'award_number',	
                     'categoryoptioncomboname', 'ageasentered', 'trendsfine', 'trendssemifine', 'trendscoarse',	
                     'sex', 'statushiv',	'statustb', 'statuscx', 'hiv_treatment_status', 'otherdisaggregate', 'otherdisaggregate_sub',	
                     'modality', 'source_name','numeratordenom','disaggregate','standardizeddisaggregate')) %>% 
  dplyr::rename("Operating Unit"= "operatingunit",
                "Country"= "countryname",
                "Funding Agency"= "fundingagency",
                "Partner Name"= "primepartner",
                "Mechanism ID"="mech_code",
                "Mechanism Name" = "mech_name",
                "Indicator Type"="indicatortype",
                "Indicator"="indicator",
                "Targets"="targets",
                "Quarter 1"="qtr1",
                "Quarter 2"="qtr2",
                "Quarter 3"="qtr3",
                "Quarter 4"="qtr4",
                "Total"="cumulative",
                "Fiscal Year"="fiscal_year")

  data.MER<-data.MER %>% dplyr::mutate(`Data Stream` = "MER") %>%
  dplyr:: mutate(`Operating Unit`=as.character(`Operating Unit`))%>%
  dplyr::mutate(`Mechanism ID` = as.character(`Mechanism ID`))%>%
  dplyr::mutate(`Country` = as.character(`Country`))%>%
  dplyr::mutate(`Partner Name` = as.character(`Partner Name`))%>%
  dplyr::mutate(`Mechanism Name` = as.character(`Mechanism Name`))%>%
  dplyr::mutate(`Fiscal Year` = as.character(`Fiscal Year`))
  
  
#,'Data Stream'=as.character('Data Stream'))

data.MER<-data.MER%>%
  gather(`Quarter`,`Results`,`Quarter 1`: `Total`,na.rm=FALSE)%>%
  mutate_at(vars(`Targets`),funs(replace(., duplicated(. ),NA)))

df1 <- dplyr::bind_rows(df , data.MER)
write_csv(df1, "testMERoutlay_4.csv")
