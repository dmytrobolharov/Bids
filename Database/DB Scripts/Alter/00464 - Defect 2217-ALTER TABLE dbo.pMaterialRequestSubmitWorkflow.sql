/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


BEGIN TRANSACTION
GO
ALTER TABLE dbo.pMaterialRequestSubmitWorkflow
	DROP CONSTRAINT DF_pMaterialRequestSubmitWorkflow_EndDate
GO
COMMIT


UPDATE pMaterialRequestSubmitWorkflow 
SET EndDate = NULL 
WHERE EndDate = '1900-01-01 00:00:00.000' 
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '464', GetDate())
GO
