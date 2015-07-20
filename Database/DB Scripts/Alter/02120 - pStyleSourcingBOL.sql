
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pStyleSourcingBOL_pBOLOpToMacro1]') AND parent_object_id = OBJECT_ID(N'[dbo].[pStyleSourcingBOL]'))
ALTER TABLE [dbo].[pStyleSourcingBOL] DROP CONSTRAINT [FK_pStyleSourcingBOL_pBOLOpToMacro1]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pStyleSourcingBOL_pStyleBOLException]') AND parent_object_id = OBJECT_ID(N'[dbo].[pStyleSourcingBOL]'))
ALTER TABLE [dbo].[pStyleSourcingBOL] DROP CONSTRAINT [FK_pStyleSourcingBOL_pStyleBOLException]
GO

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_pStyleSourcingBOL_pStyleBOLPageOperations]') AND parent_object_id = OBJECT_ID(N'[dbo].[pStyleSourcingBOL]'))
ALTER TABLE [dbo].[pStyleSourcingBOL] DROP CONSTRAINT [FK_pStyleSourcingBOL_pStyleBOLPageOperations]
GO

IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__pStyleSou__Sourc__1B558296]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleSourcingBOL] DROP CONSTRAINT [DF__pStyleSou__Sourc__1B558296]
END

GO

/****** Object:  Table [dbo].[pStyleSourcingBOL]    Script Date: 11/04/2011 13:12:42 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleSourcingBOL]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleSourcingBOL]
GO

/****** Object:  Table [dbo].[pStyleSourcingBOL]    Script Date: 11/04/2011 13:12:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleSourcingBOL](
	[SourceBOLId] [uniqueidentifier] NOT NULL,
	[StyleSourcingId] [uniqueidentifier] NULL,
	[ExceptionId] [uniqueidentifier] NULL,
	[PageOperationId] [uniqueidentifier] NULL,
	[IsLinked] [int] NULL,
	[OpToMacroId] [uniqueidentifier] NULL,
	[TradePartnerId] [uniqueidentifier] NULL,
	[TradeVendorId] [uniqueidentifier] NULL,
	[Adj] [numeric](6, 2) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK__pStyleSo__FA3C1AFC196D3A24] PRIMARY KEY CLUSTERED 
(
	[SourceBOLId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleSourcingBOL]  WITH CHECK ADD  CONSTRAINT [FK_pStyleSourcingBOL_pBOLOpToMacro1] FOREIGN KEY([OpToMacroId])
REFERENCES [dbo].[pBOLOpToMacro] ([OpToMacroId])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pStyleSourcingBOL] CHECK CONSTRAINT [FK_pStyleSourcingBOL_pBOLOpToMacro1]
GO

ALTER TABLE [dbo].[pStyleSourcingBOL]  WITH CHECK ADD  CONSTRAINT [FK_pStyleSourcingBOL_pStyleBOLException] FOREIGN KEY([ExceptionId])
REFERENCES [dbo].[pStyleBOLException] ([BOLExceptionId])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pStyleSourcingBOL] CHECK CONSTRAINT [FK_pStyleSourcingBOL_pStyleBOLException]
GO

ALTER TABLE [dbo].[pStyleSourcingBOL]  WITH CHECK ADD  CONSTRAINT [FK_pStyleSourcingBOL_pStyleBOLPageOperations] FOREIGN KEY([PageOperationId])
REFERENCES [dbo].[pStyleBOLPageOperations] ([PageOperationId])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[pStyleSourcingBOL] CHECK CONSTRAINT [FK_pStyleSourcingBOL_pStyleBOLPageOperations]
GO

ALTER TABLE [dbo].[pStyleSourcingBOL] ADD  CONSTRAINT [DF__pStyleSou__Sourc__1B558296]  DEFAULT (newid()) FOR [SourceBOLId]
GO


IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02120'))
	BEGIN
		INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
		VALUES ('DB_Version', '4.1.0000', '02120', GetDate())
	END
GO