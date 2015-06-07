TRUNCATE TABLE sSystemPageStrings;
TRUNCATE TABLE sUserXMLStrings;
TRUNCATE TABLE sUserDropDownXMLStrings;
GO

IF OBJECT_ID('spx_sSystemString_INSERT', 'P') IS NOT NULL
	DROP PROCEDURE spx_sSystemString_INSERT;
GO

CREATE PROCEDURE [dbo].[spx_sSystemString_INSERT]
	(
	  @DesignString NVARCHAR(4000) ,
	  @DesignFormXML nVARCHAR(500) ,
	  @IsUserString BIT ,
	  @IsDropDownListDataString BIT = 0
	)
AS 
DECLARE @DesignStringID UNIQUEIDENTIFIER

IF @IsDropDownListDataString = 1 
BEGIN
	IF NOT EXISTS ( SELECT  *
					FROM    sUserDropDownStrings
					WHERE   DesignString = @DesignString ) 
		BEGIN
			INSERT  INTO sUserDropDownStrings
					( DesignString )
			VALUES  ( @DesignString )
		END
		  
	SELECT  @DesignStringID = UserDropDownStringID 
	FROM    sUserDropDownStrings
	WHERE   DesignString = @DesignString
	IF NOT EXISTS ( SELECT  *
					FROM    dbo.sUserDropDownXMLStrings
					WHERE   XMLName = @DesignFormXML
							AND UserDropDownStringID = @DesignStringID ) 
		BEGIN
			INSERT  INTO sUserDropDownXMLStrings
					( XMLName, UserDropDownStringID )
			VALUES  ( @DesignFormXML, @DesignStringID )
		END

END
ELSE 
BEGIN
	IF @IsUserString = 1 
		BEGIN
			IF NOT EXISTS ( SELECT  *
							FROM    sUserStrings
							WHERE   DesignString = @DesignString ) 
				BEGIN
					INSERT  INTO sUserStrings
							( DesignString )
					VALUES  ( @DesignString )
				END
				
			SELECT  @DesignStringID = UserStringID
			FROM    sUserStrings
			WHERE   DesignString = @DesignString
			IF NOT EXISTS ( SELECT  *
							FROM    dbo.sUserXMLStrings
							WHERE   XMLName = @DesignFormXML
									AND UserStringID = @DesignStringID ) 
				BEGIN
					INSERT  INTO sUserXMLStrings
							( XMLName, UserStringID )
					VALUES  ( @DesignFormXML, @DesignStringID )
				END

		END
	ELSE 
		BEGIN
			IF NOT EXISTS ( SELECT  SystemStringID
							FROM    sSystemStrings
							WHERE   DesignString = @DesignString ) 
				BEGIN
					INSERT  INTO sSystemStrings
							( DesignString )
					VALUES  ( @DesignString )
				END

			SELECT  @DesignStringID = SystemStringID
			FROM    sSystemStrings
			WHERE   DesignString = @DesignString
			IF NOT EXISTS ( SELECT  sSystemPageString
							FROM    dbo.sSystemPageStrings
							WHERE   FormName = @DesignFormXML
									AND SystemStringID = @DesignStringID ) 
				BEGIN
					INSERT  INTO sSystemPageStrings
							( FormName, SystemStringID )
					VALUES  ( @DesignFormXML, @DesignStringID )	
				END

		END
END
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '09157', GetDate())
GO
