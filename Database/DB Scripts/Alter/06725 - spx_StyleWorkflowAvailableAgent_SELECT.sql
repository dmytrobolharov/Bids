IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleWorkflowAvailableAgent_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleWorkflowAvailableAgent_SELECT]
GO

CREATE PROCEDURE [dbo].[spx_StyleWorkflowAvailableAgent_SELECT]
(@StyleID uniqueidentifier,
@TradePartnerID uniqueidentifier)
AS 


DECLARE @StyleTemplateID UNIQUEIDENTIFIER 
SELECT @StyleTemplateID = WorkflowTemplateId  FROM pStyleWorkflowSchedule WITH (NOLOCK) WHERE StyleID = @StyleID

DECLARE @COUNTWF INTEGER
DECLARE @COUNTSTYLEWF INTEGER
SELECT @COUNTWF=COUNT(*) FROM pStyleWorkflowTeam WITH (NOLOCK) WHERE StyleId = @StyleId AND TeamID = @TradePartnerId AND WorkflowID='70000000-0000-0000-0000-000000000001'
SELECT @COUNTSTYLEWF=COUNT(*) FROM pStyleWorkflow WITH (NOLOCK) WHERE StyleId = @StyleId  AND WorkflowID='70000000-0000-0000-0000-000000000001'

IF @StyleTemplateID IS NULL 
BEGIN
IF @COUNTWF > 0 
 BEGIN
	;WITH sw AS (
		SELECT *, ROW_NUMBER() OVER(PARTITION BY WorkflowID ORDER BY WorkSort) AS RowNo
		FROM pStyleWorkflow 
		WHERE StyleID = @StyleID AND StyleSet = 1
	) 
    SELECT b.Map, b.MapDetail
	FROM  sw a WITH (NOLOCK) 
	INNER JOIN Mapping b WITH (NOLOCK) ON a.WorkflowID = b.Map
	WHERE a.RowNo = 1 AND b.MAP NOT IN (SELECT WorkflowId FROM pStyleWorkflowTeam WITH (NOLOCK) WHERE StyleId = @StyleId AND TeamID = @TradePartnerId)
	ORDER BY a.WorkSort, a.WorkflowID
 END
ELSE
  BEGIN
	;WITH sw AS (
		SELECT *, ROW_NUMBER() OVER(PARTITION BY WorkflowID ORDER BY WorkSort) AS RowNo
		FROM pStyleWorkflow 
		WHERE StyleID = @StyleID AND StyleSet = 1
	) 
	SELECT '70000000-0000-0000-0000-000000000001' AS MAP, 'Style Header' AS MapDetail, '00' AS WorkSort, '70000000-0000-0000-0000-000000000001' AS WorkflowID
    UNION
	SELECT b.Map, b.MapDetail, a.WorkSort, a.WorkflowID
	FROM sw a WITH (NOLOCK)
	INNER JOIN Mapping b WITH (NOLOCK) ON a.WorkflowID = b.Map
	WHERE a.RowNo = 1 AND b.MAP NOT IN (
			SELECT WorkflowId
			FROM pStyleWorkflowTeam WITH (NOLOCK)
			WHERE StyleId = @StyleId AND TeamID = @TradePartnerId)	
		AND b.Map <> '70000000-0000-0000-0000-000000000001'	
	ORDER BY WorkSort, WorkflowID
  END
END
ELSE
BEGIN
IF @COUNTWF > 0 
  BEGIN
	;WITH sw AS (
		SELECT *, ROW_NUMBER() OVER(PARTITION BY WorkflowID ORDER BY WorkSort) AS RowNo
		FROM pStyleWorkflow 
		WHERE StyleID = @StyleID AND StyleSet = 1
	) 
	SELECT c.Map, c.MapDetail
	FROM pWorkflowTemplateItem a WITH (NOLOCK) 
	INNER JOIN sw b WITH (NOLOCK) ON  a.WorkflowID = b.WorkflowID
	INNER JOIN Mapping c WITH (NOLOCK) ON c.Map =  b.WorkflowID
	WHERE  a.WorkflowTemplateID = @StyleTemplateID
		AND b.RowNo = 1
		AND c.MAP NOT IN (
			SELECT WorkflowId FROM pStyleWorkflowTeam WITH (NOLOCK) WHERE StyleId = @StyleId AND TeamID = @TradePartnerId)
	ORDER BY b.WorkSort, a.WorkflowID
  END
ELSE
  BEGIN
	;WITH sw AS (
		SELECT *, ROW_NUMBER() OVER(PARTITION BY WorkflowID ORDER BY WorkSort) AS RowNo
		FROM pStyleWorkflow 
		WHERE StyleID = @StyleID AND StyleSet = 1
	) 
    SELECT '70000000-0000-0000-0000-000000000001' AS MAP, 'Style Header' AS MapDetail, '00' AS WorkSort, '70000000-0000-0000-0000-000000000001' AS WorkflowID
    UNION
	SELECT c.Map, c.MapDetail, b.WorkSort, b.WorkflowID
	FROM pWorkflowTemplateItem a WITH (NOLOCK) 
	INNER JOIN sw b WITH (NOLOCK) ON  a.WorkflowID = b.WorkflowID
	INNER JOIN Mapping c WITH (NOLOCK) ON c.Map =  b.WorkflowID
	WHERE  a.WorkflowTemplateID = @StyleTemplateID
		AND b.RowNo = 1
		AND c.MAP NOT IN (
			SELECT WorkflowId FROM pStyleWorkflowTeam WITH (NOLOCK) WHERE StyleId = @StyleId AND TeamID = @TradePartnerId)
		AND c.Map <> '70000000-0000-0000-0000-000000000001'	
	ORDER BY WorkSort, WorkflowID
	
  END
END 


IF @COUNTSTYLEWF = 0 
BEGIN
INSERT INTO dbo.pStyleWorkflow
        ( StyleWorkflowID ,          StyleWorkflowMasterID ,          StyleID ,          StyleSet ,          WorkflowID ,          WorkflowType ,
          WorkflowOrder ,          WorkDay ,          WorkDate ,          WorkStart ,          WorkDue ,          WorkAssignedTo ,
          WorkComplete ,          WorkStatus ,          WorkStatusDate ,          WorkStatusBy ,          WorkVersion ,
          WorkComments ,          WorkSort ,          CUser ,          CDate ,          MUser ,          MDate
        )
VALUES  ( NEWID() , -- StyleWorkflowID - uniqueidentifier
          NULL , -- StyleWorkflowMasterID - uniqueidentifier
          @StyleID , -- StyleID - uniqueidentifier
          1 , -- StyleSet - int
          '70000000-0000-0000-0000-000000000001' , -- WorkflowID - uniqueidentifier
          0 , -- WorkflowType - int
          0 , -- WorkflowOrder - int
          0 , -- WorkDay - int
          GETDATE() , -- WorkDate - datetime
          GETDATE() , -- WorkStart - datetime
          GETDATE() , -- WorkDue - datetime
          0 , -- WorkAssignedTo - int
          NULL , -- WorkComplete - nvarchar(50)
          0 , -- WorkStatus - int
          GETDATE() , -- WorkStatusDate - datetime
          NULL , -- WorkStatusBy - nvarchar(50)
          0 , -- WorkVersion - int
          NULL , -- WorkComments - nvarchar(4000)
          NULL , -- WorkSort - nvarchar(2)
          NULL , -- CUser - nvarchar(100)
          GETDATE() , -- CDate - datetime
          NULL , -- MUser - nvarchar(100)
          GETDATE()  -- MDate - datetime
        )
END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06725', GetDate())
GO
