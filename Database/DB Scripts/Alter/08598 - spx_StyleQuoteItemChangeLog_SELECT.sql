/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItemChangeLog_SELECT]    Script Date: 08/06/2014 19:18:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItemChangeLog_SELECT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteItemChangeLog_SELECT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItemChangeLog_SELECT]    Script Date: 08/06/2014 19:18:17 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_StyleQuoteItemChangeLog_SELECT]
	@StyleQuoteItemID UNIQUEIDENTIFIER
AS
BEGIN
	SELECT sqic.StyleQuoteItemChangeID, sqic.StyleQuoteItemChangeNo, sqic.StyleQuoteItemChangeType, 
		'*By ' + sqic.StyleQuoteItemChangeBy + ' @ ' 
		+ CONVERT(NVARCHAR(100), sqic.StyleQuoteItemChangeDate , 101 ) + '<br />' 
		+ ISNULL(sqic.StyleQuoteItemChangeDescription,'') AS StyleQuoteItemChangeDescription,
		CASE WHEN sqic.Active = 1  
			THEN '<img src="../System/Icons/icon_ball_green_flash.gif" alt="" />'
			ELSE '<img src="../System/Icons/icon_ball_gray.gif" alt="" />'
		END AS Icon, 
		sqic.StyleQuoteItemChangeNotifyTo, sqic.StyleQuoteItemChangeBy, sqic.StyleQuoteItemChangeDate
	FROM pStyleQuoteItemChange sqic WITH(NOLOCK)
	WHERE sqic.StyleQuoteItemID = @StyleQuoteItemID
	ORDER BY sqic.StyleQuoteItemChangeNo DESC
END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08598', GetDate())
GO
