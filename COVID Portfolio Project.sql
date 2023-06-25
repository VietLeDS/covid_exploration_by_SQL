/*
Covid 19 Data Exploration
*/

-- First Look

Select *
From Portfolio_SQLProject..CovidDeaths

Select *
From Portfolio_SQLProject..CovidVaccinations

-- Select Data of Vietnam
Select *
From Portfolio_SQLProject..CovidDeaths
where location = 'Vietnam'

-- View 1. Total Cases vs Total Deaths in Vietnam
-- Show the DeathPercentage when infected with Covid

Select Location, date, total_cases, total_deaths
, (cast(total_deaths as float)/Cast(total_cases as float))*100 as DeathPercentage
From Portfolio_SQLProject..CovidDeaths
Where location = 'Vietnam'
and total_cases is not null
order by 1,2

-- The time Vietnam has the first death
Select Location, date, total_cases,total_deaths
, (cast(total_deaths as float)/Cast(total_cases as float))*100 as DeathPercentage
From Portfolio_SQLProject..CovidDeaths
Where location = 'Vietnam'
and total_deaths is not null
order by 1,2

-- Total Cases and Total Deaths in Vietnam by 2022
Select Location, date, total_cases,total_deaths
, (cast(total_deaths as float)/Cast(total_cases as float))*100 as DeathPercentage
From Portfolio_SQLProject..CovidDeaths
Where location = 'Vietnam'
and date <= '2022-12-31'
order by 1,2 desc

-- The highest DeathPercentage time in Vietnam
Select Location, date, total_cases,total_deaths
, (cast(total_deaths as float)/Cast(total_cases as float))*100 as DeathPercentage
From Portfolio_SQLProject..CovidDeaths
Where location = 'Vietnam'
and total_deaths is not null
order by DeathPercentage desc

-- View 2. Total Cases vs Population in Vietnam
-- Shows what percentage of population infected with Covid

Select Location, date, Population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From Portfolio_SQLProject..CovidDeaths
Where location = 'Vietnam'
order by 1,2

-- The highest PercentPopulationInfected time in Vietnam
Select Location, date, Population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
From Portfolio_SQLProject..CovidDeaths
Where location = 'Vietnam'
order by PercentPopulationInfected desc

-- View 3. Compare between Countries
-- Countries with Highest Death Rate compared to Infection
Select Location, population, MAX(total_deaths) as HighestDeaths, MAX(total_cases) as HighestCases
, Max(cast(total_deaths as float)/cast(total_cases as float))*100 as DeathPercentage
From Portfolio_SQLProject..CovidDeaths
Group by Location, population
order by DeathPercentage desc

-- Special Case: Ghana -- See Total Deaths and Total Cases by day
Select Location, date, total_cases, total_deaths
, (cast(total_deaths as float)/Cast(total_cases as float))*100 as DeathPercentage
From Portfolio_SQLProject..CovidDeaths
Where location = 'Ghana'
and total_cases is not null
order by 1,2

-- Countries with Highest Infection Rate compared to Population
Select Location, Population, MAX(cast(total_cases as float)) as HighestInfectionCount
, Max(cast(total_cases as float)/population)*100 as PercentPopulationInfected
From Portfolio_SQLProject..CovidDeaths
Group by Location, population
order by PercentPopulationInfected desc

-- Countries with Highest Death Count per Population
Select Location, MAX(cast(Total_deaths as float)) as TotalDeathCount
, MAX(cast(Total_deaths as float)/population)*100 as PercentPopulationDeath
From Portfolio_SQLProject..CovidDeaths
Where continent is not null 
Group by Location
order by TotalDeathCount desc


-- View 4. Compare between continents
-- Showing contintents with the highest death count per population
Select continent, MAX(cast(Total_deaths as float)) as TotalDeathCount
From Portfolio_SQLProject..CovidDeaths
Where continent is not null
Group by continent
order by TotalDeathCount desc


-- View 5. Global Numbers
Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(New_Cases)*100 as DeathPercentage
From Portfolio_SQLProject..CovidDeaths
where continent is not null
order by 1,2