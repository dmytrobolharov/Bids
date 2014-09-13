SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER VIEW [dbo].[vwx_Control_CDFeature_SELECT]
AS
SELECT     TOP (100) PERCENT dbo.pConLevel3.Level3ID, dbo.pConLevel3.Level3Desc, dbo.pConLevel3.Detail, dbo.pConLevel3.ImageID, dbo.pConLevel3.ImageVersion, 
                      dbo.pConLevel3.AuxField1, dbo.pConLevel3.AuxField2, dbo.pConLevel3.AuxField3, dbo.pConLevel3.AuxField4, dbo.pConLevel3.AuxField5, dbo.pConLevel3.Active, 
                      dbo.pConLevel3.MDate, dbo.pConLevel3.MUser, dbo.pConLevel3.CUser, dbo.pConLevel3.CDate, dbo.pConstructTree.Level1ID, dbo.pConstructTree.Level2ID, 
                      dbo.pConLevel1.Level1Desc, dbo.pConLevel2.Level2Desc
FROM         dbo.pConLevel3 INNER JOIN
                      dbo.pConstructTree ON dbo.pConLevel3.Level3ID = dbo.pConstructTree.Level3ID INNER JOIN
                      dbo.pConLevel1 ON dbo.pConstructTree.Level1ID = dbo.pConLevel1.Level1ID INNER JOIN
                      dbo.pConLevel2 ON dbo.pConstructTree.Level2ID = dbo.pConLevel2.Level2ID
