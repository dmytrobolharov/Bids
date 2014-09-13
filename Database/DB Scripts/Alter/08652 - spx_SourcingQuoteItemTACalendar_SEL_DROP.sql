/****** Object:  StoredProcedure [dbo].[spx_SourcingQuoteItemTACalendar_SEL]    Script Date: 08/08/2014 17:01:18 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_SourcingQuoteItemTACalendar_SEL]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_SourcingQuoteItemTACalendar_SEL]
GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08652', GetDate())
GO

