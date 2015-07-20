IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwaySeasonalYear_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwaySeasonalYear_PIVOT]
GO



CREATE PROCEDURE [dbo].[spx_StyleColorwaySeasonalYear_PIVOT](@StyleId uniqueidentifier, @SeasonYearID NVARCHAR(50)= NULL)    
AS  
SELECT     a.StyleColorwaySeasonYearID, a.StyleSeasonYearID, a.StyleID, a.StyleColorDelivery1, a.StyleColorDelivery2, a.StyleColorDelivery3, 
                      a.StyleColorDelivery4, a.StyleColorStatus, b.StyleColorNo, b.StyleColorName, b.StyleColorID, a.Sort, a.Units, 
                      CASE WHEN sbca.StyleColorID IS NULL OR sbca.ColorActive = 1 THEN 1 ELSE 0 END AS ColorActive
FROM     pStyleColorwaySeasonYear AS a 
			INNER JOIN pStyleColorway AS b ON a.StyleColorwayID = b.StyleColorID 
			INNER JOIN pStyleSeasonYear c ON a.StyleSeasonYearID = c.StyleSeasonYearID
			LEFT JOIN vwx_StyleBOMColor_SeasonalActivity_SEL sbca ON a.StyleColorwayID = sbca.StyleColorID AND a.StyleSeasonYearID = sbca.StyleSeasonYearID 
WHERE     (c.SeasonYearID = @SeasonYearId and b.StyleID = @StyleId) 
ORDER BY a.Sort, b.StyleColorNo

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07279', GetDate())
GO
