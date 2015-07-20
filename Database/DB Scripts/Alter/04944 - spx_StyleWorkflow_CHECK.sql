

/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflow_CHECK]    Script Date: 01/31/2013 00:49:06 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflow_CHECK]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflow_CHECK]
GO


/****** Object:  StoredProcedure [dbo].[spx_StyleWorkflow_CHECK]    Script Date: 01/31/2013 00:49:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[spx_StyleWorkflow_CHECK]  ( 
@StyleID uniqueidentifier , 
@CUser nvarchar (200) 
)
AS 

	DECLARE @StyleSet INT 

	DECLARE @StyleDevelopmentID UNIQUEIDENTIFIER 
	DECLARE @Variation INT 
	
	DECLARE @nCont INT	
	DECLARE @nTotalStyle  INT 
	DECLARE @nCurrentStyle INT 
	DECLARE @CurrentStyleID UNIQUEIDENTIFIER 
	

	DECLARE @WorkflowID uniqueidentifier 
	DECLARE @WorkflowType int 
	DECLARE @WorkDay int
	DECLARE @WorkDate datetime
	DECLARE @WorkStart datetime 
	DECLARE @WorkDue datetime 
	DECLARE @WorkAssignedTo  int
	DECLARE @WorkComplete nvarchar (50) 
	DECLARE @WorkStatus int 
	DECLARE @WorkVersion int 
	DECLARE @WorkSort int 


	CREATE TABLE #tempStyleWorkflow  ( 
		[RecID]			int IDENTITY(1,1)  NOT NULL,
		[WorkflowID]    		uniqueidentifier NULL,
		[WorkflowType]		int NULL , 
		[WorkDay]   		int  NULL,
		[WorkDate]        		datetime NULL,
		[WorkStart]        		datetime  NULL,
		[WorkDue]         		datetime NULL,
		[WorkAssignedTo]	int NULL ,
		[WorkComplete]  	nvarchar(50)  NULL , 
		[WorkStatus] 		int NULL ,	
		[WorkVersion] 		int NULL ,
		[WorkSort] 		int NULL 
	)

	
	CREATE TABLE #tmpStyle (
		RecID INT IDENTITY(1,1) ,
		StyleID UNIQUEIDENTIFIER 
	)
	
	
		
	SELECT  @StyleSet = StyleSet, @StyleDevelopmentID = DevelopmentID from dbo.pStyleHeader WITH (NOLOCK) where  StyleID = @StyleID 
	SELECT @Variation = Variation FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleID = @StyleID 
			
	IF @StyleSet IS NULL 
		SET @StyleSet  = 0
				
	
	-- SIZE CLASSES 
	INSERT INTO #tmpStyle  (StyleID )
	SELECT StyleID FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleDevelopmentID =  @StyleDevelopmentID
		
	SELECT @nTotalStyle =  COUNT(*) FROM #tmpStyle 
	SET @nCurrentStyle  = 1 
		
	PRINT  'TOTAL SIZE CLASES = '   +  CAST ( @nTotalStyle  AS NVARCHAR (50)) 
	PRINT  'TOTAL SET = '   +  CAST ( @StyleSet AS NVARCHAR (50)) 


	-- GET WORKFLOWS 		
	INSERT INTO  #tempStyleWorkflow
	SELECT  WorkflowID, WorkflowType , WorkDay ,  WorkDate , WorkStart ,  WorkDue , WorkAssignedTo ,
		 WorkComplete , WorkStatus , WorkVersion , WorkSort
	FROM dbo.pStyleWorkflow WITH (NOLOCK) 
	WHERE StyleID=@StyleID  
	AND StyleSet = 1
	AND WorkFlowID not in ( SELECT WorkflowID From dbo.pStyleWorkflow WITH (NOLOCK) WHERE StyleID=@StyleID  AND StyleSet = @StyleSet  )

		
	WHILE @nCurrentStyle <= @nTotalStyle
	BEGIN 

		SELECT @CurrentStyleID =  StyleID FROM  #tmpStyle  WHERE RecID = @nCurrentStyle
		
		SET @nCont =  1 
				

		
		-- STYLESET IN A SIZE CLASS		
		WHILE @nCont <= @StyleSet 
		BEGIN

			DECLARE @nCurrentWorkflow INT	
			DECLARE @nTotalWorkflow INT 
			
			SELECT @nTotalWorkflow = COUNT (*) FROM #tempStyleWorkflow
			SET @nCurrentWorkflow  =  1 
			
			WHILE  @nCurrentWorkflow  <= @nTotalWorkflow 
			BEGIN
			
				SELECT  @WorkflowID = WorkflowID ,  @WorkflowType = WorkflowType , 
				@WorkDay = WorkDay ,  @WorkDate = WorkDate , @WorkStart = WorkStart ,  @WorkDue = WorkDue , @WorkAssignedTo = WorkAssignedTo ,
				@WorkComplete = WorkComplete , @WorkStatus = WorkStatus , @WorkVersion = WorkVersion , @WorkSort = WorkSort
				FROM #tempStyleWorkflow WHERE  RecID = @nCurrentWorkflow
							
						
				IF ( SELECT COUNT(*) FROM  pStyleWorkflow WITH (NOLOCK) WHERE StyleID = @CurrentStyleID AND StyleSet = @nCont AND WorkflowID =  @WorkflowID  ) = 0 
				BEGIN 

					INSERT INTO dbo.pStyleWorkflow 	(StyleWorkflowID , StyleID , StyleSet , WorkflowID , WorkflowType, WorkDay ,  WorkDate, WorkStart, WorkDue, WorkAssignedTo,
					WorkComplete, WorkStatus , WorkVersion , CUser, CDate, MUser, MDate , WorkSort )
					VALUES ( NEWID() ,  @CurrentStyleID ,  @nCont,  @WorkflowID , @WorkflowType, @WorkDay ,  @WorkDate, @WorkStart, @WorkDue, @WorkAssignedTo,
					@WorkComplete, @WorkStatus , @WorkVersion , @CUser, getdate() , @CUser,  getdate()  , @WorkSort ) 
				END 

				SET @nCurrentWorkflow = @nCurrentWorkflow + 1 
						
			END  -- WORKFLOWS
			
			SET @nCont = @nCont + 1 		
			
		END  -- STYLESETS
		
		SET @nCurrentStyle = @nCurrentStyle + 1 
		
	END  -- SIZE CLASSES 



	DELETE FROM dbo.pStyleWorkflow 
	WHERE StyleID IN  ( SELECT StyleID FROM pStyleDevelopmentItem WITH (NOLOCK) WHERE StyleDevelopmentID =  @StyleDevelopmentID ) 
	AND  StyleSet > @StyleSet  



	
	DROP TABLE #tempStyleWorkflow  
	DROP TABLE #tmpStyle

GO





INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04944', GetDate())
GO