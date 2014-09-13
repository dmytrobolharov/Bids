IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'pGRProduct' )
   BEGIN
        DROP TABLE pGRProduct
   END
GO


SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [pGRProduct](
	[ProductID] [uniqueidentifier] NOT NULL,
	[CompanyGuidID] [uniqueidentifier] NULL,
	[GarmentId] [int] NULL,
	[Product] [nvarchar](100) NOT NULL,
	[CompanyId] [int] NULL,
	[CUser] [nvarchar](25) NULL,
	[CDate] [datetime] NULL,
	[MUser] [nvarchar](25) NULL,
	[MDate] [datetime] NULL,
 CONSTRAINT [PK_pGRProduct] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[pGRProduct] ADD  CONSTRAINT [DF_pGRProductProductId]  DEFAULT (newid()) FOR [ProductID]
GO

IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = N'pGRGarment' )
   BEGIN
        INSERT INTO pGRProduct (
	                        [ProductID]       ,
	                        [CompanyGuidID]   ,
	                        [GarmentId]       ,
	                        [Product]         ,
	                        [CompanyId]       ,
	                        [CUser]           ,
	                        [CDate]           ,
	                        [Muser]           ,
	                        [MDate]           )
        SELECT [GarmentGuidID]
              ,[CompanyGuidID]
              ,[GarmentId]
              ,[Garment]
              ,[CompanyId]
              ,[CUser]
              ,[CDate]
              ,[Muser]
              ,[MDate]
          FROM [pGRGarment]

        DROP TABLE pGRGarment
               
   END
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '3.0.0000', '676', GetDate())
GO

