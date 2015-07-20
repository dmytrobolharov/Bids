
IF EXISTS (select * from sysobjects where id = object_id('spx_StyleColorwaySeasonalYear_PIVOT') and sysstat & 0xf = 4)
	drop procedure spx_StyleColorwaySeasonalYear_PIVOT
GO

CREATE PROCEDURE spx_StyleColorwaySeasonalYear_PIVOT(@StyleId uniqueidentifier, @StyleSeasonYearID NVARCHAR(50)= NULL)    
AS  
SELECT     a.StyleColorwaySeasonYearID, a.StyleSeasonYearID, a.StyleID, a.StyleColorDelivery1, a.StyleColorDelivery2, a.StyleColorDelivery3, 
                      a.StyleColorDelivery4, a.StyleColorStatus, b.StyleColorNo, b.StyleColorName, b.StyleColorID
FROM         pStyleColorwaySeasonYear AS a INNER JOIN
                      pStyleColorway AS b ON a.StyleColorwayID = b.StyleColorID
WHERE     (a.StyleSeasonYearID = @StyleSeasonYearId and b.StyleID=@StyleId)   
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '029', GetDate())
GO 