IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Sample_StyleSeasonYear_SELECTED]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Sample_StyleSeasonYear_SELECTED]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Sample_StyleSeasonYear_SELECTED]  (  
@StyleID UNIQUEIDENTIFIER ,
@SampleRequestTradeID UNIQUEIDENTIFIER 
)  
AS   
  
/*  
SELECT  SeasonYearID , [Season] + ' ' + [Year] AS SeasonYear FROM  pSeasonYear   
WHERE SeasonYearID IN (SELECT SeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID)  
ORDER BY Sort  
*/  
  
SELECT b.SeasonYearID , b.Season + ' ' + b.Year AS SeasonYear   
FROM pStyleSeasonYear a  
INNER JOIN pSeasonYear b ON a.SeasonYearID = b.SeasonYearID  
INNER JOIN   dbo.pSampleRequestTrade c ON a.StyleSeasonYearID = c.StyleSeasonYearID
WHERE a.StyleID = @StyleID  AND c.SampleRequestTradeID = @SampleRequestTradeID
ORDER BY b.CurrentSeason DESC, b.Year DESC, b.Season  


GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03051'))
BEGIN
	
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.2.0000', '03051', GetDate())     

END	  
GO