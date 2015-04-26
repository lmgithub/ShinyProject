library(shiny)
shinyUI(pageWithSidebar(
    headerPanel("Best place to find a couple"),
    sidebarPanel(
        p('This advisor helps to find a countries where Female/Male population rate is best for your age and gender couple preferences.'),
        h3('I\'m looking for'),
        radioButtons(inputId="gender", label="", choices=vGender, selected=vGender[1]),
        selectInput(inputId="age", label="Age", choices=vAge, selected=vAge[length(vAge)-1]),
        h3('Show'),
        #numericInput(inputId="top", label="Top countries (1-5)", value=3, min=1, max=5, step=1),
        selectInput(inputId="top", label="Top countries", choices=c(1:5), selected=5),
        radioButtons(inputId="units", label="Plot units", choices=vUnits, selected=vUnits[1]),
        h3('Historical data'),
        sliderInput(inputId="year", label="Year", value=max(vYear), min=min(vYear), max=max(vYear), step=1, sep="")
    ),
    mainPanel(
        h3('Top countries'),
        p('Top countries according to your gender and age preferences'),
        tableOutput('topCountries'),
        h3('All countries rate'),
        p('Gender ratio in population in OECD countries'),
        plotOutput('histRate')
    )
))