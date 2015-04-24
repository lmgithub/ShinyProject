# library(shiny)
# library(ggplot2)
# dsSample <- read.csv("Data/Sample_3034_2012.csv", header=TRUE)


shinyServer(function(input, output) {
    # Table 
    output$topCountries <- renderTable({
        # select data by year and age group
        dsTmp <- subset(ds, Gender==input$gender & Year==input$year & Age.groups==input$age, select=c(Country, value, Rate))
        dsTmp <- head(dsTmp[order(-dsTmp$Rate), ], input$top)
        names(dsTmp) <- c("Country", paste(input$gender, "(in thousands)"), "% of population")
        dsTmp
    })
    # Plot
    output$histRate <- renderPlot({
        # select data by year and age group
        dsTmp <- subset(ds, Year==input$year & Age.groups==input$age, select=c(Country, Gender, value, Rate)) 
        dsTmp$so <- 0
        # ordering Females
        dsTmp[dsTmp$Gender=="Females", ] <- dsTmp[order(-dsTmp$Rate[dsTmp$Gender=="Females"]), ]
        # setting sort order variable
        dsTmp$so[dsTmp$Gender=="Females"] <- c(1:length(dsTmp$so[dsTmp$Gender=="Females"]))
        # calculating unit labels
        if(input$units==vUnits[2]) {
            dsTmp$ulabels <- round(dsTmp$value/1000, 0)
        }
        else {
            dsTmp$ulabels <- paste(format(dsTmp$Rate, digits=4), "%") 
        }
        # Plotting
        ggplot(dsTmp, aes(x=reorder(Country, -so), y=Rate-35, fill=Gender)) + 
            geom_bar(stat="identity") + 
            coord_flip() + 
            geom_hline(yintercept=15, colour="darkgray") + 
            geom_text(aes(y=ifelse(Gender=="Females", 5, 25), label=ulabels), colour="white", size=2.5, fontface="italic") +
            theme(legend.position="top", legend.title=element_blank(), axis.text.x=element_blank()) + 
            scale_fill_manual(values=c("hotpink1", "slateblue1")) + 
            labs(x="Countries", y=input$units)
    })
    
})
