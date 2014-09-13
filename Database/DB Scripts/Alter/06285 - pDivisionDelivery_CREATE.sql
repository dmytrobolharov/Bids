IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'DF_pDivisionDelivery_DivisionDeliveryID') AND type = 'D')
ALTER TABLE dbo.pDivisionDelivery DROP CONSTRAINT DF_pDivisionDelivery_DivisionDeliveryID
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.pDivisionDelivery') AND type in (N'U'))
DROP TABLE dbo.pDivisionDelivery
GO

CREATE TABLE [dbo].[pDivisionDelivery](
	[DivisionDeliveryID] [uniqueidentifier] NOT NULL,
	[DeliveryID] [uniqueidentifier] NOT NULL,
	[DivisionID] [uniqueidentifier] NOT NULL,
	[DivisionActive] [bit] NOT NULL,
 CONSTRAINT [PK_pDivisionDelivery] PRIMARY KEY CLUSTERED 
(
	[DivisionDeliveryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pDivisionDelivery] ADD  CONSTRAINT [DF_pDivisionDelivery_DivisionDeliveryID]  DEFAULT (newid()) FOR [DivisionDeliveryID]
GO

ALTER TABLE [dbo].[pDivisionDelivery] ADD  CONSTRAINT [DF_pDivisionDelivery_DivisionActive]  DEFAULT (0) FOR [DivisionActive]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06285', GetDate())
GO
