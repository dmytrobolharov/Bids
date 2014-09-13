

/****** Object:  Table [dbo].[pImageWFValidation]    Script Date: 02/01/2012 15:41:57 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[pImageWFValidation](
	[CustomID] [uniqueidentifier] NOT NULL,
	[WorkflowID] [uniqueidentifier] NOT NULL,
	[CustomKey] [nvarchar](200) NULL,
	[Min] [nvarchar](5) NULL,
	[Max] [nvarchar](5) NULL,
	[ByColorway] BIT NULL,
	[ByArtwork] BIT NULL,
	[plmOn] BIT NULL,
	[srmOn] BIT NULL,
	[Sort] [nvarchar](5) NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,	
 CONSTRAINT [PK_pImageWFValidation] PRIMARY KEY CLUSTERED 
(
	[CustomID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pImageWFValidation] ADD  CONSTRAINT [DF_pImageWFValidation_CustomID]  DEFAULT (newid()) FOR [CustomID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03171', GetDate())

GO


