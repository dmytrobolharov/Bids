IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_Compliance_Attached_File_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_Compliance_Attached_File_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_Compliance_Attached_File_DELETE]    Script Date: 06/9/2011 19:14:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_Compliance_Attached_File_DELETE]
	-- Add the parameters for the stored procedure here
@ComplianceId UNIQUEIDENTIFIER,
@TradePartnerID AS NVARCHAR(400)	
AS
BEGIN

	DELETE FROM 
           pComplianceTradePartnerSharedFiles
    WHERE
		TradePartnerID IN (SELECT items FROM dbo.Split(@TradePartnerID,',')) 
        AND ComplianceId = @ComplianceId        		
END

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03271'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03271', GetDate())
END	
GO