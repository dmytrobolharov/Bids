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

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMFitSpec_Logic_UPDATE]    Script Date: 12/18/2011 18:42:05 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestBOMFitSpec_Logic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestBOMFitSpec_Logic_UPDATE]
GO



/****** Object:  StoredProcedure [dbo].[spx_SampleRequestBOMFitSpec_Logic_UPDATE]    Script Date: 12/18/2011 18:42:05 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


Create  PROCEDURE [dbo].[spx_SampleRequestBOMFitSpec_Logic_UPDATE] (
@StyleID UNIQUEIDENTIFIER ,
@StyleSet INT,
@SampleRequestTradeID UNIQUEIDENTIFIER,
@SampleWorkflowID NVARCHAR(5),
@Submit INT, 
@CopySpec INT,
@CopyRev INT,
@CopyFinal INT,
@MUser NVARCHAR(200),
@MDate DATETIME
)
AS 


DECLARE @SampleRequestSpecID UNIQUEIDENTIFIER 
DECLARE @Ask NUMERIC(18,4)
DECLARE @Rev NUMERIC(18,4)
DECLARE @Spec NUMERIC(18,4)
DECLARE @TOL NUMERIC(18,4)
DECLARE @TOLN NUMERIC(18,4)   
DECLARE @Var NUMERIC(18,4)   
DECLARE @Final NUMERIC(18,4)   
DECLARE @WashType NVARCHAR(200)
DECLARE @Status INT 
DECLARE @ApprovedType INT 
DECLARE @Tolerance INT

DECLARE @ROWID INT 
DECLARE @TOTAL INT 


SELECT @Status = a.Status , @ApprovedType = ISNULL(b.ApprovedType,0), @Tolerance = ISNULL(a.NoTolerance,0)
FROM pSampleRequestSubmitBOM a
INNER JOIN pSampleRequestSubmitStatus b On a.Status = b.StatusID
WHERE a.SampleRequestTradeID = @SampleRequestTradeID
AND a.SampleWorkflowID =@SampleWorkflowID
AND a.Submit = @Submit 

SELECT @WashType = WashType
FROM pStyleHeader WHERE StyleID = @StyleID
IF LEN( ISNULL(@WashType,'')) = 0 
	SET @WashType = 'WASH'


CREATE TABLE #tmp (
ROWID INT IDENTITY (1,1),
SampleRequestSpecID UNIQUEIDENTIFIER, 
Ask NUMERIC(18,4), 
Rev NUMERIC(18,4), 
Spec NUMERIC(18,4),
TOL NUMERIC(18,4),
TOLN NUMERIC(18,4),
Final NUMERIC(18,4)
)


INSERT INTO #tmp ( SampleRequestSpecID, Ask, Rev, Spec, TOL, TOLN, Final ) 
SELECT SampleRequestSpecID, Ask, Rev, Spec, TOL, TOLN, Final  
FROM pSampleRequestSpecItemBOM a
WHERE a.StyleID = @StyleID
AND  a.StyleSet = @StyleSet
AND a.SampleRequestTradeID = @SampleRequestTradeID
AND a.SampleWorkflowID = @SampleWorkflowID
AND a.Submit = @Submit


SET @ROWID = 1
SELECT @TOTAL   = COUNT(*) FROM #tmp 


WHILE @ROWID <=  @TOTAL 
BEGIN 

	SELECT @SampleRequestSpecID = SampleRequestSpecID, @Ask = Ask, @Rev = Rev, 
	@Spec = Spec, @Final = Final,
	@TOL = TOL, @TOLN = TOLN
	FROM #tmp WHERE ROWID = @ROWID 

	IF @CopySpec = 1
		SET @Spec = @Ask
	IF @CopyRev = 1
		SET @Rev = @Ask
	IF @CopyFinal =1 
		SET @Final = @Rev
		
	IF @Spec  = 0 
	BEGIN
		SET @Var = 0 
	END
	ELSE
	BEGIN
		SET @Var = @Spec - @Ask 
		
		IF @Tolerance = 0 
		BEGIN
			IF @WashType = 'WASH'
			BEGIN
				SET @Var = ABS(@Var) - @TOL
				IF @TOL > ABS(@Var)
					SET @Var = 0 
			END 
		END
		ELSE 
			SET @Var = ABS(@Var)
	END 
	
	---***
	-- Execute same logic as in spx_SampleRequestSpecItem_UPDATE
	---***

	UPDATE pSampleRequestSpecItemBOM
	SET Spec = @Spec, Rev = @Rev, Final = @Final, Var = @Var,
	MUser = @MUser, MDate = @MDate
	WHERE SampleRequestSpecID = @SampleRequestSpecID
	
	IF @Status = 1 --Resubmit
	BEGIN
		UPDATE pSampleRequestSpecItemBOM SET Rev = Ask,
		MUser = @MUser, MDate = @MDate
		FROM pSampleRequestSpecItemBOM 
		WHERE (SampleRequestSpecID = @SampleRequestSpecID) AND (Rev = 0)
	END  


	IF @ApprovedType = 1 --Approved
	BEGIN
		
		UPDATE pSampleRequestSpecItemBOM SET Rev = Ask,
		MUser = @MUser, MDate = @MDate
		FROM pSampleRequestSpecItemBOM 
		WHERE (SampleRequestSpecID = @SampleRequestSpecID) AND (Rev = 0)
		
		UPDATE pSampleRequestSpecItemBOM SET Final = Rev,
		MUser = @MUser, MDate = @MDate
		WHERE (SampleRequestSpecID = @SampleRequestSpecID) AND (Final = 0) AND (Rev <> 0)
	END  		

	SET @ROWID = @ROWID  + 1 
	
END 


GO

IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02419'))
BEGIN

	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02419', GetDate())

END

GO
