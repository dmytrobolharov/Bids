/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowChangeNotification_User_SELECT]    Script Date: 08/03/2012 10:37:37 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SampleRequestWorkflowChangeNotification_User_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SampleRequestWorkflowChangeNotification_User_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_SampleRequestWorkflowChangeNotification_User_SELECT]    Script Date: 08/03/2012 10:37:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_SampleRequestWorkflowChangeNotification_User_SELECT] 
	@StyleID UNIQUEIDENTIFIER,
	@StyleSet INT,
	@SampleRequestWorkflowID UNIQUEIDENTIFIER = NULL, 
	@SampleRequestTradeID UNIQUEIDENTIFIER = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
    IF (@SampleRequestWorkflowID IS NULL) AND NOT (@SampleRequestTradeID IS NULL)
		BEGIN
			 -- select all users responsible for any workflows in sample request
			SELECT DISTINCT u.Email FROM pSampleRequestWorkflow srw
			LEFT JOIN Users u ON srw.AssignedTo = u.UserId
			WHERE srw.StyleID = @StyleID
			AND srw.StyleSet = @StyleSet
			AND srw.SampleRequestTradeID = @SampleRequestTradeID
			AND u.Email <> ''
		END
    ELSE
		BEGIN
		 -- select user responsible for particular workflow
			SELECT u.Email FROM pSampleRequestWorkflow srw
			LEFT JOIN Users u ON srw.AssignedTo = u.UserId
			WHERE srw.StyleID = @StyleID AND srw.StyleSet = @StyleSet AND srw.SampleRequestWorkflowID = @SampleRequestWorkflowID AND u.Email <> ''
		END
END

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03753', GetDate())
GO