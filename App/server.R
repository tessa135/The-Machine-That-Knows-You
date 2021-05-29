#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinyjs)
library(RMySQL)
library(ggplot2)

# Load Models  ---------------------

premodel <-
    readRDS(file = "svmmodel_E7~A7+C4+E5+N9+O4.rds")

premodel2 <-
    readRDS(file = "svmmodel_O2~A3+C10+E7+N10+O1+O4.rds")

premodel3 <-
    readRDS(file = "svmmodel_A6~A5+A9+C6+E1+N6+O2.rds")

premodel4 <-
    readRDS(file = "svmmodel_A4~A1+A8+A6+A9+A7+C6+E1+N5+O2.rds")

premodel5 <-
    readRDS(file = "svmmodel_C8~A2+C5+C4+C1+E4+N9+O1.rds")

premodel6 <-
    readRDS(file = "svmmodel_E3~A10+C8+E6+E7+N6+O8.rds")

# Start Server Functions   ---------------------


server <- function(input, output, session) {
    shinyjs::useShinyjs()
    
    # JS ---------------------
   
    shinyjs::runjs("$('#vpcode').attr('maxlength', 6)")
    
    ## Hide every block on load  ---------
    shinyjs::hide(id = "einverständnis")
    shinyjs::hide(id = "VpcodeText")
    shinyjs::hide(id = "questionaire")
    shinyjs::hide(id = "kianswer")
    shinyjs::hide(id = "weitermachen")
    shinyjs::hide(id = "kianswer2")
    shinyjs::hide(id = "thirdquestion")
    shinyjs::hide(id = "kianswer3")
    shinyjs::hide(id = "fourthquestion")
    shinyjs::hide(id = "kianswer4")
    shinyjs::hide(id = "fifthquestion")
    shinyjs::hide(id = "kianswer5")
    shinyjs::hide(id = "sixthquestion")
    shinyjs::hide(id = "kianswer6")
    shinyjs::hide(id = "abschlussbefragung")
    shinyjs::hide(id = "finalquestionnaire")
    shinyjs::hide(id = "godspeed3")
    shinyjs::hide(id = "godspeed4")
    shinyjs::hide(id = "KIT_questions")
    shinyjs::hide(id = "godspeed5")
    shinyjs::hide(id = "Anmerkungen_")
    shinyjs::hide(id = "sd_questions_text")
    shinyjs::hide(id = "end")
    
    
    
    # observeEvent(input$ok2, {
    # if(ok2 == 1) {
    # shinyjs::runjs("function changebackground () {
    #
    #                document.querySelector('*').style.color = \"#333 !important\";
    #                document.querySelector('*').style.backgroundColor = \"#fff !important\";
    #
    #                }
    # }")}})
    
    
    # Hide and Disable   ---------------------
    
    observeEvent(input$aufklärung_weiter,
                 if (input$informing == TRUE) {
                     shinyjs::hide("aufklärung")
                     
                     shinyjs::show("einverständnis")
                 })
    
    observeEvent(input$datenschutz_weiter,
                 if (input$consent == TRUE) {
                     shinyjs::hide("einverständnis")
                     
                     shinyjs::show("VpcodeText")
                 })
    
    observeEvent(input$cal,
                 if (input$cal == 1) {
                     shinyjs::hide("questionaire")
                     
                     shinyjs::show("kianswer")
                 })
    
    observeEvent(input$tweiter,
                 if (input$tweiter == 1) {
                     shinyjs::hide("thirdquestion")
                     
                     shinyjs::show(id = "kianswer3")
                 })
    
    observeEvent(input$fweiter,
                 if (input$fweiter == 1) {
                     shinyjs::hide("fourthquestion")
                     
                     shinyjs::show(id = "kianswer4")
                     
                 })
    
    observeEvent(input$fiweiter,
                 if (input$tweiter == 1) {
                     shinyjs::hide("fifthquestion")
                     
                     shinyjs::show(id = "kianswer5")
                 })
    
    observeEvent(input$sxweiter,
                 if (input$fweiter == 1) {
                     shinyjs::hide("sixthquestion")
                     
                     shinyjs::show(id = "kianswer6")
                     
                 })
    
    d <- reactiveValues(e7 = NULL)
    
    observeEvent(input$ok, {
        if (input$ok == 1) {
            shinyjs::hide("kianswer")
            d$e7 <<- input$E7
            
            shinyjs::show("weitermachen")
        }
    })
    
    observeEvent(input$malsehen,
                 if (input$malsehen == 1) {
                     shinyjs::hide("weitermachen")
                     
                     shinyjs::show(id = "kianswer2")
                 })
    
    observeEvent(input$think,
                 shinyjs::disable("think"))
    
    observeEvent(input$think2,
                 shinyjs::disable("think2"))
    
    observeEvent(input$think3,
                 shinyjs::disable("think3"))
    
    observeEvent(input$think4,
                 shinyjs::disable("think4"))
    
    observeEvent(input$think5,
                 shinyjs::disable("think5"))
    
    observeEvent(input$think6,
                 shinyjs::disable("think6"))
    
    
    observeEvent(input$yes,
                 if (input$yes == 1) {
                     shinyjs::disable("yes")
                 })
    
    observeEvent(input$yes2,
                 if (input$yes2 == 1) {
                     shinyjs::disable("yes2")
                 })
    
    observeEvent(input$yes3,
                 if (input$yes3 == 1) {
                     shinyjs::disable("yes3")
                 })
    
    observeEvent(input$yes4,
                 if (input$yes4 == 1) {
                     shinyjs::disable("yes4")
                 })
    
    observeEvent(input$yes5,
                 if (input$yes5 == 1) {
                     shinyjs::disable("yes5")
                 })
    
    observeEvent(input$yes6,
                 if (input$yes6 == 1) {
                     shinyjs::disable("yes6")
                 })
    
    observeEvent(input$ok2,
                 if (input$ok2 == 1) {
                     shinyjs::hide("kianswer2")
                     
                     shinyjs::show(id = "thirdquestion")
                 })
    
    observeEvent(input$ok3,
                 if (input$ok3 == 1) {
                     shinyjs::hide("kianswer3")
                     
                     shinyjs::show(id = "fourthquestion")
                 })
    
    observeEvent(input$ok4,
                 if (input$ok4 == 1) {
                     shinyjs::hide("kianswer4")
                     
                     shinyjs::show(id = "fifthquestion")
                 })
    
    observeEvent(input$ok5,
                 if (input$ok5 == 1) {
                     shinyjs::hide("kianswer5")
                     
                     shinyjs::show(id = "sixthquestion")
                 })
    
    observeEvent(input$ok6,
                 if (input$ok6 == 1) {
                     shinyjs::hide("kianswer6")
                     
                     shinyjs::show(id = "abschlussbefragung")
                 })
    
    
    # observeEvent(input$bfi_weiter,
    #              if (input$bfi_weiter == 1) {
    #                  shinyjs::hide("bfi10results")
    #              })
    
    observeEvent(input$abschluss_weiter,
                 if (input$abschluss_weiter == 1) {
                     shinyjs::hide('abschlussbefragung')
                     
                     shinyjs::show("finalquestionnaire")
                 })
    
    # observeEvent(input$Anmerkungen_weiter,
    #              if (input$Anmerkungen_weiter == 1) {
    #                  shinyjs::hide('Anmerkungen_')
    #                  
    #                  shinyjs::show(id = "sd_questions_text")
    #              })
    
    observeEvent(input$UEQS_weiter,
                 if (input$UEQS_weiter == 1) {
                     shinyjs::hide("finalquestionnaire")
                     
                     shinyjs::show(id = "godspeed3")
                 })
    
    observeEvent(input$GQS_3_weiter,
                 if (input$GQS_3_weiter == 1) {
                     shinyjs::hide("godspeed3")
                     
                     shinyjs::show("godspeed4")
                 })
    
    observeEvent(input$GQS_4_weiter,
                 if (input$GQS_4_weiter == 1) {
                     shinyjs::hide("godspeed4")
                     
                     shinyjs::show("KIT_questions")
                 })
    
    observeEvent(input$GQS_5_weiter,
                 if (input$GQS_5_weiter == 1) {
                     shinyjs::hide("godspeed5")
                     
                     shinyjs::show(id = "sd_questions_text")
                 })
    
    observeEvent(input$KIT_weiter,
                 if (input$KIT_weiter == 1) {
                     shinyjs::hide("KIT_questions")
                     
                     shinyjs::show(id = "godspeed5")
                 })
    
    # observeEvent(input$KUSIV3_weiter,
    #              if (input$KUSIV3_weiter == 1) {
    #                  shinyjs::hide("KUSIV3")
    #              })
    
    
    observeEvent(input$UEQS_Bsp,
                 shinyjs::disable("UEQS_Bsp"))
    
    observeEvent(input$vpc,
                 if (input$vpc == 1) {
                     shinyjs::hide("VpcodeText")
                     
                     b <- toupper(input$vpcode)
                     
                     conn <- dbConnect(
                         drv = RMySQL::MySQL(),
                         dbname = "KI",
                         host = "host",
                         username = "user",
                         password = "password"
                     )
                     on.exit(dbDisconnect(conn), add = TRUE)
                     
                     dbSendQuery(
                         conn,
                         paste0(
                             "INSERT INTO Consent (VPCode, Session, informing, Consent) VALUES(\"",
                             b,
                             "\",\"",
                             session$token, 
                             "\",",
                             as.integer(as.logical(input$informing)),
                             ",",
                             as.integer(as.logical(input$consent)),
                             ");"
                         )
                     )
                     
                     dbSendQuery(conn,
                                 paste0("INSERT INTO User_Input (VPCode, Session) VALUES(\"",
                                        b,"\",\"",session$token,
                                        "\");"))
                     
                     dbSendQuery(conn,
                                 paste0(
                                     "INSERT INTO Final_Questionnaire (VPCode, Session) VALUES(\"",
                                     b,"\",\"",session$token,
                                     "\");"
                                 ))
                     
                     shinyjs::show("questionaire")
                 })
    
    # Predictions -----------------------------------
    
    ## Prediction 1 ####
    # E7 ~ A7 + C4 + E5 + N9 + O4
    
    a <- reactiveValues(result = NULL)
    r <- reactiveValues()
    
    
    observeEvent(input$cal, {
        values <<- data.frame(
            A7 = input$A7,
            C4 = input$C4,
            E5 = input$E5,
            N9 = input$N9,
            O4 = input$O4
        )
        
        r <<- round(predict(premodel, values)[[1]])
        
        if (r == "1") {
            a$result <- "Stimme überhaupt nicht zu (1)"
        }
        else if (r == "2") {
            a$result <- "Stimme teilweise nicht zu (2)"
        }
        else if (r == "3") {
            a$result <- "Teils / Teils (3)"
        }
        else if (r == "4") {
            a$result <- "Stimme teilweise zu (4)"
        }
        else if (r == "5") {
            a$result <- "Stimme voll und ganz zu (5)"
        }
        
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET A7 =",
                input$A7,
                ", C4=",
                input$C4,
                ", E5=",
                input$E5,
                ", N9=",
                input$N9,
                ", O4=",
                input$O4,
                ", Prediction1=",
                as.integer(r),
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
    })
    
    output$result <- renderText(a$result)
    
    ## Prediction 2 ####
    # O2 ~ A3 + C10 + E7 + N10 + O1 + O4
    
    as <- reactiveValues(result = NULL)
    rs <- reactiveValues()
    
    
    observeEvent(input$yes2, {
        if (input$E7 > 0) {
            e7 = input$E7
        }
        else {
            e7 = r
        }
        
        values <<- values %>% mutate(
            A3 = input$A3,
            C10 = input$C10,
            E7 = e7,
            N10 = input$N10,
            O1 = input$O1,
            O4 = input$O4
        )
        
        rs <<- round(predict(premodel2, values)[[1]])
        
        if (rs == "1") {
            as$result <- "Stimme überhaupt nicht zu (1)"
        }
        else if (rs == "2") {
            as$result <- "Stimme teilweise nicht zu (2)"
        }
        else if (rs == "3") {
            as$result <- "Teils / Teils (3)"
        }
        else if (rs == "4") {
            as$result <- "Stimme teilweise zu (4)"
        }
        else if (rs == "5") {
            as$result <- "Stimme voll und ganz zu (5)"
        }
        
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        
        #E2 + C10 + C6 + O2
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET A3 =",
                input$A3,
                ", C10=",
                input$C10,
                ", N10=",
                input$N10,
                ", O1=",
                input$O1,
                ", Prediction2=",
                as.integer(rs),
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
    })
    
    output$answertwo <- renderText(as$result)
    
    ## Prediction 3 ####
    #A6 ~ A5 + A9 + C6 + E1 + N6 + O2
    
    at <- reactiveValues(result = NULL)
    rt <- reactiveValues()
    
    
    observeEvent(input$yes3, {
        if (input$O2 > 0) {
            o2 = input$O2
        }
        else {
            o2 = rs
        }
        
        values <<- values %>% mutate(
            A5 = input$A5,
            A9 = input$A9,
            C6 = input$C6,
            O2 = o2,
            E1 = input$E1,
            N6 = input$N6
        )
        
        
        rt <<- round(predict(premodel3, values)[[1]])
        
        if (rt == "1") {
            at$result <- "Stimme überhaupt nicht zu (1)"
        }
        else if (rt == "2") {
            at$result <- "Stimme teilweise nicht zu (2)"
        }
        else if (rt == "3") {
            at$result <- "Teils / Teils (3)"
        }
        else if (rt == "4") {
            at$result <- "Stimme teilweise zu (4)"
        }
        else if (rt == "5") {
            at$result <- "Stimme voll und ganz zu (5)"
        }
        
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET A5 =",
                input$A5,
                ", A9=",
                input$A9,
                ", C6=",
                input$C6,
                ", E1=",
                input$E1,
                ", N6=",
                input$N6,
                ", Prediction3=",
                as.integer(rt),
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
    })
    
    output$answerthree <- renderText(at$result)
    
    ## Prediction 4 ####
    # A6 ~ A5 + A9 + C6 + E1 + N6 + O2
    # => A6 ~ A5 + C6 + E1 + N6
    
    af <- reactiveValues(result = NULL)
    rf <- reactiveValues()
    
    
    observeEvent(input$yes4, {
        if (input$A6 > 0) {
            a6 = input$A6
        }
        else {
            a6 = rt
        }
        
        values <<- values %>% mutate(
            A1 = input$A1,
            A8 = input$A8,
            N5 = input$N5,
            A6 = a6
        )
        
        rf <<- round(predict(premodel4, values)[[1]])
        
        if (rf == "1") {
            af$result <- "Stimme überhaupt nicht zu (1)"
        }
        else if (rf == "2") {
            af$result <- "Stimme teilweise nicht zu (2)"
        }
        else if (rf == "3") {
            af$result <- "Teils / Teils (3)"
        }
        else if (rf == "4") {
            af$result <- "Stimme teilweise zu (4)"
        }
        else if (rf == "5") {
            af$result <- "Stimme voll und ganz zu (5)"
        }
        
        
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET A1 =",
                input$A1,
                ", A8=",
                input$A8,
                ", N5=",
                input$N5,
                ", Prediction4=",
                as.integer(rf),
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
    })
    
    output$answerfour <- renderText(af$result)
    
    
    ## Prediction 5 ####
    # C8 ~ A2 + C5 + C4 + C1 + E4 + N9 + O1
    # => C8 ~ A2 + C5 + C1 + E4 
    
    afi <- reactiveValues(result = NULL)
    rfi <- reactiveValues()
    
    observeEvent(input$yes5, {
        
        values <<- values %>% mutate(
            A2 = input$A2,
            C5 = input$C5,
            C1 = input$C1,
            E4 = input$E4
        )
        
        rfi <<- round(predict(premodel5, values)[[1]])
        
        if (rfi == "1") {
            afi$result <- "Stimme überhaupt nicht zu (1)"
        }
        else if (rfi == "2") {
            afi$result <- "Stimme teilweise nicht zu (2)"
        }
        else if (rfi == "3") {
            afi$result <- "Teils / Teils (3)"
        }
        else if (rfi == "4") {
            afi$result <- "Stimme teilweise zu (4)"
        }
        else if (rfi == "5") {
            afi$result <- "Stimme voll und ganz zu (5)"
        }
        
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET A2 =",
                input$A2,
                ", C1=",
                input$C1,
                ", C5=",
                input$C5,
                ", E4=",
                input$E4,
                ", Prediction5=",
                as.integer(rfi),
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
    })
    
    output$answerfive <- renderText(afi$result)
    
    ## Prediction 6####
    # E3 ~ A10 + C8 + E6 + E7 + N6 + O8
    # => E3 ~ A10 + E6 + O8 
    
    asx <- reactiveValues(result = NULL)
    rsx <- reactiveValues()
    
    observeEvent(input$yes6, {
        if (input$C8 > 0) {
            c8 = input$C8
        }
        else {
            c8 = rfi
        }
        
        values <<- values %>% mutate(
            A10 = input$A10,
            E6 = input$E6,
            O8 = input$O8,
            C8 = c8
        )
        
        rsx <<- round(predict(premodel6, values)[[1]])
        
        if (rsx == "1") {
            asx$result <- "Stimme überhaupt nicht zu (1)"
        }
        else if (rsx == "2") {
            asx$result <- "Stimme teilweise nicht zu (2)"
        }
        else if (rsx == "3") {
            asx$result <- "Teils / Teils (3)"
        }
        else if (rsx == "4") {
            asx$result <- "Stimme teilweise zu (4)"
        }
        else if (rsx == "5") {
            asx$result <- "Stimme voll und ganz zu (5)"
        }
        
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET A10 =",
                input$A10,
                ", E6=",
                input$E6,
                ", O8=",
                input$O8,
                ", Prediction6=",
                as.integer(rsx),
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
    })
    
    output$answersix <- renderText(asx$result)
    
    # Save answers if Prediction was wrong --------------------
    
    observeEvent(input$ok, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET E7 =",
                input$E7,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
        
    })
    
    observeEvent(input$ok2, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET O2 =",
                input$O2,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
        
    })
    
    observeEvent(input$ok3, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET A6 =",
                input$A6,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
        
    })
    
    observeEvent(input$ok4, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET A4 =",
                input$A4,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
        
    })
    
    observeEvent(input$ok5, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET C8 =",
                input$C8,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
        
    })
    observeEvent(input$ok6, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET E3 =",
                input$E3,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
        
    })
    
    #BFI10 -------------------------
    
    # o9 <- reactiveValues()
    #
    # observeEvent(input$O9, {
    #     if (input$O9 > 0) {
    #         o9 <<- input$O9
    #     }
    #     else {
    #         o9 <<- r2
    #     }
    # })
    #
    # data <- reactive({
    #     e1 <<- req(input$E6)
    #     e6 <<- req(input$E2)
    #     a2 <<- req(input$A3)
    #     a7 <<- req(input$A8)
    #     c3 <<- req(input$C10)
    #     c8 <<- req(input$C6)
    #     n4 <<- req(input$N1)
    #     n9 <<- req(input$N3)
    #     o5 <<- o9
    #     o10 <<- req(input$O2)
    #
    #     e1 <<- 6 - e1
    #     c3 <<- 6 - c3
    #     n4 <<- 6 - n4
    #     o5 <<- 6 - o5
    #     a7 <<- 6 - a7
    #
    #     extraversion <<- mean(e1, e6)
    #     agreeableness <<- mean(a2, a7)
    #     conciousness <<- mean(c3, c8)
    #     neuroticism <<- mean(n4, n9)
    #     openness <<- mean(o5, o10)
    #
    #     ocean <-
    #         c(extraversion,
    #           agreeableness,
    #           conciousness,
    #           neuroticism,
    #           openness)
    #
    #     return(ocean)
    # })
    #
    # output$plot <- renderPlot({
    #     openness <- data()[1]
    #     conciousness <- data()[2]
    #     extraversion <- data()[3]
    #     agreeableness <- data()[4]
    #     neuroticism <- data()[5]
    #
    #     bfi10 <<- data.frame(
    #         Scale = c(
    #             'Offenheit',
    #             'Gewissenhaftigkeit',
    #             'Extraversion',
    #             'Verträglichkeit',
    #             'Neurotizismus'
    #         ),
    #         Value = c(
    #             openness,
    #             conciousness,
    #             extraversion,
    #             agreeableness,
    #             neuroticism
    #         )
    #     )
    #
    #     ggplot(bfi10, aes(x = Scale, y = Value)) +
    #         geom_bar(stat = "identity",
    #                  ,
    #                  fill = rgb(0.258, 0.545, 0.792, 0.8)) + ylim(0, 5) + labs(x = "Faktoren", y =
    #                                                                                "Ausprägung")
    # })
    
    # MTurk Code ----------------------------------------------------------
    
    code <- reactive({
        req(input$MTurk)
        
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        
        dbGetQuery(conn,
                   paste0(
                       "SELECT Code FROM KI.Codes WHERE Is_Used = 0
                        Order by ID ASC
                        LIMIT 1;"
                   ))
        
    })
        
        observe({
            if (!is.null(code())) {
                conn <- dbConnect(
                    drv = RMySQL::MySQL(),
                    dbname = "KI",
                    host = "host",
                    username = "user",
                    password = "password"
                )
                on.exit(dbDisconnect(conn), add = TRUE)
                
                dbSendQuery(
                    conn,
                    paste0(
                        "UPDATE KI.Codes SET is_Used = 1 WHERE CODE=\"",
                        as.character(code()$Code),
                        "\";"
                    )
                )
            }
        })
        
    output$Code <- renderText(code()$Code)
    
    # Write Database ------------------------------------------------
    
    observeEvent(input$yn, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET TFPred1=",
                input$yn,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
        if (input$yn == 1) {
            shinyjs::hide("kianswer")
            d <- r
            
            shinyjs::show("weitermachen")
        }
    })
    
    observeEvent(input$yn2, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET TFPred2=",
                input$yn2,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
        if (input$yn2 == 1) {
            shinyjs::hide("kianswer2")
            
            shinyjs::show(id = "thirdquestion")
        }
    })
    
    observeEvent(input$yn3, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET TFPred3=",
                input$yn3,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
        if (input$yn3 == 1) {
            shinyjs::hide("kianswer3")
            
            shinyjs::show(id = "fourthquestion")
            
        }
    })
    
    observeEvent(input$yn4, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET TFPred4=",
                input$yn4,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
        if (input$yn4 == 1) {
            shinyjs::hide("kianswer4")
            
            shinyjs::show(id = "fifthquestion")
        }
    })
    
    observeEvent(input$yn5, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET TFPred5=",
                input$yn5,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
        if (input$yn5 == 1) {
            shinyjs::hide("kianswer5")
            
            shinyjs::show(id = "sixthquestion")
        }
    })
    
    observeEvent(input$yn6, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE User_Input SET TFPred6=",
                input$yn6,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
        if (input$yn6 == 1) {
            shinyjs::hide("kianswer6")
            
            shinyjs::show(id = "abschlussbefragung")
        }
    })
    
    observeEvent(input$UEQS_weiter, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE Final_Questionnaire SET UEQS_1 =",
                input$UEQS_1,
                ", UEQS_2=",
                input$UEQS_2,
                ", UEQS_3=",
                input$UEQS_3,
                ", UEQS_4=",
                input$UEQS_4,
                ", UEQS_5=",
                input$UEQS_5,
                ", UEQS_6=",
                input$UEQS_6,
                ", UEQS_7=",
                input$UEQS_7,
                ", UEQS_8=",
                input$UEQS_8,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
    })
    
    observeEvent(input$GQS_3_weiter, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE Final_Questionnaire SET GQS_3_1 =",
                input$GQS_3_1,
                ", GQS_3_2=",
                input$GQS_3_2,
                ", GQS_3_3=",
                input$GQS_3_3,
                ", GQS_3_4=",
                input$GQS_3_4,
                ", GQS_3_5=",
                input$GQS_3_5,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
    })
    
    observeEvent(input$GQS_4_weiter, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE Final_Questionnaire SET GQS_4_1 =",
                input$GQS_4_1,
                ", GQS_4_2=",
                input$GQS_4_2,
                ", GQS_4_3=",
                input$GQS_4_3,
                ", GQS_4_4=",
                input$GQS_4_4,
                ", GQS_4_5=",
                input$GQS_4_5,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
    })
    
    observeEvent(input$GQS_5_weiter, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE Final_Questionnaire SET GQS_5_1 =",
                input$GQS_5_1,
                ", GQS_5_2=",
                input$GQS_5_2,
                ", GQS_5_3=",
                input$GQS_5_3,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
    })
    
    observeEvent(input$KIT_weiter, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE Final_Questionnaire SET KIT_1 =",
                input$KIT_1,
                ", KIT_2=",
                input$KIT_2,
                ", KIT_3=",
                input$KIT_3,
                ", KIT_4=",
                input$KIT_4,
                ", KIT_5=",
                input$KIT_5,
                ", KIT_6=",
                input$KIT_6,
                ", KIT_7=",
                input$KIT_7,
                ", KIT_8=",
                input$KIT_8,
                ", KIT_9=",
                input$KIT_9,
                ", KIT_10=",
                input$KIT_10,
                ", KIT_11=",
                input$KIT_11,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
    })
    
    observeEvent(input$KUSIV3_weiter, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE Final_Questionnaire SET KUSIV3_1 =",
                input$KUSIV3_1,
                ", KUSIV3_2=",
                input$KUSIV3_2,
                ", KUSIV3_3=",
                input$KUSIV3_3,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
        )
    })
    
    observeEvent(input$SD_weiter, {
        if (input$SD_weiter == 1) {
            shinyjs::hide("sd_questions_text")
            
            shinyjs::show(id = "end")
            
        }
        
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE Final_Questionnaire SET SD_Gender =",
                input$sex,
                ", SD_Age=",
                input$age,
                ", FUN=",
                input$fun,
                " WHERE Session=\"",
                session$token,
                "\";"
            )
            
        )
    })
    
    
    observeEvent(input$Anmerkungen_weiter, {
        conn <- dbConnect(
            drv = RMySQL::MySQL(),
            dbname = "KI",
            host = "host",
            username = "user",
            password = "password"
        )
        on.exit(dbDisconnect(conn), add = TRUE)
        
        dbSendQuery(
            conn,
            paste0(
                "UPDATE Final_Questionnaire SET Notes=\"",
                input$anmerkungen,
                "\" WHERE Session=\"",
                session$token,
                "\";"
            )
        )
    })
    
    # observeEvent(input$fun, {
    #     conn <- dbConnect(
    #         drv = RMySQL::MySQL(),
    #         dbname = "KI",
    #         host = "host",
    #         username = "user",
    #         password = "password"
    #     )
    #     on.exit(dbDisconnect(conn), add = TRUE)
    #     
    #     dbSendQuery(
    #         conn,
    #         paste0(
    #             "UPDATE Final_Questionnaire SET Fun =",
    #             input$fun,
    #             " WHERE Session=\"",
    #             session$token,
    #             "\";"
    #         )
    #     )
    # })
    # End -------------------------------
    
    observeEvent(input$end, {
        if (input$end == 1) {
            stopApp()
        }
        
    })
    
}