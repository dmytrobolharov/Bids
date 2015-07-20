IF OBJECT_ID(N'[dbo].[vw_pBOLOperations_Select]') IS NOT NULL
 DROP VIEW [dbo].[vw_pBOLOperations_Select]
GO

CREATE VIEW [dbo].[vw_pBOLOperations_Select]
AS
SELECT OperationId, OperationCode, OperationName, BaseRateId, SAM, MachineId, Fixed, 
       CUser, MUser, MDate, Active, CDate, CategoryId, 
       dbo.fnx_GetStreamingTypedImageHTML('BOLOP', Image, 50, '') AS Image, Sort
FROM dbo.pBOLOperations


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10307', GetUTCDate())
GO
