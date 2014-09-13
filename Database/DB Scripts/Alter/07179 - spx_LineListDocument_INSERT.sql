IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineListDocument_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineListDocument_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_LineListDocument_INSERT]
(
		@LineListDocumentID uniqueidentifier,
		@LineFolderID uniqueidentifier,
		@LineListDocumentName nvarchar(500),
		@LineListDocumentExt nvarchar(5),
		@LineListDocumentDescription nvarchar(4000),
		@LineListDocumentSize nvarchar(20),
		@CreatedBy nvarchar(200),
		@CreatedDate datetime
)


AS 

	DECLARE @SystemServerStorageID uniqueidentifier
	SET @SystemServerStorageID = ISNULL((SELECT TOP 1 SystemServerStorageID FROM sSystemServerStorageSetting WHERE CurrentServerStorage = 1),'00000000-0000-0000-0000-000000000000')


	INSERT INTO pLineListDocument(
		LineListDocumentID,
		LineFolderID,
		LineListDocumentName,
		LineListDocumentExt,
		LineListDocumentDescription,
		LineListDocumentSize,
		CUser, 
		CDate, 
		MUser, 
		MDate,
		SystemServerStorageID
		)
	VALUES (
		@LineListDocumentID,
		@LineFolderID,
		@LineListDocumentName,
		@LineListDocumentExt,
		@LineListDocumentDescription,
		@LineListDocumentSize,
		@CreatedBy,
		@CreatedDate,
		@CreatedBy,
		@CreatedDate,
		@SystemServerStorageID
		)
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07179', GetDate())
GO
