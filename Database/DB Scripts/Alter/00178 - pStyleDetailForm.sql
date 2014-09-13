
/****** Object:  Table [dbo].[pStyleDetailForm]    Script Date: 06/21/2010 16:32:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[pStyleDetailForm](
	[StyleDetailFormID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pStyleDetailForm_StyleDetailFormID]  DEFAULT (newid()),
	[StyleDetailFormMasterID] [uniqueidentifier] NULL,
	[StyleDetailFormGroupID] [uniqueidentifier] NULL,
	[WorkflowID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pStyleDetailForm_WorkflowID]  DEFAULT ('{00000000-0000-0000-0000-000000000000}'),
	[StyleID] [uniqueidentifier] NULL,
	[Comments] [nvarchar](2000) NULL,
	[StyleSet] [int] NULL,
	[ImageID] [uniqueidentifier] NULL,
	[ImageVersion] [int] NULL,
	[Sort] [nvarchar](5) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[StyleImageLinked] [int] NOT NULL CONSTRAINT [DF_pStyleDetailForm_StyleImageLinked]  DEFAULT ((1)),
 CONSTRAINT [PK_pStyleDetailForm] PRIMARY KEY CLUSTERED 
(
	[StyleDetailFormID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
