IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pTradePartnerAccessType]') AND type in (N'U'))
DROP TABLE [dbo].[pTradePartnerAccessType]
GO

CREATE TABLE [dbo].[pTradePartnerAccessType](
	[PartnerAccessTypeID] [int] NOT NULL,
	[PartnerAccessTypeDesr] [nvarchar](200) NULL,
	[PartnerAccessTypeOrder] [int] NULL,
	[CUser] [nvarchar](200) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](200) NULL,
	[MDate] [datetime] NULL,
	[Active] [int] NULL,
 CONSTRAINT [PK_pTradePartnerAccessType] PRIMARY KEY CLUSTERED 
(
	[PartnerAccessTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0000', '06586', GetDate())
GO
