
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 05 April 2012                                                                              */
-- * WorkItem #7565                                                                           	*/
-- * Copyright (c) 2002-2010 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_StyleSizeRange_Select]    Script Date: 04/05/2012 18:43:46 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleSizeRange_Select]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleSizeRange_Select]
GO



/****** Object:  StoredProcedure [dbo].[spx_StyleSizeRange_Select]    Script Date: 04/05/2012 18:43:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_StyleSizeRange_Select](
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
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='03296'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '5.0.0000', '03296', GetDate())

END

GO 

