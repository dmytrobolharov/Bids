IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[spx_StyleHeaderLogic_UPDATE]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[spx_StyleHeaderLogic_UPDATE]
GO

/****** Object:  StoredProcedure [dbo].[spx_StyleHeaderLogic_UPDATE]    Script Date: 11/22/2011 12:03:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[spx_StyleHeaderLogic_UPDATE](
	@StyleID UNIQUEIDENTIFIER
)
AS 

CREATE TABLE #tmpStyleHeader ( 
    [StyleID]                 uniqueidentifier NULL,
    [StyleMasterID]           uniqueidentifier NULL,
    [StyleType]               int NOT NULL DEFAULT (1),
    [WorkflowType]            uniqueidentifier NULL,
    [RefNo]                   int IDENTITY(100,1) NOT NULL,
    [StyleNo]                 nvarchar(20) NULL,
    [TempID]                  nvarchar(20) NULL,
    [TempNo]                  nvarchar(20) NULL,
    [CustomerNo]              nvarchar(50) NULL,
    [DevelopmentID]           uniqueidentifier NULL,
    [DevelopmentNo]           nvarchar(20) NULL,
    [ConceptID]               uniqueidentifier NULL,
    [ConceptNo]               nvarchar(50) NULL,
    [SpecNo]                  nvarchar(50) NULL,
    [Description]             nvarchar(100) NULL,
    [StyleCategory]           uniqueidentifier NULL,
    [SizeClass]               nvarchar(50) NULL,
    [SizeRange]               nvarchar(50) NULL,
    [StyleSet]                int NULL,
    [DueDate]                 datetime NULL,
    [RecDate]                 datetime NULL,
    [Customer]                nvarchar(200) NULL,
    [Buyer]                   nvarchar(200) NULL,
    [Designer]                nvarchar(100) NULL,
    [SampleMaker]             nvarchar(100) NULL,
    [PatternMaker]            nvarchar(100) NULL,
    [ProductionManager]       nvarchar(100) NULL,
    [TechnicalDesigner]       nvarchar(100) NULL,
    [StyleStatus]             nvarchar(50) NULL,
    [StyleLocation]           nvarchar(50) NULL,
    [WashType]                nvarchar(50) NULL,
    [Pitch]                   int NULL,
    [MaterialID]              uniqueidentifier NULL,
    [MaterialImageID]         uniqueidentifier NULL,
    [MaterialImageVersion]    int NULL DEFAULT (0),
    [MaterialNo]              nvarchar(50) NULL,
    [MaterialName]            nvarchar(200) NULL,
    [POMTempID1]              uniqueidentifier NULL,
    [POMTempVersion1]         int NULL,
    [POMTempSizeClass1]       nvarchar(50) NULL,
    [POMTempID2]              uniqueidentifier NULL,
    [POMTempVersion2]         int NULL,
    [POMTempSizeClass2]       nvarchar(50) NULL,
    [POMTempID3]              uniqueidentifier NULL,
    [POMTempVersion3]         int NULL,
    [POMTempSizeClass3]       nvarchar(50) NULL,
    [POMTempID4]              uniqueidentifier NULL,
    [POMTempVersion4]         int NULL,
    [POMTempSizeClass4]       nvarchar(50) NULL,
    [StyleMaterialID]         uniqueidentifier NULL,
    [DesignSketchID]          uniqueidentifier NULL,
    [TechSketchID]            uniqueidentifier NULL,
    [ConceptSketchID]         uniqueidentifier NULL,
    [ColorSketchID]           uniqueidentifier NULL,
    [DesignSketchVersion]     int NULL,
    [TechSketchVersion]       int NULL,
    [ConceptSketchVersion]    int NULL,
    [ColorSketchVersion]      int NULL,
    [DetailSketchID1]         uniqueidentifier NULL,
    [DetailSketchID2]         uniqueidentifier NULL,
    [DetailSketchID3]         uniqueidentifier NULL,
    [DetailSketchID4]         uniqueidentifier NULL,
    [DetailSketchVersion1]    int NULL,
    [DetailSketchVersion2]    int NULL,
    [DetailSketchVersion3]    int NULL,
    [DetailSketchVersion4]    int NULL,
    [SpecSketchID1]           uniqueidentifier NULL,
    [SpecSketchID2]           uniqueidentifier NULL,
    [SpecSketchID3]           uniqueidentifier NULL,
    [SpecSketchID4]           uniqueidentifier NULL,
    [SpecSketchVersion1]      int NULL,
    [SpecSketchVersion2]      int NULL,
    [SpecSketchVersion3]      int NULL,
    [SpecSketchVersion4]      int NULL,
    [Markup]                  numeric(18,0) NULL,
    [TargetPrice]             money NULL,
    [SellingPrice]            money NULL,
    [CustomField1]            nvarchar(200) NULL,
    [CustomField2]            nvarchar(200) NULL,
    [CustomField3]            nvarchar(200) NULL,
    [CustomField4]            nvarchar(200) NULL,
    [CustomField5]            nvarchar(200) NULL,
    [CustomField6]            nvarchar(200) NULL,
    [CustomField7]            nvarchar(200) NULL,
      [CustomField8]          nvarchar(200) NULL,
    [CustomField9]            nvarchar(200) NULL,
    [CustomField10]           nvarchar(200) NULL,
    [CustomField11]           nvarchar(200) NULL,
    [CustomField12]           nvarchar(200) NULL,
    [CustomField13]           nvarchar(200) NULL,
    [CustomField14]           nvarchar(200) NULL,
    [CustomField15]           nvarchar(200) NULL,
    [Pc1]                     nvarchar(50) NULL,
    [Pc2]                     nvarchar(50) NULL,
    [Pc3]                     nvarchar(50) NULL,
    [Pc4]                     nvarchar(50) NULL,
    [CUser]                   nvarchar(50) NULL,
    [CDate]                   datetime NULL,
    [MUser]                   nvarchar(200) NULL,
    [MDate]                   datetime NULL,
    [Active]                  int NULL,
    [Change]                  int NULL,
    [Action]                  nvarchar(200) NULL,
    [NoColorCombo]            int NOT NULL DEFAULT (0),
    [StyleDetail]             ntext NULL,
    [CustomField16]           nvarchar(200) NULL,
    [CustomField17]           nvarchar(200) NULL,
    [CustomField18]           nvarchar(200) NULL,
    [CustomField19]           nvarchar(200) NULL,
    [CustomField20]           nvarchar(200) NULL,
    [CustomField21]           nvarchar(200) NULL,
    [CustomField22]           nvarchar(200) NULL,
    [CustomField23]           nvarchar(200) NULL,
    [CustomField24]           nvarchar(200) NULL,
    [CustomField25]           nvarchar(200) NULL,
    [CustomField26]           nvarchar(200) NULL,
    [CustomField27]           nvarchar(200) NULL,
    [CustomField28]           nvarchar(200) NULL,
    [CustomField29]           nvarchar(200) NULL,
    [CustomField30]           nvarchar(200) NULL,
	[CustomField31]           nvarchar(200) NULL,		-- #02
	[CustomField32]           nvarchar(200) NULL,		-- #02
	[CustomField33]           nvarchar(200) NULL,		-- #02
	[CustomField34]           nvarchar(200) NULL,		-- #02
	[CustomField35]           nvarchar(200) NULL,		-- #02
	[CustomField36]           nvarchar(200) NULL,		-- #02
	[CustomField37]           nvarchar(200) NULL,		-- #02
	[CustomField38]           nvarchar(200) NULL,		-- #02
	[CustomField39]           nvarchar(200) NULL,		-- #02
	[CustomField40]           nvarchar(200) NULL,		-- #02
    [Distribution]            int NULL,
    [UserMID]                 uniqueidentifier NULL,
    [UserCID]                 uniqueidentifier NULL

)

INSERT INTO #tmpStyleHeader
    (StyleID, StyleMasterID, StyleType, WorkflowType, StyleNo, TempID, TempNo, CustomerNo, DevelopmentID, DevelopmentNo, ConceptID, 
    ConceptNo, SpecNo, Description, StyleCategory, SizeClass, SizeRange, StyleSet, DueDate, RecDate, Customer, Buyer, Designer, SampleMaker, 
    PatternMaker, ProductionManager, TechnicalDesigner, StyleStatus, StyleLocation, WashType, Pitch, MaterialID, MaterialImageID, 
    MaterialImageVersion, MaterialNo, MaterialName, POMTempID1, POMTempVersion1, POMTempSizeClass1, POMTempID2, POMTempVersion2, 
    POMTempSizeClass2, POMTempID3, POMTempVersion3, POMTempSizeClass3, POMTempID4, POMTempVersion4, POMTempSizeClass4, 
    StyleMaterialID, DesignSketchID, TechSketchID, ConceptSketchID, ColorSketchID, DesignSketchVersion, TechSketchVersion, ConceptSketchVersion, 
    ColorSketchVersion, DetailSketchID1, DetailSketchID2, DetailSketchID3, DetailSketchID4, DetailSketchVersion1, DetailSketchVersion2, 
    DetailSketchVersion3, DetailSketchVersion4, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, SpecSketchVersion1, 
    SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, Markup, TargetPrice, SellingPrice, CustomField1, CustomField2, CustomField3, 
    CustomField4, CustomField5, CustomField6, CustomField7, CustomField8, CustomField9, CustomField10, CustomField11, CustomField12, 
    CustomField13, CustomField14, CustomField15, Pc1, Pc2, Pc3, Pc4, CUser, CDate, MUser, MDate, Active, Change, Action, NoColorCombo, 
    StyleDetail,CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
      CustomField26, CustomField27, CustomField28, CustomField29, CustomField30, 
	CustomField31, CustomField32, CustomField33, CustomField34, CustomField35, CustomField36, CustomField37, CustomField38, CustomField39, CustomField40,		-- #02
	Distribution,UserMID,UserCID 
      )
SELECT     StyleID, StyleMasterID, StyleType, WorkflowType, StyleNo, TempID, TempNo, CustomerNo, DevelopmentID, DevelopmentNo, ConceptID, 
    ConceptNo, SpecNo, Description, StyleCategory, SizeClass, SizeRange, StyleSet, DueDate, RecDate, Customer, Buyer, Designer, SampleMaker, 
    PatternMaker, ProductionManager, TechnicalDesigner, StyleStatus, StyleLocation, WashType, Pitch, MaterialID, MaterialImageID, 
    MaterialImageVersion, MaterialNo, MaterialName, POMTempID1, POMTempVersion1, POMTempSizeClass1, POMTempID2, POMTempVersion2, 
    POMTempSizeClass2, POMTempID3, POMTempVersion3, POMTempSizeClass3, POMTempID4, POMTempVersion4, POMTempSizeClass4, 
    StyleMaterialID, DesignSketchID, TechSketchID, ConceptSketchID, ColorSketchID, DesignSketchVersion, TechSketchVersion, ConceptSketchVersion, 
    ColorSketchVersion, DetailSketchID1, DetailSketchID2, DetailSketchID3, DetailSketchID4, DetailSketchVersion1, DetailSketchVersion2, 
    DetailSketchVersion3, DetailSketchVersion4, SpecSketchID1, SpecSketchID2, SpecSketchID3, SpecSketchID4, SpecSketchVersion1, 
    SpecSketchVersion2, SpecSketchVersion3, SpecSketchVersion4, Markup, TargetPrice, SellingPrice, CustomField1, CustomField2, CustomField3, 
    CustomField4, CustomField5, CustomField6, CustomField7, CustomField8, CustomField9, CustomField10, CustomField11, CustomField12, 
    CustomField13, CustomField14, CustomField15, Pc1, Pc2, Pc3, Pc4, CUser, CDate, MUser, MDate, Active, Change, Action, NoColorCombo, 
    StyleDetail,CustomField16, CustomField17, CustomField18, CustomField19, CustomField20, CustomField21, CustomField22,  CustomField23, CustomField24,  CustomField25, 
      CustomField26, CustomField27, CustomField28,  CustomField29,  CustomField30, 
	CustomField31, CustomField32, CustomField33, CustomField34, CustomField35, CustomField36, CustomField37, CustomField38, CustomField39, CustomField40,		-- #02
	Distribution,UserMID,UserCID
FROM dbo.pStyleHeader
WHERE (StyleID = @StyleID)

DECLARE
    @StyleMasterID            uniqueidentifier,
    @StyleType                int,
    @WorkflowType             uniqueidentifier,
    @CustomerNo               nvarchar(50),
    @DevelopmentID            uniqueidentifier,
    @DevelopmentNo            nvarchar(50),
    @SpecNo                   nvarchar(50),
    @Description              nvarchar(200),
    @StyleCategory            uniqueidentifier,
    @StyleSet                 int,
    @DueDate                  datetime,
    @RecDate                  datetime,
    @Customer                 nvarchar,
    @Buyer                    nvarchar(200),
    @Designer                 nvarchar(200),
    @SampleMaker              nvarchar(200),
    @PatternMaker             nvarchar(200),
    @ProductionManager        nvarchar(200),
    @TechnicalDesigner        nvarchar(200),
    @StyleStatus              nvarchar(200),
    @StyleLocation            nvarchar(200),
    @WashType                 nvarchar(200),
    @Pitch                    int,
    @MaterialID               uniqueidentifier,
    @MaterialImageID          uniqueidentifier,
    @MaterialImageVersion     int,
    @MaterialNo               nvarchar(200),
    @MaterialName             nvarchar(200),
    @StyleMaterialID          uniqueidentifier,
    @DesignSketchID           uniqueidentifier,
    @TechSketchID             uniqueidentifier,
    @ConceptSketchID          uniqueidentifier,
    @ColorSketchID            uniqueidentifier,
    @DesignSketchVersion      int,
    @TechSketchVersion        int,
    @ConceptSketchVersion     int,
    @ColorSketchVersion       int,
    @DetailSketchID1          uniqueidentifier,
    @DetailSketchID2          uniqueidentifier,
    @DetailSketchID3          uniqueidentifier,
    @DetailSketchID4          uniqueidentifier,
    @DetailSketchVersion1     int,
    @DetailSketchVersion2     int,
    @DetailSketchVersion3     int,
    @DetailSketchVersion4     int,
    @SpecSketchID1            uniqueidentifier,
    @SpecSketchID2            uniqueidentifier,
    @SpecSketchID3            uniqueidentifier,
    @SpecSketchID4            uniqueidentifier,
    @SpecSketchVersion1       int,
    @SpecSketchVersion2       int,
    @SpecSketchVersion3       int,
    @SpecSketchVersion4       int,
   @Markup                    numeric,
    @TargetPrice              money,
    @SellingPrice             money,
    @CustomField1             nvarchar(200),
    @CustomField2             nvarchar(200),
    @CustomField3             nvarchar(200),
    @CustomField4             nvarchar(200),
    @CustomField5             nvarchar(200),
    @CustomField6             nvarchar(200),
    @CustomField7       nvarchar(200),
    @CustomField8             nvarchar(200),
    @CustomField9             nvarchar(200),
    @CustomField10            nvarchar(200),
    @CustomField11            nvarchar(200),
    @CustomField12            nvarchar(200),

    @CustomField13            nvarchar(200),
    @CustomField14            nvarchar(200),
    @CustomField15            nvarchar(200),
    @Pc1                      nvarchar(200),
    @Pc2                      nvarchar(200),
    @Pc3                      nvarchar(200),
    @Pc4                      nvarchar(200),
    @MUser                    nvarchar(200),
    @UserMID					uniqueidentifier,
    @MDate                    datetime,
    @Change                   int
    --@StyleDetail            ntext

DECLARE     @CustomField16    nvarchar(200),
            @CustomField17          nvarchar(200),
            @CustomField18          nvarchar(200),
            @CustomField19          nvarchar(200),
            @CustomField20          nvarchar(200),
            @CustomField21          nvarchar(200),
            @CustomField22          nvarchar(200),
            @CustomField23          nvarchar(200),
            @CustomField24          nvarchar(200),
            @CustomField25          nvarchar(200),
            @CustomField26          nvarchar(200),
            @CustomField27          nvarchar(200),
            @CustomField28          nvarchar(200),
            @CustomField29          nvarchar(200),
            @CustomField30          nvarchar(200),
            @CustomField31          nvarchar(200),		-- #02
            @CustomField32          nvarchar(200),		-- #02
            @CustomField33          nvarchar(200),		-- #02
            @CustomField34          nvarchar(200),		-- #02
            @CustomField35          nvarchar(200),		-- #02
            @CustomField36          nvarchar(200),		-- #02
            @CustomField37          nvarchar(200),		-- #02
            @CustomField38          nvarchar(200),		-- #02
            @CustomField39          nvarchar(200),		-- #02
            @CustomField40          nvarchar(200),		-- #02
            @Distribution                 int


SELECT     
    @StyleMasterID                  = StyleMasterID,
    @StyleType                      = StyleType,
    @WorkflowType             = WorkflowType,
    @CustomerNo                     = CustomerNo,
    @DevelopmentID                  = DevelopmentID,
    @DevelopmentNo                  = DevelopmentNo,
    @SpecNo                         = SpecNo,
    @Description              = Description,
    @StyleCategory            = StyleCategory,
    @StyleSet                 = StyleSet,
    @DueDate                  = DueDate,
    @RecDate                  = RecDate,
    @Customer                 = Customer,
    @Buyer                    = Buyer,
    @Designer                 = Designer,
    @SampleMaker              = SampleMaker,
    @PatternMaker             = PatternMaker,
    @ProductionManager        = ProductionManager,
    @TechnicalDesigner        = TechnicalDesigner,
    @StyleStatus              = StyleStatus,
    @StyleLocation            = StyleLocation,
    @WashType                 = WashType,
    @Pitch                    = Pitch,
    @MaterialID               = MaterialID,
    @MaterialImageID          = MaterialImageID,
    @MaterialImageVersion     = MaterialImageVersion,
    @MaterialNo               = MaterialNo,
    @MaterialName             = MaterialName,
    @StyleMaterialID          = StyleMaterialID,
    @DesignSketchID           = DesignSketchID,
    @TechSketchID             = TechSketchID,
    @ConceptSketchID          = ConceptSketchID,
    @ColorSketchID            = ColorSketchID,
    @DesignSketchVersion      = DesignSketchVersion,
    @TechSketchVersion        = TechSketchVersion,
    @ConceptSketchVersion     = ConceptSketchVersion,
    @ColorSketchVersion       = ColorSketchVersion,
    @DetailSketchID1          = DetailSketchID1,
    @DetailSketchID2          = DetailSketchID2,
    @DetailSketchID3          = DetailSketchID3,
    @DetailSketchID4          = DetailSketchID4,
    @DetailSketchVersion1     = DetailSketchVersion1,
    @DetailSketchVersion2     = DetailSketchVersion2,
    @DetailSketchVersion3     = DetailSketchVersion3,
    @DetailSketchVersion4     = DetailSketchVersion4,
    @SpecSketchID1            = SpecSketchID1,
    @SpecSketchID2            = SpecSketchID2,
    @SpecSketchID3            = SpecSketchID3,
    @SpecSketchID4            = SpecSketchID4,
    @SpecSketchVersion1       = SpecSketchVersion1,
    @SpecSketchVersion2       = SpecSketchVersion2,
    @SpecSketchVersion3       = SpecSketchVersion3,
    @SpecSketchVersion4       = SpecSketchVersion4,
    @Markup                   = Markup,
    @TargetPrice              = TargetPrice,
    @SellingPrice             = SellingPrice,
    @CustomField1             = CustomField1,
    @CustomField2             = CustomField2,
    @CustomField3             = CustomField3,
    @CustomField4             = CustomField4,
    @CustomField5             = CustomField5,
    @CustomField6             = CustomField6,
    @CustomField7             = CustomField7,
    @CustomField8             = CustomField8,
    @CustomField9             = CustomField9,
    @CustomField10            = CustomField10,
    @CustomField11            = CustomField11,
    @CustomField12            = CustomField12,
    @CustomField13            = CustomField13,
    @CustomField14            = CustomField14,
    @CustomField15            = CustomField15,
    @CustomField16            = CustomField16,
    @CustomField17            = CustomField17,
    @CustomField18            = CustomField18,
    @CustomField19            = CustomField19,
    @CustomField20            = CustomField20,
    @CustomField21            = CustomField21,
    @CustomField22            = CustomField22,
    @CustomField23            = CustomField23,
    @CustomField24            = CustomField24,
    @CustomField25            = CustomField25,
    @CustomField26            = CustomField26,
    @CustomField27            = CustomField27,
    @CustomField28            = CustomField28,
    @CustomField29            = CustomField29,
    @CustomField30            = CustomField30,
    @CustomField31            = CustomField31,			-- #02
    @CustomField32            = CustomField32,			-- #02
    @CustomField33            = CustomField33,			-- #02
    @CustomField34            = CustomField34,			-- #02
    @CustomField35            = CustomField35,			-- #02
    @CustomField36            = CustomField36,			-- #02
    @CustomField37            = CustomField37,			-- #02
    @CustomField38            = CustomField38,			-- #02
    @CustomField39            = CustomField39,			-- #02
    @CustomField40            = CustomField40,			-- #02
      @Distribution                 = Distribution,
    @Pc1                      = Pc1,
    @Pc2                      = Pc2,
    @Pc3                      = Pc3,
    @Pc4                      = Pc4,
    @MUser                    = MUser,
    @UserMID                  = UserMID,
    @MDate                    = MDate,
    @Change                   = Change

FROM  #tmpStyleHeader


CREATE TABLE #tempStyleDevelopmentItem ( 
      [RecID]                                   int IDENTITY(1,1)  NOT NULL,
      [StyleDevelopmentID]          uniqueidentifier NULL,
      [StyleID]                     uniqueidentifier NULL,
      [SizeRange]                   nvarchar(50) NULL,
      [Variation]                   int NULL,
      [CUser]                       nvarchar(200) NULL,
      [CDate]                       datetime NULL,
      [MUser]                       nvarchar(200) NULL,
      [MDate]                       datetime NULL,
)

DECLARE @RowStyleLoop               int
DECLARE @RowStyleCount              int
DECLARE @tmpStyleID                       uniqueidentifier
DECLARE @tmpStyleVariation          int

DECLARE @StyleDevelopmentId uniqueidentifier
SELECT @tmpStyleVariation = Variation, @StyleDevelopmentId = StyleDevelopmentId FROM pStyleDevelopmentItem WHERE StyleId = @StyleId


DECLARE @StyleTypeVarSet varchar(50)
SET @StyleTypeVarSet = ( SELECT StyleType FROM pStyleType WHERE StyleTypeID IN (SELECT StyleType FROM pStyleHeader WHERE StyleID = @StyleID))


IF @StyleTypeVarSet = 'S'
BEGIN
      INSERT INTO #tempStyleDevelopmentItem (StyleDevelopmentID, StyleID, SizeRange, Variation)
      SELECT StyleDevelopmentID, StyleID, SizeRange, Variation FROM pStyleDevelopmentItem 
      WHERE StyleDevelopmentID = @StyleDevelopmentId 
      --SELECT 'HOME' AS StyleType
END
ELSE
BEGIN
      INSERT INTO #tempStyleDevelopmentItem (StyleDevelopmentID, StyleID, SizeRange, Variation)
      SELECT StyleDevelopmentID, StyleID, SizeRange, Variation FROM pStyleDevelopmentItem 
      WHERE StyleDevelopmentID = @StyleDevelopmentId AND Variation = @tmpStyleVariation
      --SELECT 'APPAREL' AS StyleType
END

SET @RowStyleLoop = 1
SET @RowStyleCount = (SELECT COUNT(*) FROM #tempStyleDevelopmentItem)

WHILE @RowStyleLoop <= @RowStyleCount 

      BEGIN

            SELECT @tmpStyleID = StyleID FROM #tempStyleDevelopmentItem WHERE RecID = @RowStyleLoop

                  BEGIN 

                        IF @StyleTypeVarSet = 'S'
                        BEGIN
                        UPDATE pStyleHeader
                        SET StyleType = @StyleType, WorkflowType = @WorkflowType, DevelopmentID = @DevelopmentID, 
                              DevelopmentNo = @DevelopmentNo, SpecNo = @SpecNo, Description = @Description, StyleCategory = @StyleCategory, StyleSet = @StyleSet, 
                              Customer = @Customer, Buyer = @Buyer, Designer = @Designer, SampleMaker = @SampleMaker, 
                              PatternMaker = @PatternMaker, ProductionManager = @ProductionManager, TechnicalDesigner = @TechnicalDesigner, 
                              StyleLocation = @StyleLocation, WashType = @WashType, Pitch = @Pitch, MaterialID = @MaterialID, MaterialImageID = @MaterialImageID, 
                              MaterialImageVersion = @MaterialImageVersion, MaterialNo = @MaterialNo, MaterialName = @MaterialName, StyleMaterialID = @StyleMaterialID, 
                              --DesignSketchID = @DesignSketchID, 
                              TechSketchID = @TechSketchID, ConceptSketchID = @ConceptSketchID, ColorSketchID = @ColorSketchID, 
                              --DesignSketchVersion = DesignSketchVersion, 
                              TechSketchVersion = @TechSketchVersion, ConceptSketchVersion = @ConceptSketchVersion, 
                              ColorSketchVersion = @ColorSketchVersion, DetailSketchID1 = @DetailSketchID1, DetailSketchID2 = @DetailSketchID2, 
                              DetailSketchID3 = @DetailSketchID3, DetailSketchID4 = @DetailSketchID4, DetailSketchVersion1 = @DetailSketchVersion1, 
                              DetailSketchVersion2 = @DetailSketchVersion2, DetailSketchVersion3 = @DetailSketchVersion3, DetailSketchVersion4 = @DetailSketchVersion4, 
                              SpecSketchID1 = @SpecSketchID1, SpecSketchID2 = @SpecSketchID2, SpecSketchID3 = @SpecSketchID3, SpecSketchID4 = @SpecSketchID4, 
                              SpecSketchVersion1 = @SpecSketchVersion1, SpecSketchVersion2 = @SpecSketchVersion2, SpecSketchVersion3 = @SpecSketchVersion3, 
                              SpecSketchVersion4 = @SpecSketchVersion4, Markup = @Markup, TargetPrice = @TargetPrice, SellingPrice = @SellingPrice, 
                              CustomField1 = @CustomField1, CustomField2 = @CustomField2, CustomField3 = @CustomField3, CustomField4 = @CustomField4, 
                              CustomField5 = @CustomField5, CustomField6 = @CustomField6, CustomField7 = @CustomField7, CustomField8 = @CustomField8, 
                              CustomField9 = @CustomField9, CustomField10 = @CustomField10, CustomField11 = @CustomField11, CustomField12 = @CustomField12, 
                              CustomField13 = @CustomField13, CustomField14 = @CustomField14, CustomField15 = @CustomField15, MUser = @Muser, 
                              MDate = @MDate,
                              CustomField16 = @CustomField16, CustomField17 = @CustomField17 , CustomField18 = @CustomField18, CustomField19 = @CustomField19,
                              CustomField20 = @CustomField20, CustomField21 = @CustomField21, CustomField22 = @CustomField22, CustomField23 = @CustomField23,
                              CustomField24 = @CustomField24, CustomField25 = @CustomField25, CustomField26 = @CustomField26, CustomField27 = @CustomField27,
                              CustomField28 = @CustomField28, CustomField29 = @CustomField29, CustomField30 = @CustomField30, 
							  CustomField31 = @CustomField31, CustomField32 = @CustomField32, CustomField33 = @CustomField33, CustomField34 = @CustomField34,	-- #02
							  CustomField35 = @CustomField35, CustomField36 = @CustomField36, CustomField37 = @CustomField37, CustomField38 = @CustomField38,	-- #02
							  CustomField39 = @CustomField39, CustomField40 = @CustomField40,																	-- #02
							  Distribution = @Distribution, UserMID = @UserMID 
                        WHERE StyleID = @tmpStyleID
                        END
                        ELSE
                        BEGIN
                        UPDATE pStyleHeader
                        SET StyleMasterID = @StyleMasterID, StyleType = @StyleType, WorkflowType = @WorkflowType, DevelopmentID = @DevelopmentID, 
                              DevelopmentNo = @DevelopmentNo, SpecNo = @SpecNo, Description = @Description, StyleCategory = @StyleCategory, StyleSet = @StyleSet, 
                              Customer = @Customer, Buyer = @Buyer, Designer = @Designer, SampleMaker = @SampleMaker, 
                              PatternMaker = @PatternMaker, ProductionManager = @ProductionManager, TechnicalDesigner = @TechnicalDesigner, 
                              StyleLocation = @StyleLocation, WashType = @WashType, Pitch = @Pitch, MaterialID = @MaterialID, MaterialImageID = @MaterialImageID, 
                              MaterialImageVersion = @MaterialImageVersion, MaterialNo = @MaterialNo, MaterialName = @MaterialName, StyleMaterialID = @StyleMaterialID, 
                              DesignSketchID = @DesignSketchID, TechSketchID = @TechSketchID, ConceptSketchID = @ConceptSketchID, ColorSketchID = @ColorSketchID, 
                              DesignSketchVersion = DesignSketchVersion, TechSketchVersion = @TechSketchVersion, ConceptSketchVersion = @ConceptSketchVersion, 
                              ColorSketchVersion = @ColorSketchVersion, DetailSketchID1 = @DetailSketchID1, DetailSketchID2 = @DetailSketchID2, 
                              DetailSketchID3 = @DetailSketchID3, DetailSketchID4 = @DetailSketchID4, DetailSketchVersion1 = @DetailSketchVersion1, 
                              DetailSketchVersion2 = @DetailSketchVersion2, DetailSketchVersion3 = @DetailSketchVersion3, DetailSketchVersion4 = @DetailSketchVersion4, 
                              SpecSketchID1 = @SpecSketchID1, SpecSketchID2 = @SpecSketchID2, SpecSketchID3 = @SpecSketchID3, SpecSketchID4 = @SpecSketchID4, 
                              SpecSketchVersion1 = @SpecSketchVersion1, SpecSketchVersion2 = @SpecSketchVersion2, SpecSketchVersion3 = @SpecSketchVersion3, 
                              SpecSketchVersion4 = @SpecSketchVersion4, Markup = @Markup, TargetPrice = @TargetPrice, SellingPrice = @SellingPrice, 
                              CustomField1 = @CustomField1, CustomField2 = @CustomField2, CustomField3 = @CustomField3, CustomField4 = @CustomField4, 
                              CustomField5 = @CustomField5, CustomField6 = @CustomField6, CustomField7 = @CustomField7, CustomField8 = @CustomField8, 
                              CustomField9 = @CustomField9, CustomField10 = @CustomField10, CustomField11 = @CustomField11, CustomField12 = @CustomField12, 
                              CustomField13 = @CustomField13, CustomField14 = @CustomField14, CustomField15 = @CustomField15, MUser = @Muser, 
                              MDate = @MDate,
                              CustomField16 = @CustomField16, CustomField17 = @CustomField17 , CustomField18 = @CustomField18, CustomField19 = @CustomField19,
                              CustomField20 = @CustomField20, CustomField21 = @CustomField21, CustomField22 = @CustomField22, CustomField23 = @CustomField23,
                              CustomField24 = @CustomField24, CustomField25 = @CustomField25, CustomField26 = @CustomField26, CustomField27 = @CustomField27,
                              CustomField28 = @CustomField28, CustomField29 = @CustomField29, CustomField30 = @CustomField30,
							  CustomField31 = @CustomField31, CustomField32 = @CustomField32, CustomField33 = @CustomField33, CustomField34 = @CustomField34,	-- #02
							  CustomField35 = @CustomField35, CustomField36 = @CustomField36, CustomField37 = @CustomField37, CustomField38 = @CustomField38,	-- #02
							  CustomField39 = @CustomField39, CustomField40 = @CustomField40,																	-- #02
							  Distribution = @Distribution, UserMID = @UserMID
                        WHERE StyleID = @tmpStyleID
                        END
                  END   

            SET @RowStyleLoop = @RowStyleLoop + 1

      END
IF(NOT EXISTS(SELECT * FROM sVersion WHERE LastScriptRun='02222'))
BEGIN
	INSERT INTO sVersion(AppName, Version, LastScriptRun, TimeStamp)
	VALUES     ('DB_Version', '4.1.0000', '02222', GetDate())
END	
GO
