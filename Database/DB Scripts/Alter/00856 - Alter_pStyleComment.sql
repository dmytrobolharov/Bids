IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = N'pStyleComment' and COLUMN_NAME = N'WorkFlowItemId')
       BEGIN 
            ALTER TABLE pStyleComment ADD WorkFlowItemId uniqueidentifier NULL

			CREATE NONCLUSTERED INDEX [IX_pStyleCommentWFIID] ON [dbo].[pStyleComment] 
			(
				[WorkFlowItemId] ASC
			)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
       END
GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '856', GetDate())

GO