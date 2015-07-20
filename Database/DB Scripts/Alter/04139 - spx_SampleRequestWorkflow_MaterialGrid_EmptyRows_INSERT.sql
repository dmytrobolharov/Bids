IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflow_MaterialGrid_EmptyRows_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflow_MaterialGrid_EmptyRows_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflow_MaterialGrid_EmptyRows_INSERT]
	@SampleRequestSubmitID UNIQUEIDENTIFIER,
	@SampleRequestSubmitVendorID UNIQUEIDENTIFIER,
	@Submit INT,
	@CDate DATETIME,
	@CUser NVARCHAR(200),
	@RowsToInsert INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @Counter INT
	DECLARE @Sort INT
	DECLARE @StrSort VARCHAR(4)
	
	SELECT @Sort = MAX(CAST(ISNULL(Sort, '0') AS INT)) FROM pSampleRequestGCCWorkflow
	WHERE SampleRequestSubmitID = @SampleRequestSubmitID
	AND Submit = @Submit
	AND SampleRequestSubmitVendorID = @SampleRequestSubmitVendorID
	
	IF @Sort IS NULL
	BEGIN
		SET @Sort = 1
	END
	ELSE
	BEGIN
		SET @Sort = @Sort + 1
	END
	
    SET @Counter = 0
    WHILE @Counter < @RowsToInsert
    BEGIN
    
		SET @StrSort = RIGHT('0000' + CAST(@Sort AS VARCHAR(4)), 4)
    
		INSERT INTO pSampleRequestGCCWorkflow
		(SampleRequestSubmitID, Custom1, Custom2, Custom3, Custom4, Custom5, Custom6, Submit, 
		SampleRequestSubmitVendorID, CUser, CDate, MUser, MDate, Sort)
		VALUES (@SampleRequestSubmitID, '', '', '', '', 0, '', @Submit,
		@SampleRequestSubmitVendorID, @CUser, @CDate, @CUser, @CDate, @StrSort)
    
		SET @Counter = @Counter + 1
		SET @Sort = @Sort + 1
    END
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04139', GetDate())
GO
