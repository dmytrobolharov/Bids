/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_Sort_UPDATE]    Script Date: 07/02/2013 15:45:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_Meas_Sort_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_Sort_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_Meas_Sort_UPDATE]    Script Date: 07/02/2013 15:45:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_Meas_Sort_UPDATE]
	@AmlMeasPomID UNIQUEIDENTIFIER,
	@AmlMeasHdrID UNIQUEIDENTIFIER,
	@PomSort INT,
	@MUser NVARCHAR(200),
	@MDate DATETIME
AS
BEGIN
	SET NOCOUNT ON;
	
	UPDATE pSampleRequestAMLMeasPOM SET SortId = @PomSort, MUser = @MUser, MDate = @MDate
	WHERE SampleRequestAmlMeasPomID = @AmlMeasPomID AND
	SampleRequestAmlMeasHdrID = @AmlMeasHdrID
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05974', GetDate())
GO
