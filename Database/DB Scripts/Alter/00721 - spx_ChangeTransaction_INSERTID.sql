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

INSERT INTO pChangeTransaction (
				ChangeTransPageName,
				ChangeTransTableID,
				ChangeTransTablePKID,
				ChangeTransUserID,
				ChangeTransDate,
				ChangeTransTypeID)
OUTPUT inserted.ChangeTransID	
VALUES
				(@ChangeTransPageName,
				@ChangeTransTableID,
				@ChangeTransTablePKID,
				@ChangeTransUserID,
				@ChangeTransDate,
				@ChangeTransTypeID )



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '721', GetDate())
GO
