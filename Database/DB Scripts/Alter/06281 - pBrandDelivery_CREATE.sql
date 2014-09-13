IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'DF_pBrandDelivery_BrandDeliveryID') AND type = 'D')
ALTER TABLE dbo.pBrandDelivery DROP CONSTRAINT DF_pBrandDelivery_BrandDeliveryID
GO

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.pBrandDelivery') AND type in (N'U'))
DROP TABLE dbo.pBrandDelivery
GO

CREATE TABLE [dbo].[pBrandDelivery](
	[BrandDeliveryID] [uniqueidentifier] NOT NULL,
	[DeliveryID] [uniqueidentifier] NOT NULL,
	[BrandID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_pBrandDelivery] PRIMARY KEY CLUSTERED 
(
	[BrandDeliveryID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[pBrandDelivery] ADD  CONSTRAINT [DF_pBrandDelivery_BrandDeliveryID]  DEFAULT (newid()) FOR [BrandDeliveryID]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '06281', GetDate())
GO
