/****** Object:  Table [dbo].[pStyleWorkflowToChangeTable]    Script Date: 07/16/2012 16:54:44 ******/
DELETE FROM pStyleWorkflowToChangeTable
GO

INSERT [dbo].[pStyleWorkflowToChangeTable] ([WorkflowID], [ChangeTableID]) VALUES (N'30000000-0000-0000-0000-000000000003', N'036f8b4c-c1cc-df11-af06-005056c00008')
GO

INSERT [dbo].[pStyleWorkflowToChangeTable] ([WorkflowID], [ChangeTableID]) VALUES (N'40000000-0000-0000-0000-000000000004', N'00000003-c1cc-df11-af06-005056c00008')
GO

INSERT [dbo].[pStyleWorkflowToChangeTable] ([WorkflowID], [ChangeTableID]) VALUES (N'40000000-0000-0000-0000-000000000005', N'dd12faae-7acd-df11-af06-005056c00008')
GO

INSERT [dbo].[pStyleWorkflowToChangeTable] ([WorkflowID], [ChangeTableID]) VALUES (N'40000000-0000-0000-0000-000000000006', N'd612faae-7acd-df11-af06-005056c00009')
GO

INSERT [dbo].[pStyleWorkflowToChangeTable] ([WorkflowID], [ChangeTableID]) VALUES (N'40000000-0000-0000-0000-000000000013', N'd616faae-7acd-df11-af06-005056c00008')
GO

INSERT [dbo].[pStyleWorkflowToChangeTable] ([WorkflowID], [ChangeTableID]) VALUES (N'40000000-0000-0000-0000-000000000044', N'00000002-c1cc-df11-af06-005056c00008')
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03703', GetDate())
GO
