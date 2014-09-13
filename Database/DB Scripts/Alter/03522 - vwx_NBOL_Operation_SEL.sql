IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_NBOL_Operation_SEL]'))
DROP VIEW [dbo].[vwx_NBOL_Operation_SEL]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[vwx_NBOL_Operation_SEL]
AS
SELECT     OperationID, OperationCode, OperationName, Category, MachineID, ImageID, CUser, CDate, MUser, MDate, Active, CustomField1, CustomField2, CustomField3, 
                      CustomField4, CustomField5, '<img src=''../System/Control/ImageStream.ashx?IT=BOLOP&S=50&ID=' + CAST(ISNULL(ImageID, 
                      '00000000-0000-0000-0000-000000000000') AS NVARCHAR(50)) + ''' />' AS Image
FROM         dbo.pNBOLOperation

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03522', GetDate())
GO