IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuote_DELETE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuote_DELETE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuote_DELETE]    Script Date: 04/01/2011 16:33:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[spx_StyleQuote_DELETE](@StyleQuoteID uniqueidentifier)
AS 
DELETE FROM dbo.pStyleQuote
WHERE     (StyleQuoteID = @StyleQuoteID)
DELETE FROM dbo.pStyleQuoteitem
WHERE     (StyleQuoteID = @StyleQuoteID)
DELETE FROM dbo.pStyleQuoteVariation
WHERE     (StyleQuoteID = @StyleQuoteID)

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01345', GetDate())
GO
