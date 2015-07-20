/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSubmitImage_LinkFromImageFolder_INSERT]    Script Date: 07/12/2013 17:37:21 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestSubmitImage_LinkFromImageFolder_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestSubmitImage_LinkFromImageFolder_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestSubmitImage_LinkFromImageFolder_INSERT]    Script Date: 07/12/2013 17:37:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestSubmitImage_LinkFromImageFolder_INSERT]
	@SampleRequestSubmitImageID uniqueidentifier,
	@SampleRequestWorkflowID uniqueidentifier,
	@SampleRequestTradeID uniqueidentifier,
	@TradePartnerVendorID uniqueidentifier,
	@SampleWorkflowID nvarchar(5),
	@Submit int,
	@StyleID uniqueidentifier,
	@StyleColorID uniqueidentifier,
	@ImageID uniqueidentifier,
	@CreatedBy nvarchar(200),
	@StyleSet int,
	@CreatedDate datetime
AS
BEGIN
	INSERT INTO dbo.pSampleRequestSubmitImage(
		SampleRequestSubmitImageID, SampleRequestWorkflowID, SampleRequestTradeID, SampleWorkflowID, 
		TradePartnerVendorID, Submit, StyleID, StyleColorID, ImageFile, ImageType, ImageSize, ImageDescription, 
		StyleSet, ImageID, [Version], CUser, MUser, CDate, MDate, LinkedFromImageFolder
	)
	SELECT @SampleRequestSubmitImageID, @SampleRequestWorkflowID, @SampleRequestTradeID, @SampleWorkflowID, 
		@TradePartnerVendorID, @Submit, @StyleID, @StyleColorID, ImageFile, ImageType, ImageSize, ImageDescription,
		@StyleSet, ImageID, [Version], @CreatedBy, @CreatedBy, @CreatedDate, @CreatedDate, 1
    FROM pImage
    WHERE ImageID = @ImageID
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06057', GetDate())
GO
