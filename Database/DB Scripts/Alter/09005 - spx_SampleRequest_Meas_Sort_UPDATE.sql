IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_Meas_Sort_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_Meas_Sort_UPDATE]
GO

CREATE PROCEDURE [dbo].[spx_SampleRequest_Meas_Sort_UPDATE]
	@SampleRequestHeaderId UNIQUEIDENTIFIER,
	@AmlMeasPomID UNIQUEIDENTIFIER,
	@AmlMeasHdrID UNIQUEIDENTIFIER,
	@PomSort INT,
	@MUser NVARCHAR(200),
	@MDate DATETIME
AS
BEGIN
	UPDATE pMSEvalPom SET SortId = @PomSort, MUser = @MUser, MDate = @MDate
	WHERE AmlMeasPomID = @AmlMeasPomID AND
	AmlMeasHdrID = @AmlMeasHdrID AND
	SampleRequestHeaderId = @SampleRequestHeaderId
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.0.0000', '09005', GetDate())
GO
