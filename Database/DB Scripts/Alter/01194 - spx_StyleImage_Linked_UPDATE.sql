



IF  EXISTS (SELECT * from INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'spx_StyleImage_Linked_UPDATE') 
DROP PROCEDURE spx_StyleImage_Linked_UPDATE
GO

CREATE PROCEDURE [dbo].[spx_StyleImage_Linked_UPDATE] (
	@StyleID UNIQUEIDENTIFIER,
	@ImageID UNIQUEIDENTIFIER, 
	@ImageVersion INT,
	@MUser NVARCHAR(200),
	@MDate DATETIME
)
AS

SELECT 1

--DECLARE 
--	@StyleLinkID UNIQUEIDENTIFIER,
--	@StyleNonApparel INT
	

--SELECT @StyleLinkID = a.StyleLinkID, @StyleNonApparel = b.StyleNonApparel
--FROM dbo.pStyleHeader a
--	INNER JOIN	dbo.pStyleType b ON a.StyleType =  b.StyleTypeID
--WHERE StyleID =  @StyleID

--IF @StyleLinkID IS NOT NULL AND @StyleNonApparel = 0
--BEGIN
--	UPDATE dbo.pStyleHeader
--	SET DesignSketchID = @ImageID, DesignSketchVersion = @ImageVersion,
--	MUser = @MUser, MDate = @MDate
--	WHERE StyleLinkID = @StyleLinkID
--END 
--ELSE 
--BEGIN

--	UPDATE dbo.pStyleHeader
--	SET DesignSketchID = @ImageID, DesignSketchVersion = @ImageVersion,
--	MUser = @MUser, MDate = @MDate
--	WHERE StyleID = @StyleID

--END 


GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '4.0.0000', '01194', GetDate())
GO