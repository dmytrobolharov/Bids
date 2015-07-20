
ALTER PROCEDURE spx_StyleColorGroupItem_UPDATE(@StyleColorGroupID uniqueidentifier,
@StyleColorID uniqueidentifier,
@StyleID uniqueidentifier,
@Quantity decimal,
@ModifiedBy nvarchar(200),
@ModifiedDate datetime,
@SeasonYearID NVARCHAR(50)= NULL)
--ALTER PROCEDURE [dbo].[spx_StyleColorGroupItem_UPDATE](@StyleColorGroupID uniqueidentifier,
--@StyleColorID uniqueidentifier,
--@StyleID uniqueidentifier,
--@Quantity decimal,
--@ModifiedDate datetime)
AS 

IF @SeasonYearID IS NOT NULL AND LEN(@SeasonYearID) > 0
UPDATE    pStyleColorGroupItem
SET              Quantity = @Quantity, 
--                 MDate = @ModifiedDate
                  MUser = @ModifiedBy, MDate = @ModifiedDate 
WHERE     (StyleColorGroupID = @StyleColorGroupID AND StyleColorID = @StyleColorID AND StyleID = @StyleID AND SeasonYearID = @SeasonYearID)
ELSE
UPDATE    pStyleColorGroupItem
SET              Quantity = @Quantity, 
--                 MDate = @ModifiedDate
                  MUser = @ModifiedBy, MDate = @ModifiedDate 
WHERE     (StyleColorGroupID = @StyleColorGroupID AND StyleColorID = @StyleColorID AND StyleID = @StyleID)



GO
/****** Object:  StoredProcedure [dbo].[spx_StyleColorGroups_PIVOT]    Script Date: 03/09/2010 10:12:58 ******/


ALTER PROCEDURE spx_StyleColorGroups_PIVOT (
@StyleID UNIQUEIDENTIFIER,
@StyleSet int,
@SeasonYearID NVARCHAR(50)= NULL
)

AS

BEGIN

--Create temp table for available colors
CREATE TABLE #tmpStyleAvailbleColor( 
	RecID						int IDENTITY(1,1)  NOT NULL,
	StyleColorID 	 	uniqueidentifier,
	StyleID 				uniqueidentifier
) ON [PRIMARY]

--Create temp table for available colorgroups
CREATE TABLE #tmpStyleAvailableColorGroup( 
	RecID						int IDENTITY(1,1)  NOT NULL,
	ColorGroupID 	 	    uniqueidentifier,
	StyleColorGroupID 	 				uniqueidentifier,
	StyleID 				uniqueidentifier
) ON [PRIMARY]


DECLARE @RowAvailbleColorLoop 			int
DECLARE @RowAvailbleColorCount 			int
DECLARE @tmpStyleColorID			uniqueidentifier

DECLARE @RowAvailableColorGroupLoop 		int
DECLARE @RowAvailableColorGroupCount 		int
DECLARE @tmpColorGroupID			uniqueidentifier
DECLARE @tmpStyleColorGroupID					uniqueidentifier

BEGIN
--Populate colors 
	INSERT INTO #tmpStyleAvailbleColor (StyleColorID, StyleID)
	SELECT StyleColorID, StyleID FROM pStyleColorway WITH (NOLOCK)
	WHERE StyleID = @StyleID 
END

BEGIN

--
--Populate colorgroups
--

  IF @SeasonYearID IS NOT NULL AND LEN(@SeasonYearID) > 0
	INSERT INTO #tmpStyleAvailableColorGroup (ColorGroupID, StyleID, StyleColorGroupID)
	SELECT ColorGroupID, StyleID, StyleColorGroupID FROM pStyleColorGroup WITH (NOLOCK)
	WHERE StyleID = @StyleID AND SeasonYearID = @SeasonYearID
  ELSE
    INSERT INTO #tmpStyleAvailableColorGroup (ColorGroupID, StyleID, StyleColorGroupID)
	SELECT ColorGroupID, StyleID, StyleColorGroupID FROM pStyleColorGroup WITH (NOLOCK)
	WHERE StyleID = @StyleID
