
-- ******************************************************************************************** */
-- * GERBER TECHNOLOGY                                                                          */
-- *                                                                                            */
-- * YuniquePLM                                                                                 */
-- * Create Script                                                                              */
-- * Database:                                                                                  */
-- * 13 Oct 2011                                                                               */
-- * WorkItem #3474                                                                             */
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

/****** Object:  StoredProcedure [dbo].[rpx_SampleRequest_MeasQASizeSample_SELECT]    Script Date: 10/13/2011 10:56:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[rpx_SampleRequest_MeasQASizeSample_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[rpx_SampleRequest_MeasQASizeSample_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[rpx_SampleRequest_MeasQASizeSample_SELECT]    Script Date: 10/13/2011 10:56:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[rpx_SampleRequest_MeasQASizeSample_SELECT]            
(
	@SampleRequestSubmitID NVARCHAR(50)
)
AS
BEGIN
	SET NOCOUNT ON
	
	
	/*Declare variables.*/
	
	DECLARE @SampleRequestTradeId NVARCHAR(50)
	DECLARE @SampleRequestWorkflowId NVARCHAR(50)
	DECLARE @SampleRequestHeaderId NVARCHAR(50)
	DECLARE @Submit NVARCHAR(5)
	DECLARE @StyleSet NVARCHAR(5)
	DECLARE @IsMetric INT


	/*Get some variables needed.*/
	SELECT
		@SampleRequestTradeID = SampleRequestTradeID
		,@SampleRequestWorkflowID = SampleRequestWorkflowID
		,@StyleSet = StyleSet
		,@Submit = Submit
	FROM pSampleRequestSubmit
	WHERE SampleRequestSubmitID = @SampleRequestSubmitID
	
	/*Determine SampleRequestHeaderID and metric System Used.*/	
	SELECT
		@SampleRequestHeaderId=SampleRequestHeaderID
		,@IsMetric = IsMetric 
		FROM pQAHeader
		WHERE SampleRequestTradeId = @SampleRequestTradeId
		AND SampleRequestWorkflowID = @SampleRequestWorkflowID
		AND StyleSet=@StyleSet	

		
	/* temp table to hold the required data for the QA Sheet */
	CREATE TABLE #temp_QASheet 
	(
		ROWID					INT IDENTITY(1,1) NOT NULL
		,SamplePomID			NVARCHAR(50)
		,SampleRequestHeaderID	NVARCHAR(50)
		,RefCode				NVARCHAR(20)
		,POMDescription			NVARCHAR(250)
		,TolPlus				NVARCHAR(20)
		,TolMinus				NVARCHAR(20)
		,SampleLabelId			NVARCHAR(50)
		,ColLabel				NVARCHAR(30)					
		,Submit					INT
		,SampleNo				INT
		,SizeCol				INT
		,MeasValue				NVARCHAR(20)
		,SampMeasValue			NVARCHAR(20)
		,SortID					INT
	)
	
	IF(@IsMetric = 0)
	
	BEGIN
	
			/* Join the POM tables to get the required data for QA Worksheet */
			INSERT INTO #temp_QASheet
			(
				SamplePomID				
				,SampleRequestHeaderID	
				,RefCode				
				,POMDescription			
				,TolPlus				
				,TolMinus
				,SampleLabelId				
				,ColLabel				
				,Submit
				,SampleNo
				,SizeCol
				,MeasValue
				,SampMeasValue
				,SortID
			)
			SELECT
				pQAPom.SamplePomId
				,PQAPom.SampleRequestHeaderId
				,pQAPom.Refcode AS POM 
				,pQAPom.POMDescription
				,[dbo].[fnx_Num2Frac_KeepNegative] (pQAPom.TolPlus)
				,[dbo].[fnx_Num2Frac_KeepNegative] (pQAPom.TolMinus)
				,pQASampLbl.SampleLabelId
				,pQASampLbl.ColLabel
				,pQASampMeas.Submit
				,pQASampMeas.SampleNo
				,pQASampMeas.Sizecol
				,[dbo].[fnx_Num2Frac_KeepNegative] (pQASampMeas.MeasValue)
				,[dbo].[fnx_Num2Frac_KeepNegative] (pQASampMeas.SampMeasValue)
				,pQAPom.SortId
				
			FROM pQAPom
			INNER JOIN pQASampLbl ON pQAPom.SampleRequestHeaderId = pQASampLbl.SampleRequestHeaderId
			INNER JOIN pQASampMeas ON	pQASampLbl.SampleRequestHeaderId = pQASampMeas.SampleRequestHeaderId
										AND pQAPom.SamplePomId = pQASampMeas.SamplepomId
										AND pQASampLbl.SampleLabelId = pQASampMeas.SampleLabelId
			WHERE CAST(pQAPom.SampleRequestHeaderId AS NVARCHAR(100)) = @SampleRequestHeaderId


			/* Do not change the order by, otherwise the whole logic will not work */
			ORDER BY
				pQAPom.POMDescription								
				,pQASampMeas.SampleNo
				,pQASampLbl.SizeCol
				
				
	END
	ELSE
	BEGIN
			/* Join the POM tables to get the required data for QA Worksheet */
			INSERT INTO #temp_QASheet
			(
				SamplePomID				
				,SampleRequestHeaderID	
				,RefCode				
				,POMDescription			
				,TolPlus				
				,TolMinus
				,SampleLabelId				
				,ColLabel				
				,Submit
				,SampleNo
				,SizeCol
				,MeasValue
				,SampMeasValue
				,SortID
				
			)
			SELECT
				pQAPom.SamplePomId
				,PQAPom.SampleRequestHeaderId
				,pQAPom.Refcode AS POM 
				,pQAPom.POMDescription
				,pQAPom.TolPlus
				,pQAPom.TolMinus
				,pQASampLbl.SampleLabelId
				,pQASampLbl.ColLabel
				,pQASampMeas.Submit
				,pQASampMeas.SampleNo
				,pQASampMeas.Sizecol
				,pQASampMeas.MeasValue
				,pQASampMeas.SampMeasValue
				,pQAPom.SortId
				
			FROM pQAPom
			INNER JOIN pQASampLbl ON pQAPom.SampleRequestHeaderId = pQASampLbl.SampleRequestHeaderId
			INNER JOIN pQASampMeas ON	pQASampLbl.SampleRequestHeaderId = pQASampMeas.SampleRequestHeaderId
										AND pQAPom.SamplePomId = pQASampMeas.SamplepomId
										AND pQASampLbl.SampleLabelId = pQASampMeas.SampleLabelId
			WHERE CAST(pQAPom.SampleRequestHeaderId AS NVARCHAR(100)) = @SampleRequestHeaderId


			/* Do not change the order by, otherwise the whole logic will not work */
			ORDER BY
				pQAPom.POMDescription								
				,pQASampMeas.SampleNo
				,pQASampLbl.SizeCol
				
				
	END
	
	
		
	/*Final Select Statement*/
	SELECT * FROM #temp_QASheet where Submit=@Submit ORDER BY  SortID,[RefCode], [POMDescription]	
	
/* Cleanups */
	DROP TABLE #temp_QASheet
	SET NOCOUNT OFF
END

GO
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02009'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02009', GetDate())
	END
GO