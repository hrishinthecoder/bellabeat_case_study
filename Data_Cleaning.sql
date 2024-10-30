-- Selecting the Data

select * from `micro-territory-420017.Case_Study.Daily_Activity`;

-- Selecting the Distict Counts

SELECT DISTINCT id from `micro-territory-420017.Case_Study.Daily_Activity`;

-- Checking for outliers

SELECT COUNTIF(TotalSteps IS NULL) AS null_TotalSteps,COUNTIF(Calories IS NULL) AS null_Calories,COUNTIF(TotalDistance IS NULL) AS null_TotalDistance,
  COUNTIF(ActivityDate IS NULL) AS null_ActivityDate
FROM `micro-territory-420017.Case_Study.Daily_Activity`;
