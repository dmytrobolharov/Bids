IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_ChangeTransaction_INSERTID]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_ChangeTransaction_INSERTID]
GO

CREATE PROCEDURE [dbo].[spx_ChangeTransaction_INSERTID] (
	@ChangeTransPageName VARCHAR(200),
	@ChangeTransTableID UNIQUEIDENTIFIER,
	@ChangeTransTablePKID VARCHAR(200),
	@ChangeTransUserID UNIQUEIDENTIFIER,
	@ChangeTransDate DATETIME,
	@ChangeTransTypeID INT
)
AS


DECLARE @ChangeTransID UNIQUEIDENTIFIER 

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

SET @ChangeTransID = NEWID()

INSERT INTO pChangeTransaction ( 
				ChangeTransID,
				ChangeTransPageName,
				ChangeTransTableID,
				ChangeTransTablePKID,
				ChangeTransUserID,
				ChangeTransDate,
				ChangeTransTypeID)
VALUES(
				@ChangeTransID,
				@ChangeTransPageName,
				@ChangeTransTableID,
				@ChangeTransTablePKID,
				@ChangeTransUserID,
				@ChangeTransDate,
				@ChangeTransTypeID )

SELECT @ChangeTransID AS ChangeTransID




