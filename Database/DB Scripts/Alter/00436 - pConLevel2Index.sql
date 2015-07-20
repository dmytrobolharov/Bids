IF NOT EXISTS (SELECT name FROM sysindexes WHERE name = 'pConLevel2_Level2Desc')
CREATE NONCLUSTERED INDEX [pConLevel2_Level2Desc] ON [dbo].[pConLevel2] 
(
	[Level2Desc] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]

GO
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.0.0000', '436', GetDate())
GO