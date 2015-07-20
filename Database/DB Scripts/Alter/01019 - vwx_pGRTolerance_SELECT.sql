IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[vwx_pGRTolerance_SELECT]') AND OBJECTPROPERTY(id, N'IsView') = 1)
DROP VIEW [dbo].[vwx_pGRTolerance_SELECT]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

Create VIEW [dbo].[vwx_pGRTolerance_SELECT]
AS

SELECT     b.POMAlternatesId as POMAlternatesId, a.RefCode as Refcode, a.POMDesc as POMDesc, a.SortField as SortField, t.ToleranceGuidId as ToleranceGuidId, g.AlternatesCode as AlternatesCode, g.AlternatesDesc as AlternatesDesc, t.TolPlus as TolPlus, t.TolMinus as TolMinus, t.IsOnQA as IsOnQA, c.SizeClassGuidId as SizeClassGuidId, 
                      t.IsPrimaryKeyMeas as IsPrimaryKeyMeas , t.ProductClassImageId as ProductClassImageId, t.Muser as Muser, t.MDate as MDate
FROM         dbo.pGRPOMCompany AS a INNER JOIN
                      dbo.pGRTolerance AS t ON a.POMCompanyId = t.POMCompanyId INNER JOIN
                      dbo.pGRProductClassImage AS c ON t.ProductClassImageId = c.ProductClassImageID INNER JOIN
                      dbo.pGRPOMAlternates AS b INNER JOIN
                      dbo.pGRAlternates AS g ON b.AlternatesGuidId = g.AlternatesGuidId ON a.POMAlternatesId = b.POMAlternatesId

GO 

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01019', GetDate())
GO