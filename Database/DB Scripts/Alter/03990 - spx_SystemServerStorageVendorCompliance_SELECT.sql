
/****** Object:  StoredProcedure [dbo].[spx_SystemServerStorageVendorCompliance_SELECT]    Script Date: 09/25/2012 15:45:02 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SystemServerStorageVendorCompliance_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SystemServerStorageVendorCompliance_SELECT]
GO


/****** Object:  StoredProcedure [dbo].[spx_SystemServerStorageVendorCompliance_SELECT]    Script Date: 09/25/2012 15:45:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_SystemServerStorageVendorCompliance_SELECT](@ComplianceDocumentID uniqueidentifier)
AS 

IF (SELECT COUNT(*) FROM uTradePartnerComplianceDocument WHERE ComplianceDocumentID = @ComplianceDocumentID) = 0
	BEGIN
		SELECT TOP 1 
			sSystemServerStorageSetting.StylePath  
		 FROM sSystemServerStorageSetting 
		WHERE CurrentServerStorage = 1
	END
ELSE
	BEGIN
		SELECT 
			sSystemServerStorageSetting.StylePath  
		FROM uTradePartnerComplianceDocument WITH (NOLOCK) INNER JOIN
			  sSystemServerStorageSetting WITH (NOLOCK) ON uTradePartnerComplianceDocument.SystemServerStorageID = sSystemServerStorageSetting.SystemServerStorageID
		WHERE (uTradePartnerComplianceDocument.ComplianceDocumentID = @ComplianceDocumentID)  
	END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03990', GetDate())
GO
