/****** Object:  StoredProcedure [dbo].[spx_NPMSampleWorkflowSubmitVendors_INSERT]    Script Date: 03/01/2013 11:59:12 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_NPMSampleWorkflowSubmitVendors_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_NPMSampleWorkflowSubmitVendors_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_NPMSampleWorkflowSubmitVendors_INSERT]    Script Date: 03/01/2013 11:59:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_NPMSampleWorkflowSubmitVendors_INSERT](
	@SampleRequestSubmitID UNIQUEIDENTIFIER,
	@ItemID UNIQUEIDENTIFIER,
	@CUser NVARCHAR(200),
	@CDate DATETIME,
	@Where NVARCHAR(MAX)
)
AS


IF NOT EXISTS( SELECT * FROM pSampleRequestSubmitVendor WHERE SampleRequestSubmitID =  @SampleRequestSubmitID
	AND TradePartnerVendorID = @ItemID) 
BEGIN

	DECLARE @VendorType NVARCHAR(200)
	
	SELECT @VendorType = b.TradePartnerRelationshipTypeName
	FROM dbo.uTradePartner a 
		INNER JOIN dbo.uTradePartnerRelationshipType b ON a.TradePartnerRelationshipType = b.TradePartnerRelationshipTypeID
	WHERE TradePartnerID = @ItemID

	INSERT INTO pSampleRequestSubmitVendor (SampleRequestSubmitVendorID , SampleRequestSubmitID,
		TradePartnerVendorID, VendorType, CUser, CDate ) 
	VALUES ( NEWID(), @SampleRequestSubmitID,
		@ItemID, @VendorType , @CUser, @CDate )
		
END 


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '05206', GetDate())
GO

