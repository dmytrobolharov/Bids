
CREATE VIEW [dbo].[vwx_StyleSampleRequest_Search_SEL] 
AS

SELECT b.*, a.StyleSeasonYearID, a.SeasonYearID
FROM pStyleSeasonYear a 
RIGHT OUTER JOIN pStyleHeader b ON a.StyleID  = b.StyleID 

GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '064', GetDate())
GO