<!--
*** Thanks for checking out the Best-README-Template. If you have a suggestion
*** that would make this better, please fork the repo and create a pull request
*** or simply open an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
***
***
***
*** To avoid retyping too much info. Do a search and replace for the following:
*** tessa135, The-Machine-That-Knows-You, twitter_handle, tessa.lottermann@gmx.de, The Machine That Knows You, project_description
-->



<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links

[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]
-->


<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/tessa135/The-Machine-That-Knows-You">
  </a>

  <h3 align="center">The Machine That Knows You</h3>

  <p align="justify">
    Here, we present a new experimental paradigm to study how users react when AI-enriched software reveals intimate knowledge about them. In the experiment, users interact with an AI-based personal assistant (PA). In order to learn about the user, the PA asks the user questions about their personality. The PA then uses machine learning to make predictions about how the users will respond to novel questions based on their previous responses, thus demonstrating knowledge about the users’ personality. Participants indicate whether the prediction was correct, i.e. whether they would have answered the same, or not. The paradigm allows manipulating various aspects of the PA, such as prediction accuracy, predicted personality dimensions, or aspects of presentation. We submit that this new paradigm can be used to study a multitude of novel research questions on human-AI-relations.<br/>
	We implemented a prototype for this paradigm in R. For the machine learning backend, we trained multiple models with a support vector machine algorithm on personality data from N = 5891 participants, drawn from the publicly available LISS panel (Scherpenzeel & Das, 2010). The frontend for the PA was implemented as a Shiny web-application with a MySQL data backend. The source code will be made publicly available. The research report will include results of an initial, explorative validation study. For this web-based study a convenience sample of German citizens was recruited. The participants receive six predictions regarding their personality from the PA (drawn from the Big-5 inventory). After the interaction, participants report demographic information and rate the PA along established dimensions from human computer interaction research (e.g., likability, perceived intelligence, trust). We report the test- and validation-accuracy of the machine learning algorithm and explore how prediction accuracy affects aforementioned dimensions.  
    <br /><br />
    <a href="https://github.com/tessa135/The-Machine-That-Knows-You"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://experienceai.shinyapps.io/experienceai/" target="_blank">View Demo</a>
    ·
    <a href="https://github.com/tessa135/The-Machine-That-Knows-You/issues">Report Bug</a>
    ·
    <a href="https://github.com/tessa135/The-Machine-That-Knows-You/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <!--<li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>-->
    <li><a href="#contact">Contact</a></li>
   <!-- <li><a href="#acknowledgements">Acknowledgements</a></li>-->
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project


 <a href="https://experienceai.shinyapps.io/experienceai/">
    <img src="images/screenshot.png">
  </a>

<!--Here's a blank template to get started:
**To avoid retyping too much info. Do a search and replace with your text editor for the following:**
`tessa135`, `The-Machine-That-Knows-You`, `twitter_handle`, `tessa.lottermann@gmx.de`, `The Machine That Knows You`, `project_description`
-->

### Built With

