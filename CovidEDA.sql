#Covid 19 Data Exploration
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM Covid_deaths.Covid
order by 1,2;

#Total cases vs Deaths in the US
SELECT location, date, total_cases, total_deaths AS highest_infection_rate, (total_deaths/total_cases)*100 AS Deaths_percentage
FROM Covid_deaths.Covid
WHERE location = 'United States' AND Covid.total_deaths IS NOT NULL
ORDER BY  1,2;

#ICU Patients Before and After Covid in Italy
SELECT location,date,new_cases, total_cases,icu_patients
FROM Covid_deaths.Covid
WHERE location = 'Italy' AND icu_patients IS NOT NULL
GROUP BY location, date, new_cases, icu_patients, total_cases
ORDER BY date ASC;

#Looking at total cases vs population
SELECT location,date,population, total_cases, (total_cases/Covid.population)*100 as DeathPercentage
FROM Covid_deaths.Covid
WHERE location = 'Canada' AND total_cases IS NOT NULL
ORDER BY 1,2;

#Highest Infection rate by country
SELECT location,date,population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/Covid.population))*100 as PercentofPopulationInf
FROM Covid_deaths.Covid
WHERE total_cases IS NOT NULL
GROUP BY population, date, location
ORDER BY PercentofPopulationInf DESC;

#Countries with highest death count per population
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM Covid_deaths.Covid
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

#BY CONTINENT
SELECT location, MAX(cast(total_deaths as int)) as TotalDeathCount
FROM Covid_deaths.Covid
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC;

#Global Numbers
SELECT date, SUM(new_cases) as total_cases,SUM(CAST(new_deaths as int)) as total_deaths ,SUM(CAST(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM Covid_deaths.Covid
WHERE new_deaths > 0 and continent IS NOT NULL
GROUP BY date
ORDER BY  1,2;

#Global Totol Numbers (without date)
SELECT SUM(new_cases) as total_cases,SUM(CAST(new_deaths as int)) as total_deaths ,SUM(CAST(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
FROM Covid_deaths.Covid
WHERE new_deaths > 0 and continent IS NOT NULL
ORDER BY  1,2;

#Joining Covid.Deaths with Covid.Vaccine
SELECT * FROM Covid_deaths.Covid AS dea
JOIN Covid_Vaccine.`Covid-Vaccine` AS vac
ON dea.location = vac.location
AND dea.date = vac.date;

#Total Populations vs Vaccinations
SELECT dea.continent, dea.location, vac.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations as int)) OVER (partition by dea.location ORDER BY dea.location, dea.date) AS rollingpeoplevaccinated
FROM Covid_deaths.Covid AS dea
JOIN Covid_Vaccine.`Covid-Vaccine` AS vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL AND vac.new_vaccinations IS NOT NULL
ORDER BY 1,2,3;

#TEMP Table for percentage of people vaccinated
DROP TABLE if exists PercentPopulationVaccinated
CREATE TABLE PercentPopulationVaccinated
    (
        Continent nvarchar(255),
        Location nvarchar(255),
        Date datetime,
        Population numeric,
        New_vaccincations numeric,
        rollingpeoplevaccinated numeric
)

INSERT INTO PercentPopulationVaccinated
SELECT dea.continent, dea.location, vac.location, dea.date, dea.population, vac.new_vaccinations, SUM(CAST(vac.new_vaccinations as int)) OVER (partition by dea.location ORDER BY dea.location, dea.date) AS rollingpeoplevaccinated
FROM Covid_deaths.Covid AS dea
JOIN Covid_Vaccine.`Covid-Vaccine` AS vac
ON dea.location = vac.location
AND dea.date = vac.date
WHERE dea.continent IS NOT NULL AND vac.new_vaccinations IS NOT NULL
ORDER BY 1,2,3;

SELECT *, (rollingpeoplevaccinated/population)*100 FROM
PercentPopulationVaccinated


