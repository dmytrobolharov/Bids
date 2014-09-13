IF NOT EXISTS (SELECT name FROM sysindexes WHERE name = 'pConLevel3_Level3Desc')
CREATE NONCLUSTERED INDEX [pConLevel3_Level3Desc] ON [dbo].[pConLevel3] 
(
	[Level3Desc] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

GO
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.0.0000', '437', GetDate())
GO