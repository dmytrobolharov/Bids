IF NOT EXISTS (SELECT name FROM sysindexes WHERE name = 'pConLevel1_Level1Desc')
CREATE NONCLUSTERED INDEX [pConLevel1_Level1Desc] ON [dbo].[pConLevel1] 
(
	[Level1Desc] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '435', GetDate())
GO