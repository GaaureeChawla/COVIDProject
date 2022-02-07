/*
Covid 19 Data Exploration 
Skills used: Joins, Aggregate Functions, Converting Data Types
*/

-- Observe Data
Select *
From PortfolioProject..CovidDeaths
Where continent is not null 
Order by location, date; 

Select *
From PortfolioProject..CovidVaccinations
Where continent is not null 
Order by location, date; 

-- Select data fields that will be using.

Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..CovidDeaths
Where continent is not null 
Order by location, date; 

-- Percentage of Deaths among People who contract COVID in the United States
Select location, date, total_cases,total_deaths,(total_deaths/total_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
Where location like '%states%'
Order by location, date;


-- Percentage of COVID cases in the population (United States).
Select location, date, total_cases, population, (total_cases/population)*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Where location like '%states%' AND continent is not null
Order by location, date; 

-- Comparing the percentage of cases in the population among different countries to show countries with highest infection rate
Select location, max(total_cases) as HighestInfectionCount, population, max((total_cases)/population)*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Where continent is not null 
Group by location, population
Order by PercentPopulationInfected desc; 

/* Comparing deaths among countries */
Select location, max(cast (total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is not null 
Group by location
Order by TotalDeathCount desc; 


/* Comparing deaths across continents */
Select location, max(cast (total_deaths as int)) as TotalDeathCountContinent
From PortfolioProject..CovidDeaths
Where continent is null 
Group by location
Order by TotalDeathCountContinent desc;

/* Total Deaths, Cases, and DeathPercentage in world.*/
Select sum(new_cases) as global_cases, sum(cast (new_deaths as int)) as global_deaths, (sum(cast (new_deaths as int))/sum(new_cases))*100 as DeathPercentageGlobal
From PortfolioProject..CovidDeaths
Where continent is not null; 


/* Comparing global cases, deaths, and death percentage and grouping by date */
Select date, sum(new_cases) as global_cases, sum(cast (new_deaths as int)) as global_deaths, (sum(cast (new_deaths as int))/sum(new_cases))*100 as DeathPercentageGlobal
From PortfolioProject..CovidDeaths
Where continent is not null 
Group by date
Order by date; 

/* View data from Covid Vaccinations table */
Select *
From PortfolioProject..CovidVaccinations;

/* Join CovidDeaths and CovidVaccinations tables */
Select *
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date; 

-- Total population vs vaccinations. Number of people in world who are vaccinated compared to world population size on a given date
Select dea.date, sum(dea.population) as population, sum(cast (vac.total_vaccinations as bigint)) as vaccinations, (sum(cast (vac.total_vaccinations as bigint))/sum(dea.population))*100 as PercentVaccinated
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not null and vac.continent is not null 
GROUP BY dea.date; 

-- New vaccinations/day in a country on a given date 
Select dea.continent, dea.location, dea.date, vac.new_vaccinations
From PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent is not null 
ORDER BY dea.location, dea.date; 









