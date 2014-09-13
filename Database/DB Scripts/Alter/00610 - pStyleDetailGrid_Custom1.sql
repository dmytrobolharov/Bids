/****** Object:  Table [dbo].[pStyleDetailGrid_Custom1]    Script Date: 10/20/2010 14:18:12 ******/
CREATE TABLE [dbo].[pStyleDetailGrid_Custom1](
	[StyleDetailGridID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_pStyleDetailGrid_Custom1_StyleDetailGridID]  DEFAULT (newid()),
	[StyleID] [uniqueidentifier] NULL,
	[StyleSet] [int] NULL,
	[TemplateDetailGridID] [uniqueidentifier] NULL,
	[TemplateDetailGridItemID] [uniqueidentifier] NULL,
	[StyleDetailCustom] [nvarchar](200)  NULL,
	[StyleDetailCustom1] [nvarchar](200)  NULL,
	[StyleDetailCustom2] [nvarchar](200)  NULL,
	[StyleDetailCustom3] [nvarchar](200)  NULL,
	[StyleDetailCustom4] [nvarchar](200)  NULL,
	[StyleDetailCustom5] [nvarchar](200)  NULL,
	[StyleDetailCustom6] [nvarchar](200)  NULL,
	[StyleDetailCustom7] [nvarchar](200)  NULL,
	[StyleDetailCustom8] [nvarchar](200)  NULL,
	[StyleDetailCustom9] [nvarchar](200)  NULL,
	[StyleDetailCustom10] [nvarchar](200)  NULL,
	[StyleDetailCustom11] [nvarchar](200)  NULL,
	[StyleDetailCustom12] [nvarchar](200) NULL,
	[StyleDetailCustom13] [nvarchar](200)  NULL,
	[StyleDetailCustom14] [nvarchar](200)  NULL,
	[StyleDetailCustom15] [nvarchar](200)  NULL,
	[StyleDetailCustom16] [nvarchar](200)  NULL,
	[StyleDetailCustom17] [nvarchar](200)  NULL,
	[StyleDetailCustom18] [nvarchar](200)  NULL,
	[StyleDetailCustom19] [nvarchar](200)  NULL,
	[StyleDetailCustom20] [nvarchar](200)  NULL,
	[StyleDetailCustom21] [nvarchar](200)  NULL,
	[StyleDetailCustom22] [nvarchar](200)  NULL,
	[StyleDetailCustom23] [nvarchar](200)  NULL,
	[StyleDetailCustom24] [nvarchar](200)  NULL,
	[StyleDetailCustom25] [nvarchar](200)  NULL,
	[CUser] [nvarchar](200)  NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200)  NULL,
	[MDate] [datetime] NULL,
	[Sort] [varchar](5)  NULL,
	[SizeHomeID] [varchar](10)  NULL,
 CONSTRAINT [PK_pStyleDetailGrid_Custom1] PRIMARY KEY CLUSTERED 
(
	[StyleDetailGridID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '610', GetDate())
GO