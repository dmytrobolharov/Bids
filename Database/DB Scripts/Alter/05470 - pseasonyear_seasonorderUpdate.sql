with cte as (
select sort, seasonorder, ROW_NUMBER() OVER (ORDER BY year, sort desc) as RN
from pSeasonYear
)
update cte set seasonorder=RN

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05470', GetDate())
GO
