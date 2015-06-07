IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[pTechPackTeam]') AND name = N'IX_pTechPackTeam_StyleID')
DROP INDEX [IX_pTechPackTeam_StyleID] ON [dbo].[pTechPackTeam] WITH ( ONLINE = OFF )
GO

CREATE NONCLUSTERED INDEX [IX_pTechPackTeam_StyleID] ON [dbo].[pTechPackTeam] 
(
	[StyleId] ASC
)
INCLUDE ( [TeamID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '6.0.0001', '09146', GetDate())
GO