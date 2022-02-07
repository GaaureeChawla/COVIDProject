# COVID Project
## About the Project
This project analyzes COVID-19 death and vaccination data across the world. 

## Built With 
MS SQL Server and SQL Server Management Studio

## Installation
Download the tables CovidDeaths.xlsx and CovidVaccinations.xlsx <br>
Alternatively you can download the latest dataset [here](https://ourworldindata.org/covid-deaths) and follow [this tutorial](https://www.youtube.com/watch?v=qfyynHBFOsM) to create the two tables

Download a copy of the SQLQueryCovidSubmission.sql <br>
Open SQL Server Management studio and load SQLQueryCovidSubmission.sql
Select a database to save the files <br>
Click Execute from the toolbar to run each query

## Usage
Calculate Percentage of Deaths among cases in the US
````
Select location, date, total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location like '%states%'
Order by location, date;
````
Sample Output: <br>
![image](https://user-images.githubusercontent.com/50927877/152810581-ce79f20a-21eb-404e-a76c-58d3c3d83b86.png)

JOIN tables and calculate global percentage of people vaccinated on a given date
````
Select dea.date, sum(dea.population) as population, sum(cast (vac.total_vaccinations as bigint)) as vaccinations, (sum(cast (vac.total_vaccinations as bigint))/sum(dea.population))*100 as PercentVaccinated
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not null and vac.continent is not null 
GROUP BY dea.date; 
````
Sample Output: <br>
![image](https://user-images.githubusercontent.com/50927877/152811322-4515381f-ea81-46fc-90c8-0d4bffb064fa.png)


## Credits
This project was built with the support of Alex Freberg's tutorial: <br>
[AlextheAnalyst](https://www.youtube.com/c/alextheanalyst/about) <br>
[AlextheAnalyst Tutorial](https://www.youtube.com/watch?v=qfyynHBFOsM) <br>
[AlextheAnalyst Github](https://github.com/AlexTheAnalyst/PortfolioProjects) <br>

