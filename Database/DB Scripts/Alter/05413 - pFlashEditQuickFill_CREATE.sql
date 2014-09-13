IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pFlashEditQuickFill_Active]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pFlashEditQuickFill] DROP CONSTRAINT [DF_pFlashEditQuickFill_Active]
END

GO

/****** Object:  Table [dbo].[pFlashEditQuickFill]    Script Date: 03/27/2013 11:43:29 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pFlashEditQuickFill]') AND type in (N'U'))
DROP TABLE [dbo].[pFlashEditQuickFill]
GO


/****** Object:  Table [dbo].[pFlashEditQuickFill]    Script Date: 03/27/2013 11:43:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pFlashEditQuickFill](
	[QuickFillID] [uniqueidentifier] NOT NULL,
	[QuickFillName] [nvarchar](200) NULL,
	[QuickFillDescription] [nvarchar](200) NULL,
	[Active] [int] NULL,
	[StyleTypeID] [int] NULL,
	[StyleCategoryID] [uniqueidentifier] NULL,
	[TeamID] [uniqueidentifier] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pFlashEditQuickFill] PRIMARY KEY CLUSTERED 
(
	[QuickFillID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pFlashEditQuickFill] ADD  CONSTRAINT [DF_pFlashEditQuickFill_Active]  DEFAULT ((1)) FOR [Active]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '05413', GetDate())
GO
