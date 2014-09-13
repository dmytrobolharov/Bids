IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_xCustom17_CustomID]') AND type = 'D')
BEGIN
     ALTER TABLE [xCustom12] DROP CONSTRAINT [DF_xCustom17_CustomID]
END
GO


IF  NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_xCustom12_CustomID]') AND type = 'D')
BEGIN
     ALTER TABLE [xCustom12] ADD  CONSTRAINT [DF_xCustom12_CustomID]  DEFAULT (newid()) FOR [CustomID]
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.1.0000', '01435', GetDate())
GO