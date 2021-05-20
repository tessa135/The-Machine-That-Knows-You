#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#install.packages("shinyWidgets")
#install.packages("DBI")
#install.packages("dbplyr")
#install.packages("devtools")
#devtools::install_github("rstudio/pool")
#install.packages('rsconnect')
#install.packages('rappdirs')
#install.packages('maptools')

library(shiny)
library(shinyjs)
library(shinyWidgets)
library(dplyr)
library(e1071)
library(dbplyr)
library(pool)
library(DBI)
library(rappdirs)
library(ggplot2)


library(rsconnect)



# colnames <-
#     c(
#         "E1",
#         "A1",
#         "C1",
#         "N1",
#         "O1",
#         "E2",
#         "A2",
#         "C2",
#         "N2",
#         "O2",
#         "E3",
#         "A3",
#         "C3",
#         "N3",
#         "O3",
#         "E4",
#         "A4",
#         "C4",
#         "N4",
#         "O4",
#         "E5",
#         "A5",
#         "C5",
#         "N5",
#         "O5",
#         "E6",
#         "A6",
#         "C6",
#         "N6",
#         "O6",
#         "E7",
#         "A7",
#         "C7",
#         "N7",
#         "O7",
#         "E8",
#         "A8",
#         "C8",
#         "N8",
#         "O8",
#         "E9",
#         "A9",
#         "C9",
#         "N9",
#         "O9",
#         "E10",
#         "A10",
#         "C10",
#         "N10",
#         "O10"
#     )
# vp <- data.frame(matrix(ncol = 50, nrow = 0))
# colnames(vp) <- colnames


