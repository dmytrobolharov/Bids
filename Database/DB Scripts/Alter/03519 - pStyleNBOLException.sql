IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pStyleNBOLException_ExceptionID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pStyleNBOLException] DROP CONSTRAINT [DF_pStyleNBOLException_ExceptionID]
END

GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pStyleNBOLException]') AND type in (N'U'))
DROP TABLE [dbo].[pStyleNBOLException]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pStyleNBOLException](
	[ExceptionID] [uniqueidentifier] NOT NULL,
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[WorkflowID] [uniqueidentifier] NULL,
	[WorkflowItemID] [uniqueidentifier] NULL,
	[ExceptionName] [nvarchar](200) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
	[Sort] [nvarchar](5) NULL,
 CONSTRAINT [PK_pStyleNBOLException] PRIMARY KEY CLUSTERED 
(
	[ExceptionID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pStyleNBOLException] ADD  CONSTRAINT [DF_pStyleNBOLException_ExceptionID]  DEFAULT (newid()) FOR [ExceptionID]
GO



INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03519', GetDate())
GO