END

SET @RowAvailbleColorLoop = 1
SET @RowAvailbleColorCount = (SELECT COUNT(*) FROM #tmpStyleAvailbleColor)

--
--Loop available colors
--

WHILE @RowAvailbleColorLoop <= @RowAvailbleColorCount 

	BEGIN
		SELECT @tmpStyleColorID = StyleColorID FROM #tmpStyleAvailbleColor WHERE RecID = @RowAvailbleColorLoop

			BEGIN	

					SET @RowAvailableColorGroupLoop = 1
					SET @RowAvailableColorGroupCount = (SELECT COUNT(*) FROM #tmpStyleAvailableColorGroup)
					--Loop available colorgroups
					WHILE @RowAvailableColorGroupLoop <= @RowAvailableColorGroupCount 
						BEGIN

							SELECT @tmpColorGroupID = ColorGroupID, @tmpStyleColorGroupID = StyleColorGroupID FROM #tmpStyleAvailableColorGroup WHERE RecID = @RowAvailableColorGroupLoop
								BEGIN	

									--Check if quantity is available on pStyleColorGroupItem for PIVOT function
									IF (SELECT COUNT(*) FROM pStyleColorGroupItem WHERE StyleColorGroupID = @tmpStyleColorGroupID AND StyleColorID = @tmpStyleColorID) = 0
									BEGIN
										--If not found create a blank insert.
										INSERT INTO pStyleColorGroupItem (StyleColorGroupID, StyleColorID, StyleID, Quantity, SeasonYearID)
										SELECT @tmpStyleColorGroupID, @tmpStyleColorID,  @StyleID, '0', @SeasonYearID
									END
								END	

							SET @RowAvailableColorGroupLoop = @RowAvailableColorGroupLoop + 1
							
						END

			END	

		SET @RowAvailbleColorLoop = @RowAvailbleColorLoop + 1
		
	END

	DROP TABLE #tmpStyleAvailbleColor
	DROP TABLE #tmpStyleAvailableColorGroup

END

BEGIN
--
--Update Quantity NULL with '0'
--

IF @SeasonYearID IS NOT NULL AND LEN(@SeasonYearID) > 0
	UPDATE pStyleColorGroupItem SET Quantity = '0' WHERE (Quantity IS NULL) AND (StyleID = @StyleID) AND SeasonYearID = @SeasonYearID
ELSE
    UPDATE pStyleColorGroupItem SET Quantity = '0' WHERE (Quantity IS NULL) AND (StyleID = @StyleID)
END


BEGIN 


CREATE TABLE #tmpStyleColorwayGroups (
Rec_ID INT IDENTITY (1,1) ,
StyleColorID UNIQUEIDENTIFIER , 
StyleID UNIQUEIDENTIFIER ,
StyleSet INT,
StyleColorNo NVARCHAR(50) , 
StyleColorName NVARCHAR(200) ,
MainColor NVARCHAR(100),
SAPCode NVARCHAR(50) , 
PLMCode NVARCHAR(200)
)

----COMMENTED TO CONVERT StyleColorID as NVARCHAR, FROM UNIQUEIDENTIFIER, AS IT DOESN'T WORK IN SQL ADD ETC. OPERATIONS
--CREATE TABLE #tmpStyleColorwayGroups (
--Rec_ID INT IDENTITY (1,1) ,
--StyleColorID NVARCHAR(50) , 
--StyleID UNIQUEIDENTIFIER ,
--StyleSet INT,
--StyleColorNo NVARCHAR(50) , 
--StyleColorName NVARCHAR(200) ,
--MainColor NVARCHAR(100),
--SAPCode NVARCHAR(50) , 
--PLMCode NVARCHAR(200)
--)