shinyUI(
  fluidPage(
    # Application title
    titlePanel("Experience AI in Lab"),
    #setBackgroundColor("#708090"),
    
    # Style ---------------------
    tags$head(
      HTML(
        "<link rel=\"stylesheet\" type=\"text/css\" href=\"https://cdn.jsdelivr.net/npm/cookieconsent@3/build/cookieconsent.min.css\" />"
      ),
      tags$style(
        type = 'text/css',
        HTML(
          "            *{
                                color: white;
                                background: #708090;
                              }

                             body {
                                width: 80%;
                                font-size: 18px;
                                margin: 0 auto;
                             }

                             .col-xs-3, .col-xs-6 {
                                font-size: 12px;
                             }

                             .col-md-3, .col-md-6, .col-lg-6, .col-lg-3 {
                                font-size: 18px;
                             }

                             .cc-color-override-949397977.cc-window {
                                 background: #708090 !important;
                                 border: 1px solid white;
                             }

                             a.cc-link {
                                  color: white !important;
                             }

                              .cc-color-override-949397977 .cc-btn {
    color: white !important;
    border-color: white !important;
}

                   a {
                                 text-decoration: none;
                                 color: inherit;
                             }

                             .nav-tabs>li>a  {
                                border-color: white !important;
                             }

                             #aufklärungstext p, #consentText p, #consentText a, #consentdiv p{
                                font-size: 14px;
                             }

                             .irs-bar {
                                 border-top: 1px solid #B0C4DE;
                                 border-bottom: 1px solid #B0C4DE;
                                 background: #B0C4DE;
                             }

                             .irs-bar-edge {
                                 border: 1px solid #B0C4DE;
                                 background: #B0C4DE;
                             }

                             .irs-single {
                                background: #B0C4DE;
                                color: #333;
                             }

                             .irs-min, .irs-max {
                                color: #fff;
                                background: rgba(255,255,255,0.1);
                             }

                             .irs--shiny .irs-min, .irs--shiny .irs-max {
                                color: #fff;
                             }

                             .shiny-input-container:not(.shiny-input-container-inline) {
                                 width: 100%;
                                 max-width: 100%;
                             }

                             .irs--shiny .irs-grid-text {
                                color: #fff;
                             }

                             .irs--shiny .irs-grid-pol.small {
                                visibility: hidden;
                             }

                             .irs--shiny .irs-grid-pol {
                                background-color: white;
                             }

                             .fa, .fas {
                                 color: #708090;
                                 background: transparent;
                             }

                             input[type=\"radio\"]:checked:after {
                                width: 15px;
                                height: 15px;
                                border-radius: 15px;
                                top: -2px;
                                left: -1px;
                                position: relative;
                                background-color: #428bca;
                                content: '';
                                display: inline-block;
                                visibility: visible;
                                border: 2px solid white;
                             }

                            input[type=\"radio\"]:after {
                                width: 15px;
                                height: 15px;
                                border-radius: 15px;
                                top: -2px;
                                left: -1px;
                                position: relative;
                                background-color: white;
                                content: '';
                                display: inline-block;
                                visibility: visible;
                                /* border: 2px solid white; */
                            }

                             input[type=\"checkbox\"]:checked:after {
                                width: 17px;
                                height: 17px;
                                position: relative;
                                background-color: #428bca;
                                content: '';
                                display: inline-block;
                                visibility: visible;
                                border: 2px solid white;
                             }

                            input[type=\"checkbox\"]:after {
                                width: 17px;
                                height: 17px;
                                position: relative;
                                background-color: white;
                                content: '';
                                display: inline-block;
                                visibility: visible;
                                /* border: 2px solid white; */
                            }

                            span.wpcc-message {
                            background: #f6f6f6;
                            color: #708090;
                            } 

  "
        )
        
      ),
      #HTML("<script id=\"Cookiebot\" src=\"https://consent.cookiebot.com/uc.js\" data-cbid=\"7745dfe3-a047-41a6-9959-2ecc47c3ccaa\" data-blockingmode=\"auto\" type=\"text/javascript\"></script>")
      # HTML(
      #   "<script type=\"text/javascript\" src=\"//www.cookie-manager.com/f/d4/9f19ac15755c76e8a6332603fe69ffc9.js\"></script>"
      # )
      includeHTML("cookie.js")
      
    ),
    
    shinyjs::useShinyjs(),
    # HTML("<script id=\"CookieDeclaration\" src=\"https://consent.cookiebot.com/7745dfe3-a047-41a6-9959-2ecc47c3ccaa/cd.js\" type=\"text/javascript\" async></script> "),
    
    #HTML("<div class=\"js-acm-cookie-list\"></div>"),
    
    # Start UI --------------------------------------------
    
    tabsetPanel(
      type = "tabs",
      tabPanel(
        "AI",
        br(),
        # Aufklärungstext  ----------------------------------------------------------------------------------
        
        tags$div(
          id = "aufklärung",
          fluidRow(tags$div(
            id = "aufklärungstext",
            column(
              12,
              h2("Aufklärungsbogen"),
              
              p(
                "Die Richtlinien der Deutschen Forschungsgemeinschaft (DFG) sehen vor, dass sich die Teilnehmenden an empirischen Studien mit ihrer Unterschrift explizit und nachvollziehbar einverstanden erklären, dass sie freiwillig an unserer Forschung teilnehmen.
Aus diesem Grund möchten wir Sie bitten, die nachfolgenden Erläuterungen zum Inhalt der Studie zu lesen und untenstehende Einverständniserklärung zu unterzeichnen, sofern Sie damit einverstanden sind."
              ),
              
              strong("Gegenstand der Studie"),
              p(
                "Diese Studie untersucht den Einsatz und das Erleben von echter künstlicher Intelligenz (KI) im Labor, d. h. im Rahmen psychologischer Studien. Die KI ist noch in der Entwicklungsphase. Darum benötigen wir Feedback, das wir im Entwicklungsprozess einfließen lassen können."
              ),
              
              strong("Ablauf der Studie"),
              p(
                "Während der Studie interagieren die Teilnehmenden via Internetbrowser mit einer textbasierten KI, die als virtueller Assistent agiert. Nach bzw. während der Interaktion werden die Teilnehmenden um ihre Einschätzungen und ihr Feedback zur KI und der Interaktion gebeten. Dazu kommen Fragebögen, Interviews sowie die Laut-Denken-Methode zum Einsatz. "
              ),
              
              strong("Dauer & Entlohnung"),
              p(
                "Die Teilnahme an der Studie wird voraussichtlich 5-10 Minuten in Anspruch nehmen."
              ),
              
              strong("Möglicher Nutzen der Studie"),
              p(
                "Der gesellschaftliche Nutzen dieser Studie liegt in der Entwicklung und Verbesserung einer Methode, die zur Erforschung von Nutzendenperspektiven auf neue Technologien – insbesondere auf künstliche Intelligenz – genutzt werden kann. Dieser wissenschaftliche Erkenntnisgewinn kann dazu beitragen, KIs in Zukunft sozialverträglich zu gestalten."
              ),
              
              strong("Mit der Teilnahme verbundene Erfahrungen/Risiken"),
              p(
                "Die Teilnehmenden an dieser Studie werden keinem Risiko ausgesetzt, das über die Risiken des alltäglichen Lebens hinausgeht."
              ),
              
              strong("Hinweis"),
              p(
                "Bitte beachte, dass Du während der Befragung nicht zurück gehen kannst. Lies deswegen die Fragen gründlich und beantworte sie gewissenhaft, bevor du weiter klickst."
              )
              
            )
          )),
          fluidRow(column(12,
                          checkboxInput(
                            "informing",
                            strong("Ich habe den Ablauf des Experiments verstanden", style = "font-size: 14px;")
                          ))),
          
          actionButton('aufklärung_weiter', 'Weiter', icon = icon('arrow-right')),
          br(),
          br()
        ),
        
        
        
        
        # Erklärung zum Datenschutz  ----------------------------------------------------------------------------------
        
        
        #onditionalPanel(
        #  condition = "input.informing == true",
        tags$div(
          id = "einverständnis",
          fluidRow(tags$div(
            id = "consentText",
            column(
              12,
              h2("Erklärung zum Datenschutz"),
              p(
                "Die Datenverarbeitung dieser Studie geschieht nach datenschutzrechtlichen Bestimmungen der Datenschutzgrundverordnung (DSGVO) sowie des Hessischen Datenschutz- und Informationsfreiheitsgesetzes (HDSIG). Die Daten werden ausschließlich für die im Aufklärungsbogen beschriebenen Zwecke verwendet."
              ),
              
              p(
                "Im Rahmen dieser Studie werden folgende Daten erhoben:
Fragebogen zur Interaktion mit der KI (Glaubwürdigkeit, Authentizität, etc.), Notizen aus einem Interview zur Interaktion mit der KI, Bildschirmmitschnitte während der Interaktion mit der KI und Audio-Mitschnitte im Rahmen der Laut-Denken Methode. Bei der Laut-Denken Methode werden wir Sie bitten, während der Interaktion mit der KI Ihre Gedanken frei auszusprechen. Falls die Studie online stattfindet, dann instruieren wir sie bezüglich der Installation und Nutzung der Software, die zur Aufzeichnung und zum sicheren Verschicken der Daten verwendet wird."
              ),
              
              p(
                "Als personenbezogene Daten werden erhoben:
Studienfach, Geschlecht (inkl. divers und keine Angabe) & Alter (in 5er Schritten)."
              ),
              
              p(
                "Zur Abwicklung der Entlohnung wird weiter eine E-Mail-Adresse benötigt. Falls Geld und eine Abwicklung per Überweisung gewünscht ist werden die Konto-Daten der Teilnehmenden benötigt. "
              ),
              
              strong("Vertraulichkeit"),
              p(
                "Alle im Rahmen dieser Studie erhobenen Daten sind werden vertraulich behandelt. Demographische Angaben wie Alter oder Geschlecht lassen keinen eindeutigen Schluss auf Ihre Person zu. Die Daten werden nur in anonymisierter Form veröffentlicht."
              ),
              
              strong("Aufbewahrung"),
              p(
                "Die mit dieser Studie erhobenen Daten werden in Deutschland gespeichert. Gegebenenfalls werden die Daten gemäß den Prinzipien offener und transparenter Wissenschaft vollständig anonym auf einem Wissenschaftsserver veröffentlicht. Diese Einverständniserklärung wird getrennt von den anderen Versuchsmaterialien und Unterlagen aufbewahrt und nach Ablauf von fünf Jahren vernichtet."
              ),
              
              strong("Freiwilligkeit & Rechte der Versuchspersonen"),
              p(
                "Ihre Teilnahme an dieser Untersuchung ist freiwillig. Es steht Ihnen zu jedem Zeitpunkt dieser Studie frei, Ihre Teilnahme abzubrechen und damit diese Einwilligung zurückziehen (Widerruf), ohne dass Ihnen daraus Nachteile entstehen. Wenn Sie die Teilnahme abbrechen, werden keine Daten von Ihnen gespeichert und alle bisher vorliegenden Daten zu Ihrer Person vernichtet."
              ),
              
              p(
                "Sie haben das Recht, Auskunft über die Sie betreffenden personenbezogenen Daten zu erhalten sowie ggf. deren Berichtigung oder Löschung zu verlangen. In Streitfällen haben Sie das Recht, sich beim Hessischen Datenschutzbeauftragten zu beschweren (Adresse s.u.). Bitte beachten Sie, dass die erhobenen Daten anonymisiert sind und ihrer Person nicht zugeordnet werden können. Eine nachträgliche Löschung ist daher nicht möglich."
              ),
              strong(
                "Bei Fragen, Anregungen oder Beschwerden können Sie sich gerne an den Versuchsleiter wenden:"
              ),
              
              p("Julius Frankenbach M.Sc."),
              p("Arbeitsgruppe Pädagogische Psychologie"),
              p("Technische Universität Darmstadt"),
              p("Tel.: +49(0)6151-16-23995"),
              p(
                "Email:",
                a(href = "mailto:julius.frankenbach@tu-darmstadt.de", "julius.frankenbach@tu-darmstadt.de")
              ),
              
              p(
                "Verantwortliche Person für die Datenverarbeitung dieser Studie:"
              ),
              p("Julius Frankenbach M.Sc."),
              p(
                "Email:",
                a(href = "mailto:julius.frankenbach@tu-darmstadt.de", "julius.frankenbach@tu-darmstadt.de")
              ),
              
              p(
                "Bei Fragen zum Datenschutz kann auch der Datenschutzbeauftragte der TU Darmstadt oder die Datenschutzbeauftragte der Hochschule des Bundes für öffentliche Verwaltung kontaktiert werden:"
              ),
              
              p("Gerhard Schmitt"),
              p(
                "Email:",
                a(href = "mailto:datenschutz@tu-darmstadt.de", "datenschutz@tu-darmstadt.de")
              )
            )
          )),
          shinyjs::useShinyjs(),
          fluidRow(column(12, checkboxInput(
            "consent",
            tags$div(
              id = "consentdiv",
              strong("Einverständnis"),
              
              p(
                "Ich habe die Erläuterungen zur Studie gelesen und bin damit einverstanden, an der genannten Studie teilzunehmen."
              ),
              
              p(
                "Ich erkläre mich einverstanden, dass die im Rahmen der Studie erhobenen Daten zu wissenschaftlichen Zwecken ausgewertet und in anonymisierter Form gespeichert werden. Ich bin mir darüber bewusst, dass meine Teilnahme freiwillig erfolgt und ich den Versuch jederzeit und ohne die Angabe von Gründen abbrechen kann."
              )
            )
          ))),
          actionButton('datenschutz_weiter', 'Weiter', icon = icon('arrow-right')),
          br(),
          br()
        ),
        
        
        # Versuchspersonencode  ----------------------------------------------------------------------------------
        
        
        #conditionalPanel(
        #   condition = "input.consent == true",
        tags$div(
          id = "VpcodeText",
          fluidRow(column(
            12,
            p(
              "Bitte erstelle nun deinen Versuchspersonen-Code, damit wir deine hier angegebenen Daten anonym mit den Daten des Fragebogens verknüpfen können."
            ),
            p(
              "Dazu kombiniere bitte die ersten beiden Buchstaben des Vornamens deiner Mutter, mit den ersten beiden Buchstaben des Vornamens deines Vaters und den beiden Ziffern deines Geburtsmonats."
            )
          )),
          br(),
          fluidRow(column(12, p("Ein Beispiel:")),
                   column(
                     6,
                     p("Der Vorname deiner Mutter lautet Birgit"),
                     p("Der Vorname deines Vaters lautet Thorsten"),
                     p("Du bist im Mai geboren."),
                     br()
                   ),
                   column(6,
                          p(strong(
                            "BI"
                          )),
                          p(strong(
                            "TH"
                          )),
                          p(strong(
                            "05"
                          )))),
          fluidRow(column(
            12,
            span("Somit lautet dein Versuchspersonencode:"),
            strong("BITH05"),
            span(".")
          )),
          br(),
          br(),
          fluidRow(column(
            12, textInput("vpcode", "Dein Versuchspersonencode:")
          )),
          
          actionButton('vpc', 'Weiter', icon = icon('arrow-right'))
          # )
        ),
        
        # Models ----------------------------------------------------------------------------------------
        ## First Model  ----------------------------------------------------------------------------------
        # E7 ~ A7 + C4 + E5 + N9 + O4
        
        #conditionalPanel(
        #   condition = "input.vpc == 1",
        
        tags$div(
          id = "questionaire",
          fluidRow(column(
            4, img(src = 'dude.png', style = "padding-left: 50px;")
          ),
          column(8,
                 tags$div(
                   id = "valign",
                   
                   p("Hallo, ich bin dein persönlicher Assistent."),
                   p(
                     "Um dir helfen zu können, muss ich dich besser kennenlernen. Bitte beantworte mir einige Fragen…"
                   ),
                   p("Wie sehr stimmst du den folgenden Aussagen über dich selbst zu?")
                 ))),
          br(),
          br(),
          fluidRow(column(
            6, p("Ich bin nicht wirklich an anderen Menschen interessiert.")
          ),
          column(
            6, sliderInput(
              "A7",
              label = div(
                style = 'width:300px;',
                div(style = 'float:left;', 'Stimme nicht zu'),
                div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          fluidRow(column(6,
                          p("Ich mag Ordnung.")),
                   column(
                     6, sliderInput(
                       "C4",
                       label = div(
                         style = 'width:300px;',
                         div(style = 'float:left;', 'Stimme nicht zu'),
                         div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                       ),
                       ticks = T,
                       min = 1,
                       max = 5,
                       value = 3
                     )
                   )),
          fluidRow(column(
            6, p("Ich habe kein Problem damit im Mittelpunkt zu stehen.")
          ),
          column(
            6, sliderInput(
              "E5",
              label = div(
                style = 'width:300px;',
                div(style = 'float:left;', 'Stimme nicht zu'),
                div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          fluidRow(column(6, p(
            "Ich bin schnell gereizt."
          )),
          column(
            6, sliderInput(
              "N9",
              label = div(
                style = 'width:300px;',
                div(style = 'float:left;', 'Stimme nicht zu'),
                div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          fluidRow(column(
            6, p("Ich bin schnell darin, Dinge zu verstehen.")
          ),
          column(
            6, sliderInput(
              "O4",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          
          
          actionButton('cal', 'Weiter', icon = icon('arrow-right')),
          br(),
          br()
        ),
        
        
        ## First Guess  ----------------------------------------------------------------------------------
        
        
        tags$div(
          id = 'kianswer',
          conditionalPanel(
            condition = "input.cal == 1",
            fluidRow(column(
              12,
              p("Danke, jetzt habe ich ein besseres Bild von dir!"),
              p(
                "Lass mich mein Wissen testen. Bitte überlege dir, was du auf die folgende Frage antworten würdest:"
              )
            )),
            fluidRow(column(
              6, strong("Ich halte mich eher im Hintergrund.")
            ),
            column(
              6,
              sliderInput(
                "think",
                label = div(
                  style = 'width:300px;',
                  div(style =
                        'float:left;', 'Stimme nicht zu'),
                  div(style =
                        '    position: absolute;     right: 15px;', 'Stimme voll zu')
                ),
                ticks = T,
                min = 1,
                max = 5,
                value = 3
              )
            )),
            fluidRow(column(12, p(
              "Hast du dir eine Antwort überlegt?"
            ))),
            actionButton('yes', 'Ja!', icon = icon('check'))
          ),
          br(),
          br(),
          conditionalPanel(
            condition = "input.yes == 1",
            fluidRow(column(
              12, p("Dann sage ich dir jetzt, was ich denke:")
            )),
            fluidRow(column(4, p(
              "Ich denke du hättest"
            )),
            column(4, strong(
              textOutput("result")
            )),
            column(4, p("angekreuzt!"))),
            br(),
            br(),
            fluidRow(column(
              12, radioButtons(
                "yn",
                p("Ist das korrekt?"),
                choices = list("Ja" = 1, "Nein" = 0),
                selected = character(0)
              )
            ))
          ),
          conditionalPanel(
            condition = "input.yn == 0",
            fluidRow(column(12, p(
              "Was hättest du stattdessen gesagt?"
            ))),
            fluidRow(column(
              6, strong("Ich halte mich eher im Hintergrund.")
            ),
            column(
              6, sliderInput(
                "E7",
                label = div(
                  style = 'width:300px;',
                  div(style =
                        'float:left;', 'Stimme nicht zu'),
                  div(style =
                        '    position: absolute;     right: 15px;', 'Stimme voll zu')
                ),
                ticks = T,
                min = 1,
                max = 5,
                value = 3
              )
            )),
            actionButton('ok', 'So stimmt es', icon = icon('check'))
          ),
          br(),
          br()
        ),
        
        
        ## Second Model  ----------------------------------------------------------------------------------
        # O2 ~ A3 + C10 + E7 + N10 + O1 + O4
        
        #conditionalPanel(
        #   condition = "input.yn == 1 || input.ok == 1",
        tags$div(
          id = "weitermachen",
          fluidRow(column(
            12,
            p("Okay super!"),
            br(),
            p(
              "Lass uns weitermachen und sehen, ob ich dich noch ein bisschen besser kennen lernen kann."
            ),
            br(),
            p("Was antwortest du auf folgende Frage?")
          )),
          fluidRow(column(6, strong(
            "Ich habe ein weiches Herz."
          )),
          
          column(
            6, sliderInput(
              "A3",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          fluidRow(column(
            6, strong("Ich drücke mich vor meinen Pflichten.")
          ),
          
          column(
            6,
            sliderInput(
              "C10",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          #Frage für Modell 3 hier, um Ähnlichkeit zu entzerren
          fluidRow(column(
            6,
            strong("Ich interessiere mich nicht für die Probleme anderer Menschen.")
          ),
          
          column(
            6, sliderInput(
              "A9",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          fluidRow(column(
            6, strong("Ich fühle mich oft niedergeschlagen.")
          ),
          
          column(
            6,
            sliderInput(
              "N10",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          fluidRow(column(
            6, strong("Ich habe einen großen Wortschatz.")
          ),
          
          column(
            6, sliderInput(
              "O1",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          actionButton('malsehen', 'Weiter', icon = icon('arrow-right')),
          br(),
          br()
          
        ),
        
        
        ## Second Guess  ----------------------------------------------------------------------------------
        
        tags$div(
          id = 'kianswer2',
          conditionalPanel(
            condition = "input.malsehen == 1",
            br(),
            br(),
            fluidRow(column(
              12,
              p("Danke!"),
              p(
                "Dann schauen wir mal, wie gut ich dich jetzt kenne. Bitte überlege dir, was du auf die folgende Frage antworten würdest:"
              )
            )),
            fluidRow(column(
              6, strong("Ich habe eine lebhafte Phantasie.")
            ),
            column(
              6,
              sliderInput(
                "think2",
                label = div(
                  style = 'width:300px;',
                  div(style =
                        'float:left;', 'Stimme nicht zu'),
                  div(style =
                        '    position: absolute;     right: 15px;', 'Stimme voll zu')
                ),
                ticks = T,
                min = 1,
                max = 5,
                value = 3
              )
            )),
            fluidRow(column(12, p(
              "Hast du dir eine Antwort überlegt?"
            ))),
            actionButton('yes2', 'Ja!', icon = icon('check'))
          ),
          br(),
          br(),
          conditionalPanel(
            condition = "input.yes2 == 1",
            fluidRow(column(
              12, p("Dann sage ich dir jetzt, was ich denke:")
            )),
            fluidRow(column(4, p(
              "Ich denke du hättest"
            )),
            column(4, strong(
              textOutput("answertwo")
            )),
            column(4, p("angekreuzt!"))),
            br(),
            br(),
            fluidRow(column(
              12,
              radioButtons(
                "yn2",
                p("Ist das korrekt?"),
                choices = list("Ja" = 1, "Nein" = 0),
                selected = character(0)
              )
            ))
          ),
          conditionalPanel(
            condition = "input.yn2 == 0",
            fluidRow(column(12, p(
              "Was hättest du stattdessen gesagt?"
            ))),
            fluidRow(column(
              6, strong("Ich habe eine lebhafte Phantasie.")
            ),
            column(
              6, sliderInput(
                "O2",
                label = div(
                  style = 'width:300px;',
                  div(style =
                        'float:left;', 'Stimme nicht zu'),
                  div(style =
                        '    position: absolute;     right: 15px;', 'Stimme voll zu')
                ),
                ticks = T,
                min = 1,
                max = 5,
                value = 3
              )
            )),
            actionButton('ok2', 'So stimmt es', icon = icon('check'))
          ),
          br(),
          br()
          
          #   actionButton('results', 'Zeig mir die Ergebnisse', icon = icon('check'))
        ),
        
        ## Third Model -------------------------------------------
        # A6 ~ A5 + A9 + C6 + E1 + N6 + O2
        
        #conditionalPanel(
        #   condition = "input.yn2 == 1 || input.ok2 == 1",
        
        tags$div(
          id = "thirdquestion",
          fluidRow(column(
            4, img(src = 'dude.png', style = "padding-left: 50px;")
          ),
          column(
            8,
            tags$div(
              id = "valign",
              style = "transform: translateY(50%);",
              p("Okay, weiter geht's!"),
              p("Wie sehr stimmst du den folgenden Aussagen über dich selbst zu?")
            )
          )),
          br(),
          br(),
          fluidRow(column(
            6, strong("Ich kann die Gefühle anderer nachempfinden.")
          ),
          
          column(
            6, sliderInput(
              "A5",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          fluidRow(column(
            6, strong("Ich bin anspruchsvoll bei der Arbeit.")
          ),
          
          column(
            6,
            sliderInput(
              "C6",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          fluidRow(column(
            6, strong("Ich bin der Mittelpunkt der Party.")
          ),
          
          column(
            6, sliderInput(
              "E1",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          fluidRow(column(6, strong(
            "Ich ärgere mich schnell."
          )),
          
          column(
            6, sliderInput(
              "N6",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          
          
          actionButton('tweiter', 'Weiter', icon = icon('arrow-right')),
          br(),
          br()
          
        ),
        
        
        ## Third Guess  ----------------------------------------------------------------------------------
        
        
        tags$div(
          id = 'kianswer3',
          conditionalPanel(
            condition = "input.tweiter == 1",
            fluidRow(column(
              12,
              p("Danke, jetzt habe ich ein besseres Bild von dir!"),
              p(
                "Lass mich mein Wissen testen. Bitte überlege dir, was du auf die folgende Frage antworten würdest:"
              )
            )),
            fluidRow(column(
              6, strong("Ich sorge für das Wohlbefinden anderer Menschen.")
            ),
            column(
              6,
              sliderInput(
                "think3",
                label = div(
                  style = 'width:300px;',
                  div(style =
                        'float:left;', 'Stimme nicht zu'),
                  div(style =
                        '    position: absolute;     right: 15px;', 'Stimme voll zu')
                ),
                ticks = T,
                min = 1,
                max = 5,
                value = 3
              )
            )),
            fluidRow(column(12, p(
              "Hast du dir eine Antwort überlegt?"
            ))),
            actionButton('yes3', 'Ja!', icon = icon('check'))
          ),
          br(),
          br(),
          conditionalPanel(
            condition = "input.yes3 == 1",
            fluidRow(column(
              12, p("Dann sage ich dir jetzt, was ich denke:")
            )),
            fluidRow(column(4, p(
              "Ich denke du hättest"
            )),
            column(4, strong(
              textOutput("answerthree")
            )),
            column(4, p("angekreuzt!"))),
            br(),
            br(),
            fluidRow(column(
              12,
              radioButtons(
                "yn3",
                p("Ist das korrekt?"),
                choices = list("Ja" = 1, "Nein" = 0),
                selected = character(0)
              )
            ))
          ),
          conditionalPanel(
            condition = "input.yn3 == 0",
            fluidRow(column(12, p(
              "Was hättest du stattdessen gesagt?"
            ))),
            fluidRow(column(
              6, strong("Ich sorge für das Wohlbefinden anderer Menschen.")
            ),
            column(
              6, sliderInput(
                "A6",
                label = div(
                  style = 'width:300px;',
                  div(style =
                        'float:left;', 'Stimme nicht zu'),
                  div(style =
                        '    position: absolute;     right: 15px;', 'Stimme voll zu')
                ),
                ticks = T,
                min = 1,
                max = 5,
                value = 3
              )
            )),
            actionButton('ok3', 'So stimmt es', icon = icon('check'))
          ),
          br(),
          br()
        ),
        
        
        ## Fourth Model  ----------------------------------------------------------------------------------
        # A4 ~ A1 + A8 + A6 + A9 + A7 + C6 + E1 + N5 + O2
        # => A4 ~ A1 + A8 + N5
        
        
        #conditionalPanel(
        #   condition = "input.yn3 == 1 || input.ok3 == 1",
        tags$div(
          id = "fourthquestion",
          fluidRow(column(
            12,
            p("Okay super!"),
            br(),
            p(
              "Lass uns weitermachen und sehen, ob ich dich noch ein bisschen besser kennen lernen kann."
            ),
            br(),
            p("Was antwortest du auf folgende Frage?")
          )),
          fluidRow(column(
            6, strong("Ich interessiere mich für Menschen.")
          ),
          
          column(
            6, sliderInput(
              "A1",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          
          fluidRow(column(
            6, strong("Ich lasse mich leicht ablenken.")
          ),
          
          column(
            6, sliderInput(
              "N5",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          fluidRow(column(6, strong(
            "Ich beleidige Menschen."
          )),
          
          column(
            6,
            sliderInput(
              "A8",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          
          
          actionButton('fweiter', 'Weiter', icon = icon('arrow-right')),
          
          br(),
          br()
          
        ),
        
        
        ## Fourth Guess  ----------------------------------------------------------------------------------
        
        tags$div(
          id = 'kianswer4',
          conditionalPanel(
            condition = "input.fweiter == 1",
            br(),
            br(),
            fluidRow(column(
              12,
              p("Danke!"),
              p(
                "Dann schauen wir mal, wie gut ich dich jetzt kenne. Bitte überlege dir, was du auf die folgende Frage antworten würdest:"
              )
            )),
            fluidRow(column(6, strong(
              "Ich nehme mir Zeit für andere."
            )),
            column(
              6,
              sliderInput(
                "think4",
                label = div(
                  style = 'width:300px;',
                  div(style =
                        'float:left;', 'Stimme nicht zu'),
                  div(style =
                        '    position: absolute;     right: 15px;', 'Stimme voll zu')
                ),
                ticks = T,
                min = 1,
                max = 5,
                value = 3
              )
            )),
            fluidRow(column(12, p(
              "Hast du dir eine Antwort überlegt?"
            ))),
            actionButton('yes4', 'Ja!', icon = icon('check'))
          ),
          br(),
          br(),
          conditionalPanel(
            condition = "input.yes4 == 1",
            fluidRow(column(
              12, p("Dann sage ich dir jetzt, was ich denke:")
            )),
            fluidRow(column(4, p(
              "Ich denke du hättest"
            )),
            column(4, strong(
              textOutput("answerfour")
            )),
            column(4, p("angekreuzt!"))),
            br(),
            br(),
            fluidRow(column(
              12,
              radioButtons(
                "yn4",
                p("Ist das korrekt?"),
                choices = list("Ja" = 1, "Nein" = 0),
                selected = character(0)
              )
            ))
          ),
          conditionalPanel(
            condition = "input.yn4 == 0",
            fluidRow(column(12, p(
              "Was hättest du stattdessen gesagt?"
            ))),
            fluidRow(column(6, strong(
              "Ich nehme mir Zeit für andere."
            )),
            column(
              6, sliderInput(
                "A4",
                label = div(
                  style = 'width:300px;',
                  div(style =
                        'float:left;', 'Stimme nicht zu'),
                  div(style =
                        '    position: absolute;     right: 15px;', 'Stimme voll zu')
                ),
                ticks = T,
                min = 1,
                max = 5,
                value = 3
              )
            )),
            actionButton('ok4', 'So stimmt es', icon = icon('check'))
          ),
          br(),
          br()
          
          #   actionButton('results', 'Zeig mir die Ergebnisse', icon = icon('check'))
        ),
        ## Fifth Model  ----------------------------------------------------------------------------------
        # C8 ~ A2 + C5 + C4 + C1 + E4 + N9 + O1
        # => C8 ~ A2 + C5 + C1 + E4
        
        
        #conditionalPanel(
        #   condition = "input.yn3 == 1 || input.ok3 == 1",
        tags$div(
          id = "fifthquestion",
          fluidRow(column(
            12,
            p("Okay super!"),
            br(),
            p(
              "Lass uns weitermachen und sehen, ob ich dich noch ein bisschen besser kennen lernen kann."
            ),
            br(),
            p("Was antwortest du auf folgende Frage?")
          )),
          fluidRow(column(
            6, strong("Ich habe ein Gespür für die Gefühle anderer")
          ),
          
          column(
            6,
            sliderInput(
              "A2",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          fluidRow(column(6, strong(
            "Ich folge einem Zeitplan."
          )),
          
          column(
            6, sliderInput(
              "C5",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          fluidRow(column(6, strong(
            "Ich bin immer vorbereitet."
          )),
          
          column(
            6,
            sliderInput(
              "C1",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          fluidRow(column(
            6,
            strong("Ich spreche mit vielen verschiedenen Menschen auf Parties.")
          ),
          
          column(
            6,
            sliderInput(
              "E4",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          
          actionButton('fiweiter', 'Weiter', icon = icon('arrow-right')),
          
          br(),
          br()
          
        ),
        
        
        ## Fifth Guess  ----------------------------------------------------------------------------------
        
        tags$div(
          id = 'kianswer5',
          conditionalPanel(
            condition = "input.fweiter == 1",
            br(),
            br(),
            fluidRow(column(
              12,
              p("Danke!"),
              p(
                "Dann schauen wir mal, wie gut ich dich jetzt kenne. Bitte überlege dir, was du auf die folgende Frage antworten würdest:"
              )
            )),
            fluidRow(column(6, strong(
              "Ich vermassele Dinge."
            )),
            column(
              6,
              sliderInput(
                "think5",
                label = div(
                  style = 'width:300px;',
                  div(style =
                        'float:left;', 'Stimme nicht zu'),
                  div(style =
                        '    position: absolute;     right: 15px;', 'Stimme voll zu')
                ),
                ticks = T,
                min = 1,
                max = 5,
                value = 3
              )
            )),
            fluidRow(column(12, p(
              "Hast du dir eine Antwort überlegt?"
            ))),
            actionButton('yes5', 'Ja!', icon = icon('check'))
          ),
          br(),
          br(),
          conditionalPanel(
            condition = "input.yes5 == 1",
            fluidRow(column(
              12, p("Dann sage ich dir jetzt, was ich denke:")
            )),
            fluidRow(column(4, p(
              "Ich denke du hättest"
            )),
            column(4, strong(
              textOutput("answerfive")
            )),
            column(4, p("angekreuzt!"))),
            br(),
            br(),
            fluidRow(column(
              12,
              radioButtons(
                "yn5",
                p("Ist das korrekt?"),
                choices = list("Ja" = 1, "Nein" = 0),
                selected = character(0)
              )
            ))
          ),
          conditionalPanel(
            condition = "input.yn5 == 0",
            fluidRow(column(12, p(
              "Was hättest du stattdessen gesagt?"
            ))),
            fluidRow(column(6, strong(
              "Ich vermassele Dinge."
            )),
            column(
              6, sliderInput(
                "C8",
                label = div(
                  style = 'width:300px;',
                  div(style =
                        'float:left;', 'Stimme nicht zu'),
                  div(style =
                        '    position: absolute;     right: 15px;', 'Stimme voll zu')
                ),
                ticks = T,
                min = 1,
                max = 5,
                value = 3
              )
            )),
            actionButton('ok5', 'So stimmt es', icon = icon('check'))
          ),
          br(),
          br()
          
          #   actionButton('results', 'Zeig mir die Ergebnisse', icon = icon('check'))
        ),
        ## Sixth Model  ----------------------------------------------------------------------------------
        # E3 ~ A10 + C8 + E6 + E7 + N6 + O8
        # => E3 ~ A10 + E6 + O8
        
        
        #conditionalPanel(
        #   condition = "input.yn3 == 1 || input.ok3 == 1",
        tags$div(
          id = "sixthquestion",
          fluidRow(column(
            12,
            p("Okay super!"),
            br(),
            p(
              "Lass uns weitermachen und sehen, ob ich dich noch ein bisschen besser kennen lernen kann."
            ),
            br(),
            p("Was antwortest du auf folgende Frage?")
          )),
          
          fluidRow(column(6, strong(
            "Ich sorge mich wenig um andere."
          )),
          column(
            6,
            sliderInput(
              "A10",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          
          fluidRow(column(6, strong(
            "Ich spreche nicht viel."
          )),
          column(
            6, sliderInput(
              "E6",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          
          fluidRow(column(
            6,
            strong("Ich habe Schwierigkeiten, abstrakte Ideen zu verstehen.")
          ),
          column(
            6,
            sliderInput(
              "O8",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          )),
          
          actionButton('sxweiter', 'Weiter', icon = icon('arrow-right')),
          
          br(),
          br()
          
        ),
        
        
        ## Sixth Guess  ----------------------------------------------------------------------------------
        
        tags$div(
          id = 'kianswer6',
          conditionalPanel(
            condition = "input.fweiter == 1",
            br(),
            br(),
            fluidRow(column(
              12,
              p("Danke!"),
              p(
                "Dann schauen wir mal, wie gut ich dich jetzt kenne. Bitte überlege dir, was du auf die folgende Frage antworten würdest:"
              )
            )),
            fluidRow(column(6, strong(
              "Ich beginne Konversationen."
            )),
            column(
              6,
              sliderInput(
                "think6",
                label = div(
                  style = 'width:300px;',
                  div(style =
                        'float:left;', 'Stimme nicht zu'),
                  div(style =
                        '    position: absolute;     right: 15px;', 'Stimme voll zu')
                ),
                ticks = T,
                min = 1,
                max = 5,
                value = 3
              )
            )),
            fluidRow(column(12, p(
              "Hast du dir eine Antwort überlegt?"
            ))),
            actionButton('yes6', 'Ja!', icon = icon('check'))
          ),
          br(),
          br(),
          conditionalPanel(
            condition = "input.yes6 == 1",
            fluidRow(column(
              12, p("Dann sage ich dir jetzt, was ich denke:")
            )),
            fluidRow(column(4, p(
              "Ich denke du hättest"
            )),
            column(4, strong(
              textOutput("answersix")
            )),
            column(4, p("angekreuzt!"))),
            br(),
            br(),
            fluidRow(column(
              12,
              radioButtons(
                "yn6",
                p("Ist das korrekt?"),
                choices = list("Ja" = 1, "Nein" = 0),
                selected = character(0)
              )
            ))
          ),
          conditionalPanel(
            condition = "input.yn6 == 0",
            fluidRow(column(12, p(
              "Was hättest du stattdessen gesagt?"
            ))),
            fluidRow(column(6, strong(
              "Ich beginne Konversationen."
            )),
            column(
              6, sliderInput(
                "E3",
                label = div(
                  style = 'width:300px;',
                  div(style =
                        'float:left;', 'Stimme nicht zu'),
                  div(style =
                        '    position: absolute;     right: 15px;', 'Stimme voll zu')
                ),
                ticks = T,
                min = 1,
                max = 5,
                value = 3
              )
            )),
            actionButton('ok6', 'So stimmt es', icon = icon('check'))
          ),
          br(),
          br()
          
          #   actionButton('results', 'Zeig mir die Ergebnisse', icon = icon('check'))
        ),
        
        
        
        # BFI10 ----------------------
        
        #                 conditionalPanel(
        #                     condition = "input.yn2 == 1 || input.ok2 == 1",
        #                     tags$div(
        #                         id = "bfi10results",
        #
        #                         fluidRow(column(12,
        #                                         tags$div(
        #                                             id = "plottext",
        #
        #                                             p("Vielen Dank!"),
        #
        #                                             p("Das hier habe ich über dich herausgefunden:"),
        #
        #                                         ))),
        #                         fluidRow(column(
        #                             12,
        #                             plotOutput(
        #                                 "plot",
        #                                 width = "100%",
        #                                 height = "400px",
        #                                 click = NULL,
        #                                 dblclick = NULL,
        #                                 hover = NULL,
        #                                 brush = NULL,
        #                                 inline = FALSE
        #                             )
        #                         )),
        #                         br(),
        #                         br(),
        #                         fluidRow(
        #                             column(
        #                                 12,
        #                                 strong("Offenheit"),
        #                                 p(
        #                                     "Menschen mit einer hohen Ausprägung in dem Faktor Offenheit sind vielseitig interessiert, wissbegierig, phantasievoll und experimentierfreudig. Sie lieben das Ungewöhnliche und sind künstlerisch interessiert. Sie sind offen für neue Erfahrungen und hinterfragen bestehende Normen kritisch. Sie sind in der Lage ein unabhängiges Urteil zu fällen und neue Wertvorstellungen anzunehmen.
        # Während eine schwache Ausprägung für Menschen spricht, die Konventionen schätzen und das Bewährte achten. Sie sind konservativ, vorsichtig und bevorzungen das Altbekannte."
        #                                 ),
        #                                 strong("Gewissenhaftigkeit"),
        #                                 p(
        #                                     "Eine hohe Ausprägung von Gewissenhaftigkeit, deutet auf zuverlässige, organisierte, selbstdisziplierte, zielstrebige und pflichtbewusste Menschen hin. Sie planen gerne und arbeiten diszipliniert und effektiv.
        # Eine schwache Ausprägung spricht dagegen für unvorsichtige, sprunghafte Menschen. Während das erst einmal negativ klingt, kann es auch einen unbekümmerten, spontanen Lebenstil bedeuten, in dem man Fünfe auch mal gerade sein lässt."
        #                                 ),
        #
        #                                 strong("Extraversion"),
        #                                 p(
        #                                     "Extravertierte Menschen sind gesellig, aktiv, lieben Spaß und reden viel. Sie handeln gerne spontan und zeigen positive Emotionen. Sie wirken selbstsicher und optimistisch. Sie fühlen sich in in Gruppen und unter Menschen besonders wohl, wo sie netzwerken und neue Menschen kennenlernen können.
        # Währenddessen sind introvertiere Menschen eher zurückhaltend und ruhig. Sie bleiben lieber alleine und suchen sich ihre sozialen Kontakte genau aus."
        #                                 ),
        #
        #                                 strong("Verträglichkeit"),
        #                                 p(
        #                                     "Wie der Name schon sagt, sind Menschen mit einer starken Ausprägung in diesem Faktor umgänglich, mitfühlend, gutmütig, hilfsbereit und kooperativ. Sie sind verständnisvoll und auf Harmonie bedacht, weswegen sie Konflikten häufig aus dem Weg gehen.
        #
        # Unverträglichkeit dagegen zeichnet sich durch wettbewerbsorientiertheit, einem rauen Ton, Sturheit und Konfrontationen aus. Unverträgliche Menschen sind anderen oft misstrauisch gegenüber."
        #                                 ),
        #
        #                                 strong("Neurotizismus"),
        #                                 p(
        #                                     "Eine starke Ausprägung von Neurotizismus zeichnet sich durch eine häufige Annspannung und Besorgnis aus. Menschen mit dieser Ausprägung berichten häufiger, negative Gefühlszustände, wie Unsicherheit, Betroffenheit, Verlegenheit, Angst, Traurigkeit oder Nervosität zu erleben. Das macht sie hochsensibel und stressanfälliger, aber auch empathischer.
        #
        # Eine schwache Ausprägung dagegen steht für ein entspanntes, ungezwungenes, selbstsicheres und zufriedenes Gemüt und daher auch für mehr Stressresistenz."
        #                                 )
        #                             )
        #                         ),
        #                         br(),
        #                         br(),
        #
        #                         actionButton(
        #                             'bfi_weiter',
        #                             'Weiter zur Abschlussbefragung',
        #                             icon = icon('arrow-right')
        #                         )
        #                     ),
        #                     br(),
        #                     br()
        #                 ),
        
        # Abschlussfragebogen  ----------------------------------------------------------------------------------
        
        #conditionalPanel(
        #   condition = "input.yn4 == 1 || input.ok4 == 1",
        
        tags$div(
          id = "abschlussbefragung",
          fluidRow(column(
            12,
            tags$div(
              id = "abschlusstext",
              
              p(
                "Vielen Dank! Die Interaktion mit dem persönlichen Assistenen endet hier."
              ),
              
              p(
                "Bitte fülle nun den nachfolgenden Fragebogen aus, um den persönlichen Assistenten zu bewerten."
              ),
              p(
                "Solltest du den Fragebogen am Handy ausfüllen, empfehlen wir dir für eine optimale Darstellung das Handy quer zu halten."
              )
              
            )
          )),
          br(),
          br(),
          actionButton(
            'abschluss_weiter',
            'Weiter zur Abschlussbefragung',
            icon = icon('arrow-right')
          ),
          br(),
          br()
        ),
        
        
        #conditionalPanel(
        #   condition = "input.abschluss_weiter == 1",
        
        tags$div(
          id = "finalquestionnaire",
          fluidRow(column(12,
                          tags$div(
                            id = "UEQS_Text1",
                            
                            p(
                              "Um den persönlichen Assistenten zu bewerten, fülle bitte den nachfolgenden Fragebogen aus. Er besteht aus Gegensatzpaaren von Eigenschaften, die der persönliche Assistent haben kann. Abstufungen durch einen Slider dargestellt. Durch ziehen des Sliders kannst du deine Zustimmung zu einem Begriff äußern."
                            )
                          ))),
          br(),
          br(),
          fluidRow(
            column(3, p("attraktiv"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "UEQS_Bsp",
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = T,
                min = 1,
                max = 7,
                value = 2
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("unattraktiv"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          
          br(),
          br(),
          
          fluidRow(column(12,
                          tags$div(
                            id = "UEQS_Text2",
                            
                            p(
                              "Mit dieser Beurteilung sagst du aus, dass du den persönlichen Assistenten eher attraktiv als
unattraktiv einschätzt."
                            ),
                            p(
                              "Entscheide möglichst spontan. Es ist wichtig, dass du nicht lange über die Begriffe nachdenkst, damit deine unmittelbare Einschätzung zum Tragen kommt.
Bitte kreuze immer eine Antwort an, auch wenn du bei der Einschätzung zu einem Begriffspaar unsicher bist oder findest, dass es nicht so gut zum persönlicher Assistent passt.
Es gibt keine „richtige“ oder „falsche“ Antwort. Deine persönliche Meinung zählt!"
                            )
                            
                          ))),
          br(),
          br(),
          
          ## UEQS: User Experience  ----------------------------------------------------------------------------------
          
          fluidRow(
            column(3, p("behindernd"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "UEQS_1",
                
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 7,
                value = 4
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("unterstützend"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          fluidRow(
            column(3, p("kompliziert"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "UEQS_2",
                
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 7,
                value = 4
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("einfach"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          fluidRow(
            column(3, p("ineffizient"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "UEQS_3",
                
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 7,
                value = 4
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("effizient"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          fluidRow(
            column(3, p("verwirrend"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "UEQS_4",
                
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 7,
                value = 4
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("übersichtlich"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          fluidRow(
            column(3, p("langweilig"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "UEQS_5",
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 7,
                value = 4
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("spannend"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          fluidRow(
            column(3, p("uninteressant"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "UEQS_6",
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 7,
                value = 4
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("interessant"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          fluidRow(
            column(3, p("konventionell"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "UEQS_7",
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 7,
                value = 4
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("originell"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          fluidRow(
            column(3, p("herkömmlich"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "UEQS_8",
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 7,
                value = 4
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("neuartig"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          
          actionButton('UEQS_weiter', 'Weiter', icon = icon('arrow-right')),
          br(),
          br()
          
        ),
        
        ## Godspeed 3: Sympathie  ----------------------------------------------------------------------------------
        
        # conditionalPanel(
        #    condition = "input.UEQS_weiter == 1",
        
        tags$div(
          id = "godspeed3",
          br(),
          br(),
          fluidRow(column(
            12,
            p(
              "Bitte bewerte deinen Eindruck des persönlichen Assistenten in folgenden Aspekten:"
            )
          )),
          br(),
          fluidRow(
            column(3, p("missfallen"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "GQS_3_1",
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 5,
                value = 3
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("gefallen"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          fluidRow(
            column(3, p("unfreundlich"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "GQS_3_2",
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 5,
                value = 3
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("freundlich"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          fluidRow(
            column(3, p("unhöflich"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "GQS_3_3",
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 5,
                value = 3
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("höflich"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          fluidRow(
            column(3, p("unangenehm"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "GQS_3_4",
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 5,
                value = 3
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("angenehm"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          fluidRow(
            column(3, p("furchtbar"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "GQS_3_5",
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 5,
                value = 3
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("nett"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          
          actionButton('GQS_3_weiter', 'Weiter', icon = icon('arrow-right')),
          br(),
          br()
          
        ),
        
        ## Godspeed 4: Kompetenz  ----------------------------------------------------------------------------------
        
        # conditionalPanel(
        #    condition = "input.GQS_3_weiter == 1",
        
        tags$div(
          id = "godspeed4",
          br(),
          br(),
          fluidRow(column(
            12,
            p(
              "Bitte bewerte deinen Eindruck des persönlichen Assistenten in folgenden Aspekten:"
            )
          )),
          br(),
          fluidRow(
            column(3, p("inkompetent"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "GQS_4_1",
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 5,
                value = 3
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("kompetent"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          fluidRow(
            column(3, p("ungebildet"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "GQS_4_2",
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 5,
                value = 3
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("sachkundig"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          fluidRow(
            column(3, p("verantwortungslos"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "GQS_4_3",
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 5,
                value = 3
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("verantwortungsbewusst"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          fluidRow(
            column(3, p("unintelligent"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "GQS_4_4",
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 5,
                value = 3
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("intelligent"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          fluidRow(
            column(3, p("unvernünftig"), class = "col-xs-3 col-md-3 col-lg-3"),
            column(
              6,
              sliderInput(
                "GQS_4_5",
                NULL,
                # label = div(
                #     style = 'width:300px;',
                #     div(style = 'float:left;', 'Stimme nicht zu'),
                #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                # ),
                ticks = F,
                min = 1,
                max = 5,
                value = 3
              ),
              class = "col-xs-6 col-md-6 col-lg-6"
            ),
            column(3, p("vernünftig"), class = "col-xs-3 col-md-3 col-lg-3")
          ),
          
          actionButton('GQS_4_weiter', 'Weiter', icon = icon('arrow-right')),
          br(),
          br()
        ),
        
        ## KIT: Vertrauen  ----------------------------------------------------------------------------------
        
        # conditionalPanel(
        #    condition = "input.GQS_4_weiter == 1",
        
        tags$div(
          id = "KIT_questions",
          
          fluidRow(column(
            12,
            p(
              "Bitte wähle bei den folgenden Aussagen die Ausprägung, die deiner persönlichen Einschätzung am ehesten entspricht."
            )
          )),
          br(),
          br(),
          fluidRow(column(
            6, p("Der persönliche Assistent ist irreführend.")
          ),
          column(
            6,
            sliderInput(
              "KIT_1",
              label = div(
                style = 'width:300px;',
                div(style = 'float:left;', 'Stimme nicht zu'),
                div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 7,
              value = 4
            )
          )),
          fluidRow(column(
            6,
            p("Der persönliche Assistent verhält sich undurchsichtig.")
          ),
          column(
            6,
            sliderInput(
              "KIT_2",
              label = div(
                style = 'width:300px;',
                div(style = 'float:left;', 'Stimme nicht zu'),
                div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 7,
              value = 4
            )
          )),
          fluidRow(column(
            6,
            p("Ich misstraue den Entscheidungen des persönlichen Assistenten.")
          ),
          column(
            6,
            sliderInput(
              "KIT_3",
              label = div(
                style = 'width:300px;',
                div(style = 'float:left;', 'Stimme nicht zu'),
                div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 7,
              value = 4
            )
          )),
          fluidRow(column(
            6,
            p(
              "Ich muss vorsichtig im Umgang mit dem persönlichen Assistenten sein."
            )
          ),
          column(
            6,
            sliderInput(
              "KIT_4",
              label = div(
                style = 'width:300px;',
                div(style = 'float:left;', 'Stimme nicht zu'),
                div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 7,
              value = 4
            )
          )),
          fluidRow(column(
            6,
            p(
              "Die Handlungen des persönlichen Assistenten haben negative Auswirkungen zur Folge."
            )
          ),
          column(
            6,
            sliderInput(
              "KIT_5",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 7,
              value = 4
            )
          )),
          fluidRow(column(
            6, p("Der persönliche Assistent bietet Sicherheit.")
          ),
          column(
            6,
            sliderInput(
              "KIT_6",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 7,
              value = 4
            )
          )),
          fluidRow(column(
            6, p("Der persönliche Assistent arbeitet tadellos.")
          ),
          column(
            6,
            sliderInput(
              "KIT_7",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 7,
              value = 4
            )
          )),
          fluidRow(column(
            6, p("Der persönliche Assistent ist verlässlich.")
          ),
          column(
            6,
            sliderInput(
              "KIT_8",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 7,
              value = 4
            )
          )),
          fluidRow(column(
            6, p("Der persönliche Assistent ist vertrauenswürdig.")
          ),
          column(
            6,
            sliderInput(
              "KIT_9",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 7,
              value = 4
            )
          )),
          fluidRow(column(
            6, p("Ich kann dem persönlichen Assistenten vertrauen.")
          ),
          column(
            6,
            sliderInput(
              "KIT_10",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 7,
              value = 4
            )
          )),
          fluidRow(column(
            6, p("Ich kenne mich mit dem persönlichen Assistenten aus.")
          ),
          column(
            6,
            sliderInput(
              "KIT_11",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Stimme nicht zu'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Stimme voll zu')
              ),
              ticks = T,
              min = 1,
              max = 7,
              value = 4
            )
          )),
          
          
          actionButton('KIT_weiter', 'Weiter', icon = icon('arrow-right')),
          br(),
          br()
          
        ),
        
        ## Godspeed 5: Sicherheit  ----------------------------------------------------------------------------------
        
        #conditionalPanel(
        #   condition = "input.KIT_weiter == 1",
        
        tags$div(
          id = "godspeed5",
          br(),
          br(),
          fluidRow(column(
            12,
            span("Bitte bewerte"),
            strong("deine aktuelle Gefühlslage:")
          )),
          br(),
          fluidRow(column(3, p("ängstlich")),
                   column(
                     6, sliderInput(
                       "GQS_5_1",
                       NULL,
                       # label = div(
                       #     style = 'width:300px;',
                       #     div(style = 'float:left;', 'Stimme nicht zu'),
                       #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                       # ),
                       ticks = F,
                       min = 1,
                       max = 5,
                       value = 3
                     )
                   ),
                   column(3, p("entspannt"))),
          fluidRow(column(3, p("ruhig")),
                   column(
                     6, sliderInput(
                       "GQS_5_2",
                       NULL,
                       # label = div(
                       #     style = 'width:300px;',
                       #     div(style = 'float:left;', 'Stimme nicht zu'),
                       #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                       # ),
                       ticks = F,
                       min = 1,
                       max = 5,
                       value = 3
                     )
                   ),
                   column(3, p("aufgewühlt"))),
          fluidRow(column(3, p("still")),
                   column(
                     6, sliderInput(
                       "GQS_5_3",
                       NULL,
                       # label = div(
                       #     style = 'width:300px;',
                       #     div(style = 'float:left;', 'Stimme nicht zu'),
                       #     div(style = '    position: absolute;     right: 15px;', 'Stimme voll zu')
                       # ),
                       ticks = F,
                       min = 1,
                       max = 5,
                       value = 3
                     )
                   ),
                   column(3, p("überrascht"))),
          
          
          actionButton('GQS_5_weiter', 'Weiter', icon = icon('arrow-right')),
          br(),
          br()
          
        ),
        
        ## Anmerkungen ----------------------------------------------------------------------------------
        
        #conditionalPanel(
        #   condition = "input.GQS_5_weiter == 1",
        
        # tags$div(
        #   id = "Anmerkungen_",
        #   fluidRow(column(
        #     12,
        #     tags$div(
        #       id = "anmerkungen_Text",
        #
        #       p(
        #         "Gibt es noch weitere Anmerkungen, die du zu dem persönlichen Assistenten, dem Aufbau oder dem Design machen möchtest?"
        #       ),
        #       p(
        #         "Sollten wir noch etwas vor der endgültigen Veröffentlichung beachten?"
        #       )
        #     )
        #   )),
        #   br(),
        #   br(),
        #
        #   fluidRow(column(
        #     12,
        #     textAreaInput("anmerkungen", NULL, value = "", height = "300px")
        #   )),
        #
        #   actionButton('Anmerkungen_weiter', 'Weiter', icon = icon('arrow-right')),
        #   br(),
        #   br()
        #
        # ),
        
        ## KUSIV3: allgemeines Vertrauen  ----------------------------------------------------------------------------------
        
        # conditionalPanel(
        #     condition = "input.KIT_weiter == 1",
        #
        #     tags$div(
        #         id = "KUSIV3",
        #
        #         fluidRow(column(
        #             6,
        #             p(
        #                 "Ich bin davon überzeugt, dass die meisten Menschen gute Absichten haben."
        #             )
        #         ),
        #         column(
        #             6,
        #             sliderInput(
        #                 "KUSIV3_1",
        #                 label = div(
        #                     style = 'width:300px;',
        #                     div(style =
        #                             'float:left;', 'Stimme nicht zu'),
        #                     div(style =
        #                             '    position: absolute;     right: 15px;', 'Stimme voll zu')
        #                 ),
        #                 ticks = T,
        #                 min = 1,
        #                 max = 5,
        #                 value = 3
        #             )
        #         )),
        #         fluidRow(column(
        #             6, p("Heutzutage kann man sich auf niemanden mehr verlassen..")
        #         ),
        #         column(
        #             6,
        #             sliderInput(
        #                 "KUSIV3_2",
        #                 label = div(
        #                     style = 'width:300px;',
        #                     div(style =
        #                             'float:left;', 'Stimme nicht zu'),
        #                     div(style =
        #                             '    position: absolute;     right: 15px;', 'Stimme voll zu')
        #                 ),
        #                 ticks = T,
        #                 min = 1,
        #                 max = 5,
        #                 value = 3
        #             )
        #         )),
        #         fluidRow(column(
        #             6, p("Im Allgemeinen kann man den Menschen vertrauen.")
        #         ),
        #         column(
        #             6,
        #             sliderInput(
        #                 "KUSIV3_3",
        #                 label = div(
        #                     style = 'width:300px;',
        #                     div(style =
        #                             'float:left;', 'Stimme nicht zu'),
        #                     div(style =
        #                             '    position: absolute;     right: 15px;', 'Stimme voll zu')
        #                 ),
        #                 ticks = T,
        #                 min = 1,
        #                 max = 5,
        #                 value = 3
        #             )
        #         )),
        #
        #
        #         actionButton('KUSIV3_weiter', 'Weiter', icon = icon('arrow-right')),
        #         br(),
        #         br()
        #     )
        # ),
        
        ## Soziodemographische Daten  ----------------------------------------------------------------------------------
        
        
        #conditionalPanel(
        #   condition = "input.Anmerkungen_weiter == 1",
        
        tags$div(
          id = "sd_questions_text",
          fluidRow(column(12,
                          tags$div(
                            id = "SD_Text",
                            
                            p("Vielen Dank! Zum Schluss noch drei Fragen zu dir:"),
                            
                          ))),
          br(),
          br(),
          
          column(
            6,
            p(
              "Hattest du Spaß bei der Interaktion mit dem persönlichen Assistenten?"
            )
          ),
          column(
            6,
            sliderInput(
              "fun",
              label = div(
                style = 'width:300px;',
                div(style =
                      'float:left;', 'Nein'),
                div(style =
                      '    position: absolute;     right: 15px;', 'Ja')
              ),
              ticks = T,
              min = 1,
              max = 5,
              value = 3
            )
          ),
          br(),
          
          fluidRow(column(6, p("Geschlecht")),
                   column(
                     6, radioButtons(
                       "sex",
                       NULL,
                       choices = list(
                         "Weiblich" = 0,
                         "Männlich" = 1,
                         "Nichtbinär/Genderqueer" = 2,
                         "Anderes" = 3,
                         "Keine Angabe" = 4
                       ),
                       selected = 4
                     )
                   )),
          
          fluidRow(column(
            12, numericInput(
              "age",
              "Alter",
              0,
              min = 1,
              max = 120,
              step = 1
            )
          )),
          
          actionButton('SD_weiter', 'Fertig', icon = icon('arrow-right')),
          br(),
          br()
          
        ),
        # Abschluss ----------------------------------------------------------------------------------
        
        # conditionalPanel(
        #    condition = "input.SD_weiter ==1",
        
        tags$div(id = "end",
                 
                 fluidRow(column(
                   12,
                   tags$div(id = "end",
                            
                            strong("Vielen Dank für deine Teilnahme!"))
                 )),
                 br(),
                 br(),
                 
                 fluidRow(column(
                   12, 
                   p("Dein Link für zur Gewinnspielteilnahme bei thesius.de:"), 
                   p(a(href = "https://www.thesius.de/umfrage/masterarbeit-thema-bkRLB5Ka/lejlmKvb", "https://www.thesius.de/umfrage/masterarbeit-thema-bkRLB5Ka/lejlmKvb"))
                  
                 ),
                 column(12, 
                        p("Für Nutzer von SurveyCircle (www.surveycircle.com): Der Survey Code lautet: TBV9-71XX-J3NK-HLZZ")),
                 br(),
                 column(12, 
                        p("Für Nutzer von SurveySwap (www.SurveySwap.io):"),
                        p(a(href = "https://surveyswap.io/sr/LhpO0SJhdiXUwiW9", "https://surveyswap.io/sr/LhpO0SJhdiXUwiW9"))
                 )),
       
                 
                 ## MTurk ----------------------------------
                 # fluidRow(column(
                 #     12,
                 #     radioButtons(
                 #         "MTurk",
                 #         p("Hast Du an der Studie im Rahmen von Prolific teilgenommen und benötigst einen Code?"),
                 #         choices = list("Ja" = 1, "Nein" = 0),
                 #         selected = character(0)
                 #     )
                 #
                 # )),
                 #
                 # conditionalPanel(
                 #     condition = "input.MTurk == 1",
                 #
                 #                  fluidRow(column(
                 #                      6, p("Dein Code lautet:")
                 #                  ),
                 #                  column(
                 #                      6, textOutput("Code")
                 #                  ))),
                 
                 #actionButton("end", "Beenden", icon = icon('times')),
                 fluidRow(column(
                   12, p("Du kannst das Fenster nun schließen.")
                 )))
        
      ),
      
      #
      #Impressum --------------------------------------
      
      tabPanel("Impressum",
               includeHTML("impressum.html")),
      #Datenschutz --------------------------------------
      tabPanel("Datenschutz",
               includeHTML("datenschutz.html"),
               # HTML(
               #   "<script type=\"text/javascript\" src=\"//www.cookie-manager.com/f/d4/cookie-list-9f19ac15755c76e8a6332603fe69ffc9.js\"></script>"
               # ))
      )
      
      
      # Cookie Banner Skript --------------------------------------------------
      
      #     HTML("<script src=\"https://cdn.jsdelivr.net/npm/cookieconsent@3/build/cookieconsent.min.js\" data-cfasync=\"false\"></script>
      # <script>
      # window.cookieconsent.initialise({
      #   \"palette\": {
      #     \"popup\": {
      #       \"background\": \"#edeff5\",
      #          \"text\": \"#838391\"
      #          },
      # \"button\": {
      #   \"background\": \"transparent\",
      #   \"text\": \"#4b81e8\",
      #   \"border\": \"#4b81e8\"
      # }
      # },
      # \"position\": \"bottom-right\",
      # \"content\": {
      #   \"message\": \"Diese Webseite nutzt ausschließlich Cookies, die zur Verwendung der Seite notwendig sind. \",
      #   \"dismiss\": \"Einverstanden\",
      #   \"link\": \"Erfahren Sie mehr\"
      # }
      # });
      # </script>")
      
      #HTML("<script type=\"text/javascript\" src=\"https://cookieconsent.popupsmart.com/src/js/popper.js\"></script><script> window.start.init({Palette:\"palette2\",Mode:\"floating right\",Theme:\"wire\",Message:\"Diese Website nutzt ausschließlich notwendige Cookies um optimal funktionieren zu können. \",ButtonText:\"Zustimmen\",LinkText:\"Datenschutz\",Time:\"5\",})</script>")
      
    )
  )
  )
  