/****** Object:  StoredProcedure [dbo].[spx_StyleColorwaySeasonalYear_PIVOT]    Script Date: 04/12/2013 14:52:44 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleColorwaySeasonalYear_PIVOT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleColorwaySeasonalYear_PIVOT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleColorwaySeasonalYear_PIVOT]    Script Date: 04/12/2013 14:52:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_StyleColorwaySeasonalYear_PIVOT](@StyleId uniqueidentifier, @SeasonYearID NVARCHAR(50)= NULL)    
AS  
SELECT     a.StyleColorwaySeasonYearID, a.StyleSeasonYearID, a.StyleID, a.StyleColorDelivery1, a.StyleColorDelivery2, a.StyleColorDelivery3, 
                      a.StyleColorDelivery4, a.StyleColorStatus, b.StyleColorNo, b.StyleColorName, b.StyleColorID
FROM         pStyleColorwaySeasonYear AS a INNER JOIN
                      pStyleColorway AS b ON a.StyleColorwayID = b.StyleColorID
                      INNER JOIN pStyleSeasonYear c ON a.StyleSeasonYearID = c.StyleSeasonYearID
WHERE     (c.SeasonYearID = @SeasonYearId and b.StyleID=@StyleId) 
ORDER BY a.Sort, b.StyleColorNo


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05558', GetDate())
GO
