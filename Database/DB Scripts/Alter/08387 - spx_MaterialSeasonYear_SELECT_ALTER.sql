
/****** Object:  StoredProcedure [dbo].[spx_MaterialSeasonYear_SELECT]    Script Date: 7/22/2014 11:45:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


ALTER PROCEDURE [dbo].[spx_MaterialSeasonYear_SELECT] (
@MaterialID	UNIQUEIDENTIFIER 
)
AS

	SELECT a.*, b.Season + ' ' + b.Year  AS SeasonYear
	FROM pMaterialSeasonYear a  
	INNER JOIN vwx_SeasonYear_SEL b ON a.SeasonYearID = b.SeasonYearID  
	WHERE a.MaterialID = @MaterialID 


GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '08387', GetDate())
GO
