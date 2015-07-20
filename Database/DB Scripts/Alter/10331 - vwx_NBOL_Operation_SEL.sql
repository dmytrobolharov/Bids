IF OBJECT_ID(N'[dbo].[vwx_NBOL_Operation_SEL]') IS NOT NULL
 DROP VIEW [dbo].[vwx_NBOL_Operation_SEL]
GO

CREATE VIEW [dbo].[vwx_NBOL_Operation_SEL]
AS
SELECT OperationID, OperationCode, OperationName, Category, MachineID, ImageID, CUser, CDate, MUser, MDate, 
       Active, CustomField1, CustomField2, CustomField3, CustomField4, CustomField5, 
	   dbo.fnx_GetStreamingTypedImageHTML('BOLOP', ImageID, 50, '') AS Image
FROM dbo.pNBOLOperation


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10331', GetUTCDate())
GO
