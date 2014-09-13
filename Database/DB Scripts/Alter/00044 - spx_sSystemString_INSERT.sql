/*
--***
--***
*/


IF EXISTS (select * from sysobjects where id = object_id('spx_sSystemString_INSERT') and sysstat & 0xf = 4)
	drop procedure spx_sSystemString_INSERT
GO

CREATE PROCEDURE [spx_sSystemString_INSERT] (
@DesignString nvarchar(4000),
@DesignFormXML varchar(500),
@IsUserString bit
)
AS 

DECLARE @DesignStringID UNIQUEIDENTIFIER

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
GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '044', GetDate())
GO