IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sOverrideVWX_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_sOverrideVWX_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_sOverrideVWX_INSERT] (
@OriginalVWX nvarchar(256),
@FormName varchar(256),
@Override varchar(256)
)
AS 

DECLARE @DesignStringID UNIQUEIDENTIFIER

	BEGIN
		IF (SELECT COUNT(*) FROM sOverrideVWX WHERE OriginalVWX = @OriginalVWX) = 0
		BEGIN
			INSERT INTO sOverrideVWX (OriginalVWX, FormName, [Override]) VALUES (@OriginalVWX, @FormName, @Override)
		END

	END

GO


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sOverrideSPX_INSERT]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_sOverrideSPX_INSERT]
GO

CREATE PROCEDURE [dbo].[spx_sOverrideSPX_INSERT] (
@OriginalSPX nvarchar(256),
@FormName varchar(256),
@Override varchar(256)
)
AS 

DECLARE @DesignStringID UNIQUEIDENTIFIER

	BEGIN
		IF (SELECT COUNT(*) FROM sOverrideSPX WHERE OriginalSPX = @OriginalSPX) = 0
		BEGIN
			INSERT INTO sOverrideSPX (OriginalSPX, FormName, [Override]) VALUES (@OriginalSPX, @FormName, @Override)
		END

	END


GO


INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01226', GetDate())
GO
