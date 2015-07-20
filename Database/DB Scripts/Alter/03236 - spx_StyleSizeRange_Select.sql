IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSizeRange_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSizeRange_Select]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE spx_StyleSizeRange_Select(
	@StyleID uniqueidentifier,
	@StyleSet int,
	@AmlMeaslblId uniqueidentifier
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
	select @MeasLbl = MeasLbl from pAMLMeasLbl WITH(NOLOCK)  where AMLMeasLblId = @AmlMeaslblId
	
    CREATE TABLE #SizeRangeTemp  (
		RowID  int IDENTITY (1,1),
		SizeValue  NVARCHAR(10)
    )
    
	SET @Row = 0
	SET @Count = 49
	WHILE  @Row <=  @Count
		BEGIN
			set @query = 'select @SizeValue = Size' + cast(@Row as nvarchar(50)) +  ' FROM pSizeRange WITH(NOLOCK) where SizeRangeCode =''' + COALESCE(cast(@SizeRange as nvarchar(50)),'') + ''''
			exec sp_executesql @query,N'@SizeValue NVARCHAR(10) OUTPUT',@SizeValue OUTPUT 
		    if @SizeValue <> ''
				begin
					INSERT INTO #SizeRangeTemp
					(SizeValue) values (@SizeValue)
				end
			SET @Row   =  @Row  + 1
		END
	
	
	select @RowCount = COUNT(*) FROM #SizeRangeTemp where SizeValue = @MeasLbl
	
	select @RowCount
	DROP TABLE #SizeRangeTemp 
END
GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03236'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03236', GetDate())

END

GO