IF @SeasonYearID IS NOT NULL AND LEN(@SeasonYearID) > 0
BEGIN 

	DECLARE @StyleSeasonYearID UNIQUEIDENTIFIER 

	SELECT @StyleSeasonYearID  = StyleSeasonYearID 
	FROM pStyleSeasonYear
	WHERE SeasonYearID = @SeasonYearID AND StyleID = @StyleID 

	INSERT INTO #tmpStyleColorwayGroups (StyleColorID , StyleID, StyleSet, StyleColorNo, StyleColorName, MainColor, SAPCode , PLMCode)
	SELECT b.StyleColorID , b.StyleID, b.StyleSet, b.StyleColorNo, c.ColorName, c.ColorName, b.SAPCode, b.PLMCode 
	FROM pStyleColorwaySeasonYear a INNER JOIN pStyleColorway b ON a.StyleColorwayID = b.StyleColorID
	INNER JOIN pColorPalette c ON c.ColorPaletteID = b.ColorPaletteID 
	WHERE  a.StyleID = @StyleID
	AND a.StyleSeasonYearID = @StyleSeasonYearID
	AND b.StyleSet = @StyleSet 
	ORDER BY b.Sort, b.MainColor
END
ELSE 
BEGIN

	INSERT INTO #tmpStyleColorwayGroups (StyleColorID , StyleID, StyleSet, StyleColorNo, StyleColorName, MainColor, SAPCode , PLMCode)
	SELECT StyleColorID , a.StyleID, a.StyleSet, StyleColorNo, b.ColorName AS StyleColorName, b.ColorName AS MainColor, SAPCode, PLMCode 
	FROM pStyleColorway a 
	INNER JOIN pColorPalette b ON a.ColorPaletteID = b.ColorPaletteID 
	WHERE StyleID = @StyleID 
	--AND StyleSet = @StyleSet
	ORDER BY a.Sort, a.MainColor

END

CREATE TABLE #StyleColorValues (
Rec_ID INT IDENTITY (1,1) ,
StyleColorGroupID UNIQUEIDENTIFIER , 
StyleID UNIQUEIDENTIFIER ,
StyleSet INT,
ColorGroupID UNIQUEIDENTIFIER ,
ColorGroupName NVARCHAR(200) ,
StyleColorID  UNIQUEIDENTIFIER ,
StyleColorName NVARCHAR(200) ,
Quantity DECIMAL 
)

IF @SeasonYearID IS NOT NULL AND LEN(@SeasonYearID) > 0
BEGIN
    INSERT INTO #StyleColorValues (StyleColorGroupID, StyleID, StyleSet, ColorGroupID, 
	ColorGroupName, StyleColorID, StyleColorName, Quantity)
	SELECT     b.StyleColorGroupID, b.StyleID, b.StyleSet, b.ColorGroupID, 
	b.ColorGroupName, a.StyleColorID, a.StyleColorName, c.Quantity	
	FROM         #tmpStyleColorwayGroups AS a LEFT OUTER JOIN
						  pStyleColorGroup AS b ON a.StyleID = b.StyleID LEFT OUTER JOIN
						  pStyleColorGroupItem AS c ON c.StyleColorGroupID = b.StyleColorGroupID AND a.StyleColorID = c.StyleColorID
	WHERE     (a.StyleID = @StyleID) AND (a.StyleSet = @StyleSet) AND b.StyleID=@StyleID AND b.StyleSet = @StyleSet AND b.SeasonYearID = @SeasonYearID AND c.SeasonYearID = @SeasonYearID
	ORDER BY b.Sort, b.ColorGroupName
END
ELSE
BEGIN
    INSERT INTO #StyleColorValues (StyleColorGroupID, StyleID, StyleSet, ColorGroupID, 
	ColorGroupName, StyleColorID, StyleColorName, Quantity)
	SELECT     b.StyleColorGroupID, b.StyleID, b.StyleSet, b.ColorGroupID, 
	b.ColorGroupName, a.StyleColorID, a.StyleColorName, c.Quantity	
	FROM         #tmpStyleColorwayGroups AS a LEFT OUTER JOIN
						  pStyleColorGroup AS b ON a.StyleID = b.StyleID LEFT OUTER JOIN
						  pStyleColorGroupItem AS c ON c.StyleColorGroupID = b.StyleColorGroupID AND a.StyleColorID = c.StyleColorID
	WHERE     (a.StyleID = @StyleID) AND (a.StyleSet = @StyleSet) AND b.StyleID=@StyleID AND b.StyleSet = @StyleSet 
	ORDER BY b.Sort, b.ColorGroupName
