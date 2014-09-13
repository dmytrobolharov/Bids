CREATE VIEW vwx_StyleMaterialWhere_SELECT
AS 

SELECT a.StyleSeasonYearID, b.StyleNo, b.Description, b.SizeClass, b.SizeRange   
FROM pStyleSeasonYear a 
INNER JOIN  pStyleHeader b ON a.StyleID  = b.StyleID 

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '086', GetDate())
GO
