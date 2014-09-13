/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_SizeRange_Select]    Script Date: 07/02/2013 15:48:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequest_DesignSample_SizeRange_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequest_DesignSample_SizeRange_Select]
GO


/****** Object:  StoredProcedure [dbo].[spx_SampleRequest_DesignSample_SizeRange_Select]    Script Date: 07/02/2013 15:48:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[spx_SampleRequest_DesignSample_SizeRange_Select](
	@StyleID uniqueidentifier,
	@StyleSet int,
	@SampleRequestAmlMeaslblId uniqueidentifier
)
AS
BEGIN
	DECLARE @query NVARCHAR(4000)
	DECLARE @SizeRange NVARCHAR(50)
	DECLARE @SizeCol int
	DECLARE @SizeValue NVARCHAR(10)
	DECLARE @RowCount int
	DECLARE @MeasLbl NVARCHAR(24)
	DECLARE @Row int
	DECLARE @Count int 
	
	select @SizeRange = SizeRange from pStyleHeader WITH(NOLOCK)  where StyleID = @StyleID
	select @MeasLbl = MeasLbl from pSampleRequestAMLMeasLbl WITH(NOLOCK)  where SampleRequestAMLMeasLblId = @SampleRequestAmlMeaslblId
	
    CREATE TABLE #SizeRangeTemp  (
		RowID  int IDENTITY (1,1),
		SizeValue  NVARCHAR(10)
    )
    
	SET @Row = 0
	SET @Count = 49
	WHILE  @Row <=  @Count
		BEGIN
			set @query = 'select @SizeValue = LTRIM(RTRIM(Size' + cast(@Row as nvarchar(50)) +  ')) FROM pSizeRange WITH(NOLOCK) where SizeRangeCode =''' + COALESCE(cast(@SizeRange as nvarchar(50)),'') + ''''
			exec sp_executesql @query,N'@SizeValue NVARCHAR(10) OUTPUT',@SizeValue OUTPUT 
		    if @SizeValue <> ''
				begin
					INSERT INTO #SizeRangeTemp
					(SizeValue) values (@SizeValue)
				end
			SET @Row   =  @Row  + 1
		END
	
	PRINT @query 
	
	select @RowCount = COUNT(*) FROM #SizeRangeTemp where SizeValue = @MeasLbl
	
	select @RowCount
	DROP TABLE #SizeRangeTemp 
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '05987', GetDate())
GO