IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[vwx_SampleWorkflowGroup_SELECT]'))
DROP VIEW [dbo].[vwx_SampleWorkflowGroup_SELECT]
GO

CREATE VIEW  [dbo].[vwx_SampleWorkflowGroup_SELECT]
AS
	SELECT DISTINCT GroupID
	, STUFF ((SELECT ', ' + sw.GroupName
			  FROM pSampleWorkflow sw
			  WHERE sw.GroupID = psw.GroupID
			  FOR XML PATH('')), 1, 2, '') AS GroupName
	FROM pSampleWorkflow psw
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09306', GetDate())
GO
