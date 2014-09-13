IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDocument_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDocument_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_StyleDocument_INSERT]
(@StyleDocumentID uniqueidentifier,
@StyleDevelopmentID uniqueidentifier,
@StyleID uniqueidentifier,
@StyleDocumentName nvarchar(500),
@StyleDocumentExt nvarchar(5),
@StyleDocumentDescription nvarchar(4000),
@StyleDocumentShared int,
@StyleDocumentSize nvarchar(20),
@CreatedBy nvarchar(200),
@CreatedDate datetime,
@TeamID uniqueidentifier = null)
AS 

DECLARE @SystemStorageID uniqueidentifier
SET @SystemStorageID = ISNULL((SELECT TOP 1 SystemServerStorageID FROM sSystemServerStorageSetting WHERE CurrentServerStorage = 1),'00000000-0000-0000-0000-000000000000')

INSERT INTO pStyleDocument(
	StyleDocumentID,
	StyleDevelopmentID,
	StyleID,
	StyleDocumentName,
	StyleDocumentExt,
	StyleDocumentDescription,
	StyleDocumentShared,
	StyleDocumentSize,
	CUser, 
	CDate, 
	MUser, 
	MDate,
	SystemServerStorageID,
	TradePartnerID)
VALUES 
	(@StyleDocumentID,
	@StyleDevelopmentID,
	@StyleID,
	@StyleDocumentName,
	@StyleDocumentExt,
	@StyleDocumentDescription,
	@StyleDocumentShared,
	@StyleDocumentSize,
	@CreatedBy,
	@CreatedDate,
	@CreatedBy,
	@CreatedDate,
	@SystemStorageID,
	@TeamID)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06657', GetDate())
GO
