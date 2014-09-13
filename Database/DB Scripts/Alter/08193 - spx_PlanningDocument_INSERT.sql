IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_PlanningDocument_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_PlanningDocument_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_PlanningDocument_INSERT]
(
		@PlanningDocumentID uniqueidentifier,
		@PlanningID uniqueidentifier,
		@PlanningDocumentName nvarchar(500),
		@PlanningDocumentExt nvarchar(5),
		@PlanningDocumentDescription nvarchar(4000),
		@PlanningDocumentSize nvarchar(20),
		@CreatedBy nvarchar(200),
		@CreatedDate datetime
)


AS 

	DECLARE @SystemServerStorageID uniqueidentifier
	SET @SystemServerStorageID = ISNULL((SELECT TOP 1 SystemServerStorageID FROM sSystemServerStorageSetting WHERE CurrentServerStorage = 1),'00000000-0000-0000-0000-000000000000')


	INSERT INTO pPlanningDocument(
		PlanningDocumentID,
		PlanningID,
		PlanningDocumentName,
		PlanningDocumentExt,
		PlanningDocumentDescription,
		PlanningDocumentSize,
		CUser, 
		CDate, 
		MUser, 
		MDate,
		SystemServerStorageID
		)
	VALUES (
		@PlanningDocumentID,
		@PlanningID,
		@PlanningDocumentName,
		@PlanningDocumentExt,
		@PlanningDocumentDescription,
		@PlanningDocumentSize,
		@CreatedBy,
		@CreatedDate,
		@CreatedBy,
		@CreatedDate,
		@SystemServerStorageID
		)


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08193', GetDate())
GO

