IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleImage_Linked_UPDATE]') AND type = N'P' )
	DROP PROCEDURE [dbo].[spx_StyleImage_Linked_UPDATE]
GO

CREATE PROCEDURE dbo.spx_StyleImage_Linked_UPDATE (
	@StyleID UNIQUEIDENTIFIER,
	@ImageID UNIQUEIDENTIFIER, 
	@ImageVersion INT,
	@TeamID UNIQUEIDENTIFIER,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS


DECLARE 
	@StyleLinkID UNIQUEIDENTIFIER,
	@StyleNonApparel INT
	

SELECT @StyleLinkID = a.StyleLinkID, @StyleNonApparel = b.StyleNonApparel
FROM dbo.pStyleHeader a
	INNER JOIN	dbo.pStyleType b ON a.StyleType =  b.StyleTypeID
WHERE StyleID =  @StyleID

IF @StyleLinkID IS NOT NULL AND @StyleNonApparel = 0
BEGIN
	UPDATE dbo.pStyleHeader
	SET DesignSketchID = @ImageID, DesignSketchVersion = @ImageVersion,
	MUser = @MUser, MDate = @MDate
	WHERE StyleLinkID = @StyleLinkID
END 
ELSE 
BEGIN

	UPDATE dbo.pStyleHeader
	SET DesignSketchID = @ImageID, DesignSketchVersion = @ImageVersion,
	MUser = @MUser, MDate = @MDate
	WHERE StyleID = @StyleID

END 


GO		

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '4.0.0000', '01142', GetDate())
GO