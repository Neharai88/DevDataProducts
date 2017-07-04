library(ggplot2)
library(data.table)
library(lattice)

function(input, output) {
  dt <- read.csv("B02T1102_BANGALORE_RURAL-1991.csv")
  
  output$data_table <- renderTable({
    dat <- as.data.table(dt)
    dType <- as.character(input$dataType)
    
    if (dType == "URBAN"){
      # Return first 20 rows
      dat <- dat[dat$Type =="URBAN"]
      head(dat, 20)}
    else if (dType == "RURAL"){
      dat <- dat[dat$Type =="RURAL"]
      head(dat, 20)}
    else{
      dat <- dat[dat$Type =="TOTAL"]
      head(dat, 20)}
  })
  
  output$data_plot <- renderPlot({
    dat <- as.data.table(dt)
    dgraf <- as.character(input$graf1)
    
    if (dgraf == "Age group"){
      barchart(TotalPopulation_Persons~Age_group,data=dt,groups=Type, xtitle="Total Population Persons", ytitle='Age Group',mainTitle="Total Population as per age group for each Types",xShowTitle=TRUE,yShowTitle=TRUE,
             scales=list(x=list(rot=90000000,cex=0.8)))
    }
  else if (dgraf == "Types"){
      dat.by.Type <- dat[,sum(TotalPopulation_Persons),by=Type]
      names(dat.by.Type) <- c('Type','TotalPopulation_Persons')
      graf1 <- barplot(dat.by.Type$TotalPopulation_Persons,names.arg=dat.by.Type$Type, main="Total Population Persons by Types", xlab="Types", ylab="Total Population Persons", ylim=c(0,20000000),col="cyan")
      text(x = graf1, y = dat.by.Type$TotalPopulation_Persons, label = dat.by.Type$TotalPopulation_Persons, pos = 3, cex = 0.8, col = "red")
  }
    else if (dgraf == "Male"){
      barchart(TotalPopulation_Males~Type,data=dt,groups=Type, 
               scales=list(x=list(rot=90000000,cex=0.8)))
    }
    else if (dgraf == "Female"){
      barchart(TotaPopulation_Females~Type,data=dt,groups=Type, 
               scales=list(x=list(rot=90000000,cex=0.8)))
    }
  })
}