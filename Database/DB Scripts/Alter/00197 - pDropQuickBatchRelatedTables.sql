
/****** Object:  Table [dbo].[pQuickBatchReplaceType]    Script Date: 06/24/2010 12:52:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pQuickBatchReplaceType]') AND type in (N'U'))
DROP TABLE [dbo].[pQuickBatchReplaceType]
/****** Object:  Table [dbo].[pQuickBatchReplace]    Script Date: 06/24/2010 12:52:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pQuickBatchReplace]') AND type in (N'U'))
DROP TABLE [dbo].[pQuickBatchReplace]
/****** Object:  Table [dbo].[sAccessQuickBatchReplaceFolder]    Script Date: 06/24/2010 12:52:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessQuickBatchReplaceFolder]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessQuickBatchReplaceFolder]
/****** Object:  Table [dbo].[sAccessGroupQuickBatchReplaceFolder]    Script Date: 06/24/2010 12:52:50 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sAccessGroupQuickBatchReplaceFolder]') AND type in (N'U'))
DROP TABLE [dbo].[sAccessGroupQuickBatchReplaceFolder]

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '197', GetDate())
GO