IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ShareStatus_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ShareStatus_UPDATE]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_ShareStatus_UPDATE]
(
@QuoteItemID uniqueidentifier,
@MUser nvarchar(200),
@MDate datetime
)
AS 

BEGIN
	UPDATE pStyleQuoteItem
	   SET 
		  StyleQuoteItemShare = 1,
		  MDate = @MDate, 
		  MUser = @MUser
	 WHERE StyleQuoteItemID = @QuoteItemID
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04227', GetDate())
GO
