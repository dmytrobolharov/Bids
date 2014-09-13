/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteHistory_SELECT]    Script Date: 02/08/2013 11:19:15 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteHistory_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteHistory_SELECT]    Script Date: 02/08/2013 11:19:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[spx_StyleQuoteHistory_SELECT]
(@TeamId uniqueidentifier)
AS 

SELECT  pStyleQuoteItem.StyleQuoteItemID, pStyleHeader.StyleID, pStyleHeader.StyleNo, pStyleHeader.Description, pStyleQuoteItem.StyleQuoteItemStatusId, 
      pStyleQuoteItem.StyleQuoteItemNo, hStyleQuoteHistory.CDate
FROM  pStyleQuoteItem WITH (NOLOCK) INNER JOIN
      pStyleHeader WITH (NOLOCK) ON pStyleQuoteItem.StyleID = pStyleHeader.StyleID INNER JOIN
      hStyleQuoteHistory WITH (NOLOCK) ON pStyleQuoteItem.StyleQuoteItemID = hStyleQuoteHistory.StyleQuoteItemId
WHERE hStyleQuoteHistory.TeamId = @TeamId --StyleId IN (SELECT StyleId FROM hStyleQuoteHistory WITH (NOLOCK) WHERE TeamID = @TeamID) 
ORDER BY hStyleQuoteHistory.CDate DESC

GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '05005', GetDate())
GO