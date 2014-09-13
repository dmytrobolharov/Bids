/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItemChange_INSERT]    Script Date: 08/06/2014 19:34:34 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleQuoteItemChange_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleQuoteItemChange_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleQuoteItemChange_INSERT]    Script Date: 08/06/2014 19:34:34 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_StyleQuoteItemChange_INSERT](
	  @ActiveID UNIQUEIDENTIFIER
	, @ChangeID UNIQUEIDENTIFIER
	, @StyleQuoteItemID UNIQUEIDENTIFIER
	, @StyleQuoteItemStatus BIT
	, @StyleQuoteItemChangeNotifyTo NVARCHAR(4000)
	, @StyleQuoteItemChangeType NVARCHAR(100)
	, @StyleQuoteItemChangeDescription NVARCHAR(4000)
	, @ChangeBy NVARCHAR(200)
	, @ChangeDate DATETIME)
AS 

	DECLARE @NoOfChange INT

	SELECT @NoOfChange = COUNT(*)
	FROM pColorFolderChange WITH (NOLOCK)
	WHERE ColorFolderChangeID = @ChangeID

	IF @NoOfChange = 0
		INSERT INTO pStyleQuoteItemChange (
			  ActiveID
			, StyleQuoteItemChangeID
			, StyleQuoteItemID
			, StyleQuoteItemChangeNotifyTo
			, StyleQuoteItemChangeType
			, StyleQuoteItemChangeDescription
			, StyleQuoteItemChangeBy
			, StyleQuoteItemChangeDate
			, StyleQuoteItemStatus)
		VALUES (
			  @ActiveID
			, @ChangeID
			, @StyleQuoteItemID
			, @StyleQuoteItemChangeNotifyTo
			, @StyleQuoteItemChangeType
			, @StyleQuoteItemChangeDescription
			, @ChangeBy
			, @ChangeDate
			, @StyleQuoteItemStatus)		
	ELSE
		UPDATE pStyleQuoteItemChange
		SET ActiveID = @ActiveID
			, StyleQuoteItemStatus = @StyleQuoteItemStatus
			, StyleQuoteItemChangeNotifyTo = @StyleQuoteItemChangeNotifyTo
			, StyleQuoteItemChangeType = @StyleQuoteItemChangeType
			, StyleQuoteItemChangeDescription = @StyleQuoteItemChangeDescription
			, StyleQuoteItemChangeBy = @ChangeBy
			, StyleQuoteItemChangeDate = @ChangeDate
		WHERE StyleQuoteItemChangeID = @ChangeID

	





GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '0.5.0000', '08597', GetDate())
GO
