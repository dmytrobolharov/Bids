/****** Object:  Index [PK_pTACalStatus]    Script Date: 09/02/2014 12:02:21 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTACalStatus]') AND name = N'PK_pTACalStatus')
ALTER TABLE [dbo].[pTACalStatus] DROP CONSTRAINT [PK_pTACalStatus]
GO

/****** Object:  Index [PK_pTACalStatus]    Script Date: 09/02/2014 12:02:22 ******/
ALTER TABLE [dbo].[pTACalStatus] ADD CONSTRAINT [PK_pTACalStatus] PRIMARY KEY CLUSTERED 
(
	[StatusID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES   ('DB_Version', '6.0.0000', '09044', GetDate())
GO
