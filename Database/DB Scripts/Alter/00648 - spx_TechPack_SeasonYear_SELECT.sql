 
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPack_SeasonYear_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPack_SeasonYear_SELECT]
GO
  
CREATE PROCEDURE [dbo].[spx_TechPack_SeasonYear_SELECT](@TechPackId uniqueidentifier)  
AS   
  
  
SELECT a.*, b.Season AS Season, b.Year AS [YEAR]  FROM pTechPack a WITH (NOLOCK) INNER JOIN
pSeasonYear b ON a.StyleSeasonYearID = b.SeasonYearID  
WHERE TechPackID = @TechPackId  

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '648', GetDate())

GO

  
  

  
  
  