IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_MaterialDocument_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_MaterialDocument_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_MaterialDocument_INSERT]
(
		@MaterialDocumentID uniqueidentifier,
		@MaterialID uniqueidentifier,
		@MaterialDocumentName nvarchar(500),
		@MaterialDocumentExt varchar(5),
		@MaterialDocumentDescription nvarchar(4000),
		@MaterialDocumentShared int,
		@MaterialDocumentSize varchar(20),
		@CreatedBy nvarchar(200),
		@CreatedDate datetime,
		@3D INT = 0
)


AS 

	DECLARE @SystemServerStorageID uniqueidentifier
	SET @SystemServerStorageID = ISNULL((SELECT TOP 1 SystemServerStorageID FROM sSystemServerStorageSetting WHERE CurrentServerStorage = 1),'00000000-0000-0000-0000-000000000000')


	INSERT INTO pMaterialDocument(
		MaterialDocumentID,
		MaterialID,
		MaterialDocumentName,
		MaterialDocumentExt,
		MaterialDocumentDescription,
		MaterialDocumentShared,
		MaterialDocumentSize,
		CUser, 
		CDate, 
		MUser, 
		MDate,
		SystemServerStorageID,
		[3D]
		)
	VALUES (
		@MaterialDocumentID,
		@MaterialID,
		@MaterialDocumentName,
		@MaterialDocumentExt,
		@MaterialDocumentDescription,
		@MaterialDocumentShared,
		@MaterialDocumentSize,
		@CreatedBy,
		@CreatedDate,
		@CreatedBy,
		@CreatedDate,
		@SystemServerStorageID,
		@3D
		)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06621', GetDate())
GO