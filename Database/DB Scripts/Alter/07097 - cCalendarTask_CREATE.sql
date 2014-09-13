IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[cCalendarTask]') AND type in (N'U'))
DROP TABLE [dbo].[cCalendarTask]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[cCalendarTask](
	[TaskID] [uniqueidentifier] NOT NULL,
	[TaskCode] [int] IDENTITY(1,1) NOT NULL,
	[TaskName] [nvarchar](100) NULL,
	[TaskDescription] [nvarchar](400) NULL,
	[Active] [int] NULL,
	[CUser] [nvarchar](50) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](50) NULL,
	[MDate] [datetime] NULL,
	[Sort] [nvarchar](5) NULL,
 CONSTRAINT [PK_cCalendarTask] PRIMARY KEY CLUSTERED 
(
	[TaskID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[cCalendarTask] ADD  CONSTRAINT [DF_Table_1_CustomID]  DEFAULT (newid()) FOR [TaskID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '07097', GetDate())
GO
