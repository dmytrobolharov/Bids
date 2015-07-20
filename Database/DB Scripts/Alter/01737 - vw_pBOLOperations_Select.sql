IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_pBOLOperations_Select]'))
DROP VIEW [dbo].[vw_pBOLOperations_Select]
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_pBOLOperations_Select]
AS
SELECT     OperationId, OperationCode, OperationName, BaseRateId, SAM, MachineId, Fixed, CUser, MUser, MDate, Active, CDate, CategoryId, 
                      '<img src=''../System/Control/ImageStream.ashx?IT=BOLOP&S=50&ID=' + CAST(ISNULL(Image, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + ''' />' AS Image, Sort
FROM         dbo.pBOLOperations

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01737'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01737', GetDate())
END	
GO