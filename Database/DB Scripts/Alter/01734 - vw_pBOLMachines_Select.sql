IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vw_pBOLMachines_Select]'))
DROP VIEW [dbo].[vw_pBOLMachines_Select]
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vw_pBOLMachines_Select]
AS
SELECT     MachineCode, MachineName, MachineDesc, MachineTypeId, Custom1, Custom2, Custom3, Custom4, CUser, Custom5, CDate, MUser, MDate, Active, MachineId, 
                      '<img src=''../System/Control/ImageStream.ashx?IT=BOLM&S=50&ID=' + CAST(ISNULL(Image, '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) 
                      + ''' />' AS Image
FROM         dbo.pBOLMachines

GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='01734'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '01734', GetDate())
END	
GO