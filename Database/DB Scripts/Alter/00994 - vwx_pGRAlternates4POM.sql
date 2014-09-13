/****** Object:  View [dbo].[vwx_pGRAlternates4POM]    Script Date: 01/07/2011 09:17:19 ******/
IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_pGRAlternates4POM]'))
DROP VIEW [dbo].[vwx_pGRAlternates4POM]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[vwx_pGRAlternates4POM]
AS
SELECT     TOP (100) PERCENT dbo.pGRAlternates.AlternatesCode, dbo.pGRAlternates.AlternatesGuidId, dbo.pGRAlternates.AlternatesDesc, 
                      dbo.pGRPOMAlternates.POMAlternatesId,  dbo.pGRPOMAlternates.POMGuidId
FROM         dbo.pGRPOMAlternates INNER JOIN
                      dbo.pGRAlternates ON dbo.pGRPOMAlternates.AlternatesGuidId = dbo.pGRAlternates.AlternatesGuidId
ORDER BY dbo.pGRAlternates.AlternatesCode

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '00994', GetDate())
GO