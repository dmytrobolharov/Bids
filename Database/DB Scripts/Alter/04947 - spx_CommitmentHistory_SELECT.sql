/****** Object:  StoredProcedure [dbo].[spx_CommitmentHistory_SELECT]    Script Date: 01/31/2013 15:51:56 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_CommitmentHistory_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_CommitmentHistory_SELECT]
GO
/****** Object:  StoredProcedure [dbo].[spx_CommitmentHistory_SELECT]    Script Date: 01/31/2013 15:51:56 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[spx_CommitmentHistory_SELECT]
(@TeamId uniqueidentifier)
AS 

SELECT  pSourcingCommitmentItem.SourcingCommitmentItemID, pStyleHeader.StyleID, pStyleHeader.StyleNo, pStyleHeader.Description, pSourcingCommitmentItem.StyleQuoteItemStatusId, 
      pSourcingCommitmentItem.StyleCommitmentNo, hCommitmentHistory.CDate,
      pStyleQuoteItem.StyleQuoteItemID, pStyleQuoteItem.TradePartnerID, pStyleQuoteItem.TradePartnerVendorID,pStyleQuoteItem.StyleSourcingID, pstylequoteitem.StyleDevelopmentID
FROM  pSourcingCommitmentItem WITH (NOLOCK) INNER JOIN
		pStyleQuoteItem on pSourcingCommitmentItem.StyleQuoteItemID = pStyleQuoteItem.StyleQuoteItemID inner join
      pStyleHeader WITH (NOLOCK) ON pSourcingCommitmentItem.StyleID = pStyleHeader.StyleID INNER JOIN
      hCommitmentHistory WITH (NOLOCK) ON pSourcingCommitmentItem.SourcingCommitmentItemID = hCommitmentHistory.CommitmentItemId
WHERE hCommitmentHistory.StyleId IN (SELECT StyleId FROM hCommitmentHistory WITH (NOLOCK) WHERE TeamID = @TeamID) 
ORDER BY hCommitmentHistory.CDate DESC


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '5.0.0000', '04947', GetDate())
GO