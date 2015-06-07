IF OBJECT_ID(N'[dbo].[spx_TechPackDownloadAgent_SELECT]') IS NOT NULL
 DROP PROCEDURE [dbo].[spx_TechPackDownloadAgent_SELECT]
GO

CREATE  PROCEDURE [dbo].[spx_TechPackDownloadAgent_SELECT](
@TradePartnerId UNIQUEIDENTIFIER , 
@Top INT,
@Total INT OUTPUT 
)
AS 

DECLARE @SQLString nvarchar(MAX)
DECLARE @ParmDefinition nvarchar(500)


SET @SQLString = 'SELECT @pTotal = COUNT(*)  FROM pTechPack WITH (NOLOCK) INNER JOIN
    pTechPackTeam WITH (NOLOCK) ON pTechPack.TechPackID = pTechPackTeam.TechPackID INNER JOIN
    pStyleHeader WITH (NOLOCK) ON pTechPack.StyleID = pStyleHeader.StyleID 
WHERE pTechPackTeam.TechPackDownload = 0
AND pTechPackTeam.TeamID = @pTradePartnerId'

SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER, @pTotal INT OUTPUT'

EXECUTE sp_executesql @SQLString, @ParmDefinition, 
		@pTradePartnerId = @TradePartnerId, 
		@pTotal = @Total OUTPUT

IF (@Top IS NULL) OR ( @Top<=0 )
	SET @SQLString = 'SELECT ' 
ELSE 
	SET @SQLString = 'SELECT TOP ' +  CAST ( @Top AS NVARCHAR(5) ) 

SET @SQLString = @SQLString + '  pTechPack.TechPackID, pTechPack.StyleId, pTechPack.TechPackNo, pTechPack.TechPackName, 
pStyleHeader.StyleNo, pStyleHeader.Description, COALESCE(sc.Custom, pStyleHeader.SizeClass) AS SizeClass, 
pTechPack.CDate, pTechPackTeam.TeamID, pTechPackTeam.TechPackDownload
FROM pTechPack WITH (NOLOCK) INNER JOIN
    pTechPackTeam  WITH (NOLOCK) ON pTechPack.TechPackID = pTechPackTeam.TechPackID INNER JOIN
    pStyleHeader  WITH (NOLOCK) ON pTechPack.StyleID = pStyleHeader.StyleID 
	LEFT JOIN pSizeClass sc ON sc.CustomID = pStyleHeader.SizeClassId
WHERE pTechPackTeam.TechPackDownload = 0
AND pTechPackTeam.TeamID = @pTradePartnerId
ORDER BY pTechPackTeam.CDate DESC'

SET @ParmDefinition = '@pTradePartnerId UNIQUEIDENTIFIER'
EXECUTE sp_executesql @SQLString, @ParmDefinition, 
		@pTradePartnerId = @TradePartnerId
		
/*
Modified: July 25 2008

SELECT pTechPack.TechPackID, pTechPack.StyleId, pTechPack.TechPackNo, pTechPack.TechPackName, pStyleHeader.StyleNo, pStyleHeader.Description, pStyleHeader.SizeClass, 
    pTechPack.CDate, pTechPackTeam.TeamID, pTechPackTeam.TechPackDownload
FROM pTechPack WITH (NOLOCK) INNER JOIN
    pTechPackTeam WITH (NOLOCK) ON pTechPack.TechPackID = pTechPackTeam.TechPackID INNER JOIN
    pStyleHeader WITH (NOLOCK) ON pTechPack.StyleID = pStyleHeader.StyleID
WHERE (pTechPackTeam.TechPackDownload = 0) AND (pTechPackTeam.TeamID = @TradePartnerId)
ORDER BY pTechPack.CDate
*/


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09854', GetDate())
GO
