/****** Object:  StoredProcedure [dbo].[spx_StyleDocumentActivity_INSERT]    Script Date: 02/07/2013 17:15:31 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleDocumentActivity_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleDocumentActivity_INSERT]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleDocumentActivity_INSERT]    Script Date: 02/07/2013 17:15:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[spx_StyleDocumentActivity_INSERT]
(@StyleDocumentId uniqueidentifier,
@StyleId uniqueidentifier,
@TeamId uniqueidentifier,
@CDate datetime,
@CUser nvarchar(150),
@StyleDocumentActivity nvarchar(4000),
@ActivityType nvarchar(2))
AS 


IF @StyleDocumentActivity <> ''
	BEGIN
	IF (SELECT COUNT(*) FROM  pStyleDocumentActivity WITH (NOLOCK) WHERE  CONVERT(varchar(10),CDATE,101) = CONVERT(varchar(10),GETDATE(),101) AND TeamId = @TeamId AND ActivityType = @ActivityType AND StyleDocumentID = @StyleDocumentId) <> 0
		IF	@ActivityType <> 'V'
		 UPDATE pStyleDocumentActivity SET CDATE = GETDATE() WHERE TeamId = @TeamId AND TeamId = @TeamId AND ActivityType = @ActivityType AND StyleDocumentID = @StyleDocumentId	
		ELSE
		SELECT 1	
	ELSE
		INSERT INTO pStyleDocumentActivity
			(StyleDocumentID, StyleID, TeamID, TradePartner, CDate, CUser, ActivityType, StyleDocumentActivity)
		VALUES (@StyleDocumentId, @StyleId, @TeamId, 0, @CDate, @CUser, @ActivityType, @StyleDocumentActivity)
	END

GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '04999', GetDate())
GO
