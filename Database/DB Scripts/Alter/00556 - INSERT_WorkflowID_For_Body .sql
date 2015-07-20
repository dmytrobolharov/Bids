

--IF NOT EXISTS( SELECT * FROM pWorkflow WHERE WorkflowID = '11111111-0000-0000-0000-000000000003')
--BEGIN

--INSERT INTO [dbo].[pWorkflow]
           --([WorkflowID]
           --,[Workflow]
           --,[Workflow]
           --,[WorkDays]
           --,[WorkAlert]
           --,[CDate]
           --,[MDate]
           --,[Active]
           --,[Body]
           --,[WorkflowTypeID])
     --VALUES
           --('11111111-0000-0000-0000-000000000003'
           --,'Body - Pattern Sheet'
           --,2
           --,10
           --,10
           --,Getdate()
           --,Getdate()
           --,1
           --,1
           --,'D')
--END
--IF NOT EXISTS( SELECT * FROM pWorkflow WHERE WorkflowID = '11111111-0000-0000-0000-000000000004')
--BEGIN

--INSERT INTO [dbo].[pWorkflow]
           --([WorkflowID]
           --,[Workflow]
           --,[Workflow]
           --,[WorkDays]
           --,[WorkAlert]
           --,[CDate]
           --,[MDate]
           --,[Active]
           --,[Body]
           --,[WorkflowTypeID])
     --VALUES
           --('11111111-0000-0000-0000-000000000004'
           --,'Body-Marker'
           --,2
           --,10
           --,10
           --,Getdate()
           --,Getdate()
           --,1
           --,1
           --,'D')
--END

----
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '556', GetDate())
GO