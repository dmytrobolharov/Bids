SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF EXISTS(select * from information_schema.views WHERE TABLE_NAME = N'vwx_Control_CDFeature_SELECT')
DROP VIEW vwx_Control_CDFeature_SELECT
GO

CREATE VIEW [dbo].[vwx_Control_CDFeature_SELECT]
AS
SELECT     TOP (100) PERCENT dbo.pConLevel3.Level3ID, dbo.pConLevel3.Level3Desc, dbo.pConLevel3.Detail, dbo.pConLevel3.ImageID, dbo.pConLevel3.ImageVersion, 
                      dbo.pConLevel3.AuxField1, dbo.pConLevel3.AuxField2, dbo.pConLevel3.AuxField3, dbo.pConLevel3.AuxField4, dbo.pConLevel3.AuxField5, dbo.pConLevel3.Active, 
                      dbo.pConLevel3.MDate, dbo.pConLevel3.MUser, dbo.pConLevel3.CUser, dbo.pConLevel3.CDate, dbo.pConstructTree.Level1ID, dbo.pConstructTree.Level2ID
FROM         dbo.pConLevel3 INNER JOIN
                      dbo.pConstructTree ON dbo.pConLevel3.Level3ID = dbo.pConstructTree.Level3ID

GO

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.0.0000', '441', GetDate())
GO
