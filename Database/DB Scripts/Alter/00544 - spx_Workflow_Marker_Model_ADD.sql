
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF EXISTS (SELECT * FROM sysobjects WHERE id = object_id('spx_Workflow_Marker_Model_ADD') and sysstat & 0xf = 4)
    DROP PROCEDURE spx_Workflow_Marker_Model_ADD
GO

CREATE PROC  [dbo].[spx_Workflow_Marker_Model_ADD]

AS
IF NOT EXISTS( SELECT * FROM Mapping WHERE Map = '40000000-0000-0000-0000-000000000023')
BEGIN

INSERT INTO [dbo].[pWorkflow]
           ([WorkflowID]
           ,[Workflow]
           ,[CDate]
           ,[MDate]
           ,[Active]
           ,[Body]
           ,[WorkflowTypeID])
     VALUES
           ('40000000-0000-0000-0000-000000000023'
           ,'Marker'
           ,Getdate()
           ,Getdate()
           ,1
           ,0
           ,'D')
END
IF NOT EXISTS( SELECT * FROM Mapping WHERE Map = '40000000-0000-0000-0000-000000000037')
BEGIN

INSERT INTO [dbo].[pWorkflow]
           ([WorkflowID]
           ,[Workflow]
           ,[CDate]
           ,[MDate]
           ,[Active]
           ,[Body]
           ,[WorkflowTypeID])
     VALUES
           ('40000000-0000-0000-0000-000000000037'
           ,'Model'
           ,Getdate()
           ,Getdate()
           ,1
           ,0
           ,'D')
END
------
GO

EXEC [dbo].[spx_Workflow_Marker_Model_ADD]
GO

DROP PROCEDURE spx_Workflow_Marker_Model_ADD
GO
----

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '544', GetDate())
GO