IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_sSystemString_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_sSystemString_INSERT]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[spx_sSystemString_INSERT] (
@DesignString nvarchar(4000),
@DesignFormXML varchar(500),
@IsUserString bit,
@IsDropDownListDataString bit = 0
)
AS 

DECLARE @DesignStringID UNIQUEIDENTIFIER

if @IsDropDownListDataString = 1
	BEGIN
	IF (SELECT COUNT(*) FROM sUserDropDownStrings WHERE DesignString = @DesignString) = 0
	BEGIN
		INSERT INTO sUserDropDownStrings (DesignString) VALUES (@DesignString)
	END

	SELECT @DesignStringID = UserDropDownStringID FROM sUserDropDownStrings WHERE DesignString = @DesignString
	INSERT INTO sUserDropDownXMLStrings (XMLName, UserDropDownStringID) VALUES (@DesignFormXML, @DesignStringID)
	END
ELSE
	BEGIN
		If @IsUserString = 1
			BEGIN
				IF (SELECT COUNT(*) FROM sUserStrings WHERE DesignString = @DesignString) = 0
				BEGIN
					INSERT INTO sUserStrings (DesignString) VALUES (@DesignString)
				END
				
				SELECT @DesignStringID = UserStringID FROM sUserStrings WHERE DesignString = @DesignString
				INSERT INTO sUserXMLStrings (XMLName, UserStringID) VALUES (@DesignFormXML, @DesignStringID)

			END
		ELSE
			BEGIN
				IF (SELECT COUNT(*) FROM sSystemStrings WHERE DesignString = @DesignString) = 0
				BEGIN
					INSERT INTO sSystemStrings (DesignString) VALUES (@DesignString)
				END

				SELECT @DesignStringID = SystemStringID FROM sSystemStrings WHERE DesignString = @DesignString
				INSERT INTO sSystemPageStrings (FormName, SystemStringID) VALUES (@DesignFormXML, @DesignStringID)

			END
	END


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '0.5.0.0000', '05663', GetDate())
GO
