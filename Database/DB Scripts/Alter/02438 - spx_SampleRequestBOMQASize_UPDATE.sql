-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 18 Dec 2011                                                                                */
-- * WorkItem #5307																				*/
-- * Copyright (c) 2002-2011 Gerber Technology, Inc.  All rights reserved.                      */
-- * This information is confidential and proprietary.  You may not disseminate it              */
-- * to any other party without the express written consent of Gerber Technology, Inc.          */
-- *                                                                                            */
-- ******************************************************************************************** */
-- ******************************************************************************************** */
-- COMMENTS
--
--
--

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMQASize_UPDATE]    Script Date: 12/18/2011 18:55:48 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMQASize_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMQASize_UPDATE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMQASize_UPDATE]    Script Date: 12/18/2011 18:55:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

Create PROCEDURE [dbo].[spx_SampleRequestBOMQASize_UPDATE]
(
	@StyleID uniqueidentifier, 
	@SampleRequestTradeID uniqueidentifier,
	@SampleRequestWorkflowID uniqueidentifier,
	@NoOfSamples int,
	@SizeIndex int,
	@Selected int,
	@ModifiedBy nvarchar(200),
	@ModifiedDate datetime
)

AS 

DECLARE @Query as varchar(4000)

SET @Query ='UPDATE pSampleRequestQASizeBOM SET '

IF @SizeIndex = 0
	BEGIN
		SET @Query = @Query + ' Sel0 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','
	END

IF @SizeIndex = 1
	BEGIN
		SET @Query = @Query + ' Sel1 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','
	END

IF @SizeIndex = 2
	BEGIN
		SET @Query = @Query + ' Sel2 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','
	END

IF @SizeIndex = 3
	BEGIN
		SET @Query = @Query + ' Sel3 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','
	END

IF @SizeIndex = 4
	BEGIN
		SET @Query = @Query + ' Sel4 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','
	END

IF @SizeIndex = 5
	BEGIN
		SET @Query = @Query + ' Sel5 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','	
	END

IF @SizeIndex = 6
	BEGIN
		SET @Query = @Query + ' Sel6 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','	
	END

IF @SizeIndex = 7
	BEGIN
		SET @Query = @Query + ' Sel7 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','
	END

IF @SizeIndex = 8
	BEGIN
		SET @Query = @Query + ' Sel8 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','	
	END

IF @SizeIndex = 9
	BEGIN
		SET @Query = @Query + ' Sel9 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','
	END

IF @SizeIndex = 10
	BEGIN
		SET @Query = @Query + ' Sel10 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','	
	END

IF @SizeIndex = 11
	BEGIN
		SET @Query = @Query + ' Sel11 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','
	END

IF @SizeIndex = 12
	BEGIN
		SET @Query = @Query + ' Sel12 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','	
	END

IF @SizeIndex = 13
	BEGIN
		SET @Query = @Query + ' Sel13 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','
	END

IF @SizeIndex = 14
	BEGIN
		SET @Query = @Query + ' Sel14 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','
	END

IF @SizeIndex = 15
	BEGIN
		SET @Query = @Query + ' Sel15 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','
	END

IF @SizeIndex = 16
	BEGIN
		SET @Query = @Query + ' Sel16 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','
	END

IF @SizeIndex = 17
	BEGIN
		SET @Query = @Query + ' Sel14 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','
	END

IF @SizeIndex = 18
	BEGIN
		SET @Query = @Query + ' Sel18 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','
	END

IF @SizeIndex = 19
	BEGIN
		SET @Query = @Query + ' Sel19 = ' + CAST(ISNULL(@Selected,0) AS VARCHAR(1)) + ','
	END

	SET @Query = @Query + ' NumberOfSamples = ''' + CAST(ISNULL(@NoOfSamples,'') AS VARCHAR(2)) + ''','
	SET @Query = @Query + ' MDate = ''' + CAST(ISNULL(@ModifiedDate,'') AS VARCHAR(40)) + ''','
	SET @Query = @Query + ' MUser = ''' + CAST(ISNULL(@ModifiedBy ,'') AS NVARCHAR(200)) + ''''
	SET @Query = @Query + ' WHERE SampleRequestTradeID = ''' + CAST(ISNULL(@SampleRequestTradeID,'') AS VARCHAR(40)) + '''' 
	SET @Query = @Query + ' AND SampleRequestWorkflowID = ''' + CAST(ISNULL(@SampleRequestWorkflowID,'') AS VARCHAR(40)) + '''' 
	SET @Query = @Query + ' AND StyleID = ''' + CAST(ISNULL(@StyleID,'') AS VARCHAR(40)) + '''' 

BEGIN
	EXEC (@Query) 
END

GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02438'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02438', GetDate())

END

GO