* [R](https://www.r-project.org/)
* [Shiny](https://shiny.rstudio.com/)
* [JavaScript](https://www.javascript.com/)
* [HTML](https://html.com/)
* [MySQL](https://www.mysql.com/de/)



<!-- GETTING STARTED -->
## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

* Install R (https://www.r-project.org/) 
* We recommend using RStudio (https://www.rstudio.com/)
* Install MySQL locally or set up a MySQL database on a web server/cloud service


### Installation

#### Setting up the database 

1. Import [database_structure.sql](Database/database_structure.sql) to your MySQL database for a blank database OR
	Import 'Database/database_with_data.sql.sql' to your MySQL database for a  database including data of the first study 

#### Setting up the app 

1. Enter your database connection in [Server.R](App/Server.R) where 
```R
conn <- dbConnect(
        drv = RMySQL::MySQL(),
            dbname = "dbname",
            host = "host",
            username = "username",
            password = "password"
        )
```


#### Train new models

1. Enter the path to your training-dataset in [R_learning.R](R-Scripts/R_learning.R) in line 42
```R
dat <-
  haven::read_sav("/Your/Path/Goes/here/data.sav")
```
Notice you might want to change the read function depending on your filetype.

2. Add your path to save the frequency distribution plots in line 118

```R
for (i in 1:length(vardists)) {
  png(paste0(
    "/Your/Path/Goes/here/plot_",
    i,
    ".png"
  ))
```

3. Add your path to save the svm models in line 358

```R
saveRDS(
    model_svm,
    file = paste(
      "/Your/Path/Goes/here/svmmodel_",
      mdlsave,
      ".rds",
      sep = ""
    )
  )
```

4. Add your paths to save the statistics in line 541

```R
write.csv(
  resdf,
  "/Your/Path/Goes/here/results.csv"
)

descriptives <- summary(resdf_rf)

write.csv(
  descriptives,
  "/Your/Path/Goes/here/descriptives_results.csv"
)
```

#### Calculating the results

1. Join the database tables "User_Input", "Final_Questionnaire" and "Consent" using [Join_Tables.sql](Database/Join_Tables.sql)
2. Export the resulting table as .csv
3. Load this .csv to 'R-Scripts/Data_transform.R' by adding the path in 
```R
dat_auswertung <- 
	read_csv("/Your/Path/Goes/here/data.csv", 
	na = "NULL")
```
4. In [Data_transform.R](R-Scripts/Data_transform.R) update the save-path
```R
write.csv(
  dat_auswertung,
  "/Your/Path/Goes/here/clean_data.csv"
)
```
5. Run [Data_transform.R](R-Scripts/Data_transform.R)
6. Load 'clean_data.csv' to [Analysis.R](R-Scripts/Analysis.R) by updating the path in 
```R
dat_auswertung <-
  read_csv("/Your/Path/Goes/here/clean_data.csv")
```
7. Run Analysis.R

### Using other models

If you want to change the models used in the app, you can find more models in 'RDS-Models Correct'. The corresponding MSE and direct hit rates can be found in 'model-results.csv'.

### More Models 

More models were trained during the development of this app. [They can be found here.](https://drive.google.com/drive/folders/1SlZylGMf3l_lBntxYO_o8XBM6ZDE2jVx?usp=sharing)

**Caution!** Some of them may contain duplicate predictors in the same model! 

<!-- USAGE EXAMPLES 
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

-->

<!-- ROADMAP
## Roadmap

See the [open issues](https://github.com/tessa135/The-Machine-That-Knows-You/issues) for a list of proposed features (and known issues).

-->

<!-- CONTRIBUTING
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

 -->

<!-- LICENSE 
## License

Distributed under the MIT License. See `LICENSE` for more information.
-->


<!-- CONTACT -->
## Contact

Tessa Lottermann - tessa.lottermann@gmx.de

Project Link: [https://github.com/tessa135/The-Machine-That-Knows-You](https://github.com/tessa135/The-Machine-That-Knows-You)



<!-- ACKNOWLEDGEMENTS 
## Acknowledgements

* []()
* []()
* []()

-->



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/tessa135/repo.svg?style=for-the-badge
[contributors-url]: https://github.com/tessa135/repo/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/tessa135/repo.svg?style=for-the-badge
[forks-url]: https://github.com/tessa135/repo/network/members
[stars-shield]: https://img.shields.io/github/stars/tessa135/repo.svg?style=for-the-badge
[stars-url]: https://github.com/tessa135/repo/stargazers
[issues-shield]: https://img.shields.io/github/issues/tessa135/repo.svg?style=for-the-badge
[issues-url]: https://github.com/tessa135/repo/issues
[license-shield]: https://img.shields.io/github/license/tessa135/repo.svg?style=for-the-badge
[license-url]: https://github.com/tessa135/repo/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/tessa135
