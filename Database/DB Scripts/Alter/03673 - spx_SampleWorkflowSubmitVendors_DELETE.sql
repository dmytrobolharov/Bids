/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitVendors_DELETE]    Script Date: 06/26/2012 15:42:33 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleWorkflowSubmitVendors_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleWorkflowSubmitVendors_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleWorkflowSubmitVendors_DELETE]    Script Date: 06/26/2012 15:42:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleWorkflowSubmitVendors_DELETE]	
	@SampleRequestSubmitVendorID	uniqueidentifier,
	@SampleRequestSubmitID	uniqueidentifier
AS
IF EXISTS (SELECT * FROM pSampleRequestSubmitVendor WHERE SampleRequestSubmitID =  @SampleRequestSubmitID
	AND SampleRequestSubmitVendorID = @SampleRequestSubmitVendorID)
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DELETE FROM pSampleRequestGCCWorkflow
	WHERE SampleRequestSubmitID =  @SampleRequestSubmitID
				AND SampleRequestSubmitVendorID = @SampleRequestSubmitVendorID
	
	DELETE FROM pSampleRequestSubmitVendor WHERE SampleRequestSubmitID =  @SampleRequestSubmitID
				AND SampleRequestSubmitVendorID = @SampleRequestSubmitVendorID
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03673', GetDate())
GO