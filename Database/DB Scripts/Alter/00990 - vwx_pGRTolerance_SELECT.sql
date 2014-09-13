
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_pGRTolerance_SELECT]'))
DROP VIEW [dbo].[vwx_pGRTolerance_SELECT]
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [dbo].[vwx_pGRTolerance_SELECT]
AS

SELECT     b.POMAlternatesId, a.RefCode, a.POMDesc, a.SortField, t.ToleranceGuidId, g.AlternatesCode, g.AlternatesDesc, t.TolPlus, t.TolMinus, t.IsOnQA, c.SizeClassGuidId, 
                      t.IsPrimaryKeyMeas, t.ProductClassImageId, t.Muser, t.MDate
FROM         dbo.pGRPOMCompany AS a INNER JOIN
                      dbo.pGRTolerance AS t ON a.POMCompanyId = t.POMCompanyId INNER JOIN
                      dbo.pGRProductClassImage AS c ON t.ProductClassImageId = c.ProductClassImageID INNER JOIN
                      dbo.pGRPOMAlternates AS b INNER JOIN
                      dbo.pGRAlternates AS g ON b.AlternatesGuidId = g.AlternatesGuidId ON a.POMAlternatesId = b.POMAlternatesId

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '00990', GetDate())

