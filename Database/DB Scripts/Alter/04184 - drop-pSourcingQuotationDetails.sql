
IF  EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_pSourcingQuotationDetails_SourcingQuotationDetailsID]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[pSourcingQuotationDetails] DROP CONSTRAINT [DF_pSourcingQuotationDetails_SourcingQuotationDetailsID]
END

GO


/****** Object:  Table [dbo].[pSourcingQuotationDetails]    Script Date: 10/15/2012 10:57:35 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pSourcingQuotationDetails]') AND type in (N'U'))
DROP TABLE [dbo].[pSourcingQuotationDetails]
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04184', GetDate())
GO