END

EXECUTE spx_Crosstab 'SELECT  StyleColorGroupID, StyleID, StyleSet, ColorGroupID, ColorGroupName,
StyleColorID, Quantity
FROM #StyleColorValues',
NULL,
NULL,
'StyleColorID',
'Quantity',
'MAX'


--Commented as currently compatibility level for db is set to 80 which doesn't support PIVOT
--DECLARE @cols NVARCHAR(2000)
--SELECT  @cols = STUFF(( SELECT DISTINCT TOP 100 PERCENT
--                                '],[' + t2.StyleColorID
--                        FROM    #tmpStyleColorwayGroups AS t2
--                        --ORDER BY '],[' + t2.StyleColorID
--                        FOR XML PATH('')
--                      ), 1, 2, '') + ']'
--
--
--DECLARE @query NVARCHAR(4000)
--SET @query = N'SELECT StyleColorGroupID, StyleID, StyleSet, ColorGroupID, ColorGroupName,
--'+ @cols +'
--FROM
--(SELECT t1.StyleColorGroupID, t1.StyleID, t1.StyleSet, t1.ColorGroupID, t1.ColorGroupName,
--t1.StyleColorID, t1.Quantity
--FROM    #StyleColorValues AS t1
--        JOIN #tmpStyleColorwayGroups AS t2 ON t1.StyleColorID = t2.StyleColorID) p
--PIVOT
--(
--MAX([Quantity])
--FOR [StyleColorID] IN
--( '+
--@cols +' )
--) AS pvt
--ORDER BY ColorGroupName;'
--EXECUTE(@query)

DROP TABLE #StyleColorValues
DROP TABLE #tmpStyleColorwayGroups

END 

GO
/****** Object:  StoredProcedure [dbo].[spx_GetAllColorGroups_Add_SELECT]    Script Date: 03/09/2010 10:12:58 ******/

ALTER PROCEDURE spx_GetAllColorGroups_Add_SELECT ( @StyleID UNIQUEIDENTIFIER, @StyleSet int, @SeasonYearID NVARCHAR(50)= NULL ) AS  IF @SeasonYearID IS NOT NULL AND LEN(@SeasonYearID) > 0 Select * from pColorGroup AS CG where CG.ColorGroupID NOT 
IN (Select ColorGroupID FROM pStyleColorGroup Where StyleID= @StyleID and StyleSet=@StyleSet and SeasonYearID=@SeasonYearID) order by Sort, ColorGroupName  
ELSE  
Select * from pColorGroup AS CG where CG.ColorGroupID NOT IN (Select ColorGroupID FROM pStyleColorGroup Where StyleID= @StyleID and StyleSet=@StyleSet) order by Sort, ColorGroupName  
  
  
GO
/****** Object:  StoredProcedure [dbo].[spx_GetAllColorGroups_Remove_SELECT]    Script Date: 03/09/2010 10:12:58 ******/


ALTER PROCEDURE spx_GetAllColorGroups_Remove_SELECT ( @StyleID UNIQUEIDENTIFIER, @StyleSet int, @SeasonYearID NVARCHAR(50)= NULL  ) AS  IF @SeasonYearID IS NOT NULL AND LEN(@SeasonYearID) > 0 Select * from pColorGroup AS CG where CG.ColorGroupID 
  
IN (Select ColorGroupID FROM pStyleColorGroup Where StyleID= @StyleID and StyleSet=@StyleSet and SeasonYearID=@SeasonYearID) order by Sort, ColorGroupName    
ELSE    
Select * from pColorGroup AS CG where CG.ColorGroupID IN (Select ColorGroupID FROM pStyleColorGroup Where StyleID= @StyleID and StyleSet=@StyleSet) order by Sort, ColorGroupName    
  
GO
/****** Object:  StoredProcedure [spx_RemoveColorGroups_DELETE]    Script Date: 03/09/2010 10:12:58 ******/


ALTER PROCEDURE spx_RemoveColorGroups_DELETE ( @StyleID UNIQUEIDENTIFIER, @StyleSet int,  @ColorGroupID UNIQUEIDENTIFIER, @ColorGroupName nvarchar(200), @SeasonYearID NVARCHAR(50)= NULL ) AS  BEGIN  
  
 BEGIN TRY --Start the Try Block..  
  BEGIN TRANSACTION -- Start the transaction.. 
IF @SeasonYearID IS NOT NULL AND LEN(@SeasonYearID) > 0 
BEGIN            
DELETE FROM pStyleColorGroupItem WHERE StyleColorGroupID=(Select StyleColorGroupID FROM pStyleColorGroup WHERE StyleID=@StyleID
 AND StyleSet=@StyleSet AND ColorGroupID=@ColorGroupID AND ColorGroupName=@ColorGroupName and SeasonYearID=@SeasonYearID)
           DELETE FROM pStyleColorGroup WHERE StyleID=@StyleID AND StyleSet=@StyleSet AND  ColorGroupID=@ColorGroupID AND ColorGroupName=@ColorGroupName and SeasonYearID=@SeasonYearID  
END    
ELSE  
BEGIN  
          DELETE FROM pStyleColorGroupItem WHERE StyleColorGroupID=(Select StyleColorGroupID FROM pStyleColorGroup WHERE StyleID=@StyleID AND StyleSet=@StyleSet AND ColorGroupID=@ColorGroupID AND ColorGroupName=@ColorGroupName)           DELETE FROM pStyleColorGroup WHERE StyleID=@StyleID AND StyleSet=@StyleSet AND  ColorGroupID=@ColorGroupID AND ColorGroupName=@ColorGroupName  
END        
COMMIT TRAN -- Transaction Success!  
 END TRY  
  
 BEGIN CATCH  
  IF @@TRANCOUNT > 0  
  ROLLBACK TRAN --RollBack in case of Error  
        DECLARE @ErrorMessage NVARCHAR(4000);  
        DECLARE @ErrorSeverity INT;  
        DECLARE @ErrorState INT;  
  
        SELECT @ErrorMessage = ERROR_MESSAGE();  
        SELECT @ErrorSeverity = ERROR_SEVERITY();  
        SELECT @ErrorState = ERROR_STATE();  
  
        RAISERROR (  
       @ErrorMessage, -- Message text.  
                   @ErrorSeverity, -- Severity.  
                   @ErrorState -- State.  
                   );  
  
 END CATCH  
  
END  


GO
/****** Object:  StoredProcedure [dbo].[spx_SaveColorGroups_INSERT]    Script Date: 03/09/2010 10:12:58 ******/


ALTER PROCEDURE spx_SaveColorGroups_INSERT ( @StyleID UNIQUEIDENTIFIER, @StyleSet int,  @ColorGroupID UNIQUEIDENTIFIER, @ColorGroupName nvarchar(200), @CUser NVARCHAR(200),   
@CDate DATETIME, @SeasonYearID NVARCHAR(50)= NULL ) AS  INSERT INTO pStyleColorGroup (StyleID, StyleSet, ColorGroupID, ColorGroupName, CUser, CDate, SeasonYearID)  
 VALUES (@StyleID, @StyleSet, @ColorGroupID, @ColorGroupName, @CUser, @CDate, @SeasonYearID)  
 
GO


INSERT INTO sVersion
    (AppName, Version, LastScriptRun, TimeStamp)
VALUES     ('DB_Version', '2.6.9999', '008', GetDate())

GO