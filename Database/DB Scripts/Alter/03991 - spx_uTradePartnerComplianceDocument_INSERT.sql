/****** Object:  StoredProcedure [dbo].[spx_uTradePartnerComplianceDocument_INSERT]    Script Date: 09/25/2012 15:46:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_uTradePartnerComplianceDocument_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_uTradePartnerComplianceDocument_INSERT]
GO


/****** Object:  StoredProcedure [dbo].[spx_uTradePartnerComplianceDocument_INSERT]    Script Date: 09/25/2012 15:46:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_uTradePartnerComplianceDocument_INSERT]
(@ComplianceDocumentId uniqueidentifier,
@TradePartnerComplianceId uniqueidentifier,
@TradePartnerId uniqueidentifier,
@DocumentName nvarchar(500),
@DocumentExt nvarchar(5),
@DocumentDesc nvarchar(4000),
@DocumentShared int,
@DocumentSize nvarchar(20),
@CreatedBy nvarchar(200),
@CreatedDate datetime)
AS 

DECLARE @SystemStorageID uniqueidentifier
SET @SystemStorageID = ISNULL((SELECT TOP 1 SystemServerStorageID FROM sSystemServerStorageSetting WHERE CurrentServerStorage = 1),'00000000-0000-0000-0000-000000000000')

INSERT INTO uTradePartnerComplianceDocument(
	ComplianceDocumentId,
	TradePartnerComplianceId,
	TradePartnerId,
	DocumentName,
	DocumentExt,
	DocumentDesc,
	DocumentShared,
	DocumentSize,
	CUser, 
	CDate, 
	MUser, 
	MDate,
	SystemServerStorageID)
VALUES 
	(@ComplianceDocumentId,
	@TradePartnerComplianceId,
	@TradePartnerId,
	@DocumentName,
	@DocumentExt,
	@DocumentDesc,
	@DocumentShared,
	@DocumentSize,
	@CreatedBy,
	@CreatedDate,
	@CreatedBy,
	@CreatedDate,
	@SystemStorageID)

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03991', GetDate())
GO
