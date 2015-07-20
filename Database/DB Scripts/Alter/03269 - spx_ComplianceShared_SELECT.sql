IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ComplianceShared_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ComplianceShared_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_ComplianceShared_SELECT]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ComplianceShared_SELECT] (@ComplianceTypeID int,@TradePartnerID as nvarchar(50) = null)
AS 
IF @ComplianceTypeID <> 0
	BEGIN
	
		SELECT     dbo.pCompliance.ComplianceID, dbo.pComplianceType.ComplianceType, dbo.pCompliance.ComplianceTypeId, dbo.pCompliance.ComplianceFileName,
				dbo.pCompliance.ComplianceDescription, dbo.pCompliance.ComplianceFileExt, dbo.pCompliance.ComplianceFileSize, 
				dbo.pCompliance.ComplianceFileShared, dbo.pCompliance.CUser, dbo.pCompliance.CDate, dbo.pCompliance.MUser, dbo.pCompliance.MDate, 
				dbo.pCompliance.MChange, dbo.pCompliance.ComplianceFolderOrder
		FROM         dbo.pCompliance WITH (NOLOCK) INNER JOIN
				dbo.pComplianceType WITH (NOLOCK) ON dbo.pCompliance.ComplianceTypeId = dbo.pComplianceType.ComplianceTypeID
				INNER JOIN pComplianceTradePartnerSharedFiles ON pCompliance.ComplianceID=pComplianceTradePartnerSharedFiles.ComplianceID
		WHERE    (pCompliance.ComplianceTypeId = @ComplianceTypeID) AND (pComplianceTradePartnerSharedFiles.TradePartnerID = @TradePartnerID)
		
	END
	
ELSE
	
		SELECT     dbo.pCompliance.ComplianceID, dbo.pComplianceType.ComplianceType, dbo.pCompliance.ComplianceTypeId, dbo.pCompliance.ComplianceFileName,
				dbo.pCompliance.ComplianceDescription, dbo.pCompliance.ComplianceFileExt, dbo.pCompliance.ComplianceFileSize, 
				dbo.pCompliance.ComplianceFileShared, dbo.pCompliance.CUser, dbo.pCompliance.CDate, dbo.pCompliance.MUser, dbo.pCompliance.MDate, 
				dbo.pCompliance.MChange, dbo.pCompliance.ComplianceFolderOrder
		FROM         dbo.pCompliance WITH (NOLOCK) INNER JOIN
				dbo.pComplianceType WITH (NOLOCK) ON dbo.pCompliance.ComplianceTypeId = dbo.pComplianceType.ComplianceTypeID
				INNER JOIN pComplianceTradePartnerSharedFiles ON pCompliance.ComplianceID=pComplianceTradePartnerSharedFiles.ComplianceID
		WHERE     (pComplianceTradePartnerSharedFiles.TradePartnerID =@TradePartnerID)
		
GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03269'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03269', GetDate())
END	
GO