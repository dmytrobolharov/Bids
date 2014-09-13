IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_TechPackDownloadAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_TechPackDownloadAgent_SELECT]
GO

CREATE  PROCEDURE [dbo].[spx_TechPackDownloadAgent_SELECT](
@TradePartnerId UNIQUEIDENTIFIER , 
@Top INT,
@Total INT OUTPUT 
)
AS 

DECLARE @SQLString nvarchar(700)
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
pStyleHeader.StyleNo, pStyleHeader.Description, pStyleHeader.SizeClass, 
pTechPack.CDate, pTechPackTeam.TeamID, pTechPackTeam.TechPackDownload
FROM pTechPack WITH (NOLOCK) INNER JOIN
    pTechPackTeam  WITH (NOLOCK) ON pTechPack.TechPackID = pTechPackTeam.TechPackID INNER JOIN
    pStyleHeader  WITH (NOLOCK) ON pTechPack.StyleID = pStyleHeader.StyleID 
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
VALUES ('DB_Version', '0.5.0000', '08709', GetDate())
GO
