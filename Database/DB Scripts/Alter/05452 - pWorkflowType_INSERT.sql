if not EXISTS (SELECT * FROM [pWorkflowType] WHERE [WorkflowTypeID] = N'00000000-0000-0000-0000-000000000001')
	INSERT [dbo].[pWorkflowType] ([WorkflowTypeID], [WorkflowTypeName]) VALUES (N'00000000-0000-0000-0000-000000000001', N'Dev. Workflow')
GO

if not EXISTS (SELECT * FROM [pWorkflowType] WHERE [WorkflowTypeID] = N'00000000-0000-0000-0000-000000000002')
	INSERT [dbo].[pWorkflowType] ([WorkflowTypeID], [WorkflowTypeName]) VALUES (N'00000000-0000-0000-0000-000000000002', N'Material Workflow')
GO

if not EXISTS (SELECT * FROM [pWorkflowType] WHERE [WorkflowTypeID] = N'00000000-0000-0000-0000-000000000003')
	INSERT [dbo].[pWorkflowType] ([WorkflowTypeID], [WorkflowTypeName]) VALUES (N'00000000-0000-0000-0000-000000000003', N'Material Request Workflow')
GO

if not EXISTS (SELECT * FROM [pWorkflowType] WHERE [WorkflowTypeID] = N'00000000-0000-0000-0000-000000000004')
	INSERT [dbo].[pWorkflowType] ([WorkflowTypeID], [WorkflowTypeName]) VALUES (N'00000000-0000-0000-0000-000000000004', N'Sample Workflow')
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05452', GetDate())
GO
