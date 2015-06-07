
/****** Object:  StoredProcedure [dbo].[spx_LineFolderItemSeasonal_INSERT]    Script Date: 03/20/2015 02:15:10 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_LineFolderItemSeasonal_INSERT]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_LineFolderItemSeasonal_INSERT]
GO


CREATE PROCEDURE [dbo].[spx_LineFolderItemSeasonal_INSERT](
	@StyleID uniqueidentifier,
	@LineFolderItemID uniqueidentifier,
	@LineFolderID uniqueidentifier,
	@CreatedDate datetime,
	@CreatedBy nvarchar(200)
)

AS 

DECLARE @StyleColorID UNIQUEIDENTIFIER

-- add LineFolder season to style if needed
declare @LineFolderSeasonYearID UNIQUEIDENTIFIER = (SELECT SeasonYearID FROM pLineFolder WHERE LineFolderID = @LineFolderID)
if (NOT EXISTS (SELECT * FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @LineFolderSeasonYearID))
	AND @LineFolderSeasonYearID <> '00000000-0000-0000-0000-000000000000'
begin
	declare @Sort INT = (SELECT COUNT(*) FROM pStyleSeasonYear WHERE StyleID = @StyleID)
	exec spx_StyleSeasonYearTrans_INSERT @StyleID, @LineFolderSeasonYearID, @CreatedBy, @CreatedDate, 
										 NULL, NULL, NULL, @Sort
end


declare @StyleSeasonYearID UNIQUEIDENTIFIER = (SELECT StyleSeasonYearID FROM pStyleSeasonYear WHERE StyleID = @StyleID AND SeasonYearID = @LineFolderSeasonYearID)

INSERT INTO dbo.pLineFolderItem (LineFolderItemID , LineFolderID, StyleID, StyleSeasonYearID, CUser, CDate, MUser, MDate) 
VALUES (@LineFolderItemID, @LineFolderID, @StyleID, @StyleSeasonYearID, @CreatedBy, @CreatedDate, @CreatedBy, @CreatedDate)



CREATE TABLE #tempColor(
	RecID INT IDENTITY(1,1) NOT NULL,
	StyleColorIDVal UNIQUEIDENTIFIER
) ON [PRIMARY]


INSERT INTO #tempColor(StyleColorIDVal)
SELECT StyleColorwayID FROM pStyleColorwaySeasonYear  WITH (NOLOCK)
WHERE StyleID=@StyleID AND StyleSeasonYearID=@StyleSeasonYearID


DECLARE @ROWCOUNTCOLORS INT
DECLARE @ROWCOUNTCOLORSFINAL INT
DECLARE @tempStyleColorID UNIQUEIDENTIFIER

SET @ROWCOUNTCOLORS = 1
SET @ROWCOUNTCOLORSFINAL = (SELECT COUNT(*) FROM #tempColor)

WHILE @ROWCOUNTCOLORS <= @ROWCOUNTCOLORSFINAL
	BEGIN 
		SELECT @tempStyleColorID = StyleColorIDVal FROM #tempColor where RecID = @ROWCOUNTCOLORS
		exec spx_LineFolderItemColor_INSERT @StyleID, @tempStyleColorID,@LineFolderItemID,@LineFolderID,@CreatedDate,@CreatedBy

		SET @ROWCOUNTCOLORS=@ROWCOUNTCOLORS+1
	END
	
DROP TABLE #tempColor
---------------------------------------------------------
--WI#30169: Deactivated colorway are not active in IntroSeasonYear, and import the status of them
create table #tmpStyleColorway(
	StyleColorwaySeasonYearID uniqueidentifier,
	StyleSeasonYearID uniqueidentifier,
	StyleColorwayID uniqueidentifier,
	StyleID uniqueidentifier,
	MUser nvarchar(200),
	MDate datetime null
)

--delete inactive colorways

Insert into #tmpStyleColorway
select StyleColorwaySeasonYearID,
	StyleSeasonYearID,
	StyleColorwayID,
	StyleID, MUser, MDate from pStyleColorwaySeasonYear where StyleSeasonYearID = @StyleSeasonYearID and StyleColorwayID in (select StyleColorwayID from pStyleColorwaySeasonYear where StyleSeasonYearID=(	
	select StyleSeasonYearID from pStyleSeasonYear
	where SeasonYearID=(select IntroSeasonYearID from pStyleHeader where StyleID=@StyleID) and StyleID=@StyleID
)) 

delete from pStyleColorwaySeasonYear where StyleSeasonYearID = @StyleSeasonYearID


insert into pStyleColorwaySeasonYear
select tmp.StyleColorwaySeasonYearID, tmp.StyleSeasonYearID, tmp.StyleColorwayID, tmp.StyleID, scsy.StyleColorDelivery1,
scsy.StyleColorDelivery2, scsy.StyleColorDelivery3, scsy.StyleColorDelivery4, scsy.StyleColorStatus, scsy.Units, 
scsy.CustomField1, scsy.ColorType, scsy.SampleStatus, tmp.MUser, tmp.MDate, scsy.StyleColorDelivery5, scsy.Locked, 
scsy.StyleColorwayLinkID, scsy.DesignImageFrontID, scsy.DesignImageFrontVersion, scsy.DesignImageBackID, scsy.DesignImageBackVersion,
scsy.Sort, scsy.ColorPaletteID
	from #tmpStyleColorway tmp 
	right join (
select * from pStyleColorwaySeasonYear where StyleSeasonYearID=(	
	select StyleSeasonYearID from pStyleSeasonYear
	where SeasonYearID=(select IntroSeasonYearID from pStyleHeader where StyleID=@StyleID) and StyleID=@StyleID
)) as scsy on tmp.StyleColorwayID = scsy.StyleColorwayID 

drop table #tmpStyleColorway
---------------------------------------------------------

-- assigning BOM to Style within Linelist
DECLARE @StyleBOMDimensionID UNIQUEIDENTIFIER

IF @LineFolderSeasonYearID IS NOT NULL AND @LineFolderSeasonYearID <> '00000000-0000-0000-0000-000000000000'
BEGIN
	IF (SELECT COUNT(*) FROM pStyleBOMDimension 
		INNER JOIN pWorkFlowItem ON pStyleBOMDimension.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
		INNER JOIN pStyleSeasonYear ON pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
		WHERE pStyleBOMDimension.StyleID = @StyleID AND pStyleSeasonYear.SeasonYearID = @LineFolderSeasonYearID) = 1
	BEGIN
		SELECT @StyleBOMDimensionID = StyleBOMDimensionID FROM pStyleBOMDimension
			INNER JOIN pWorkFlowItem ON pStyleBOMDimension.WorkFlowItemID = pWorkFlowItem.WorkFlowItemID
			INNER JOIN pStyleSeasonYear ON pWorkFlowItem.StyleSeasonYearID = pStyleSeasonYear.StyleSeasonYearID
		WHERE pStyleBOMDimension.StyleID = @StyleID AND pStyleSeasonYear.SeasonYearID = @LineFolderSeasonYearID
		
		UPDATE pLineFolderItem SET StyleBOMDimensionID = @StyleBOMDimensionID WHERE LineFolderItemID = @LineFolderItemID
	END
END



GO

INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
VALUES ('DB_Version', '6.1.0000', '10209', GetUTCDate())
GO

