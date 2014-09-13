/****** Object:  StoredProcedure [dbo].[spx_ChangeTransaction_INSERTID]    Script Date: 07/23/2012 14:50:01 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeTransaction_INSERTID]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_ChangeTransaction_INSERTID]
GO

/****** Object:  StoredProcedure [dbo].[spx_ChangeTransaction_INSERTID]    Script Date: 07/23/2012 14:50:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[spx_ChangeTransaction_INSERTID] (
	@ChangeTransPageName VARCHAR(200),
	@ChangeTransTableID UNIQUEIDENTIFIER,
	@ChangeSessionID UNIQUEIDENTIFIER = NULL,
	@ChangeTransTablePKID VARCHAR(200),
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@ChangeTransDate DATETIME,
	@ChangeTransTypeID INT
)
AS


DECLARE @ChangeTransID UNIQUEIDENTIFIER,
		@ChangeSessionNo BIGINT;

/*************************************************************************
IF CAST(@ChangeTransTableID AS NVARCHAR(40)) = 'D612FAAE-7ACD-DF11-AF06-005056C00008'  -- StyleTransaction
BEGIN
	--** @ChangeTransTablePKID = StyleID
	IF NOT EXISTS ( SELECT  * FROM dbo.pStyleHeader a
			INNER JOIN dbo.pTechPack b ON a.TechPackId =  b.TechPackID
			WHERE a.StyleID = @ChangeTransTablePKID
	)
	BEGIN
		SELECT '00000000-0000-0000-0000-000000000000' AS ChangeTransID 
		RETURN 
	END 	
END 
**************************************************************************/

SET @ChangeTransID = NEWID()

IF @ChangeSessionID IS NOT NULL
BEGIN
	-- get number of current session
	SELECT @ChangeSessionNo = ChangeSessionNo FROM pChangeTransaction WHERE ChangeSessionID = @ChangeSessionID
	-- or generate new one
	IF @ChangeSessionNo IS NULL
	BEGIN
		SELECT @ChangeSessionNo = ISNULL(MAX(ChangeSessionNo), 0) + 1 FROM pChangeTransaction
	END
END

INSERT INTO pChangeTransaction ( 
				ChangeTransID,
				ChangeTransPageName,
				ChangeTransTableID,
				ChangeSessionID,
				ChangeTransTablePKID,
				ChangeTransUserID,
				ChangeTransDate,
				ChangeTransTypeID,
				ChangeSessionNo)
VALUES(
				@ChangeTransID,
				@ChangeTransPageName,
				@ChangeTransTableID,
				@ChangeSessionID,
				@ChangeTransTablePKID,
				@ChangeTransUserID,
				@ChangeTransDate,
				@ChangeTransTypeID,
				@ChangeSessionNo)

SELECT @ChangeTransID AS ChangeTransID

GO




INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '5.0.0000', '03707', GetDate())
GO