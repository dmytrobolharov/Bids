IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SystemServerStoragePlanning_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SystemServerStoragePlanning_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_SystemServerStoragePlanning_SELECT](@PlanningDocumentID uniqueidentifier)
AS 

IF (SELECT COUNT(*) FROM pPlanningDocument WHERE PlanningDocumentID = @PlanningDocumentID) = 0
	BEGIN
		SELECT TOP 1 
			sSystemServerStorageSetting.PlanningPath  
		 FROM sSystemServerStorageSetting 
		WHERE CurrentServerStorage = 1
	END
ELSE
	BEGIN
		SELECT 
			sSystemServerStorageSetting.PlanningPath  
		FROM pPlanningDocument WITH (NOLOCK) INNER JOIN
			  sSystemServerStorageSetting WITH (NOLOCK) ON pPlanningDocument.SystemServerStorageID = sSystemServerStorageSetting.SystemServerStorageID
		WHERE (pPlanningDocument.PlanningDocumentID = @PlanningDocumentID)  
	END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08194', GetDate())
GO

