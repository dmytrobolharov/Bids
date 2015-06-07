-------------------------------
--- Restore Language Pack DB --
-------------------------------
DECLARE @FileList 
TABLE
(
	[LogicalName] varchar(128),
	[PhysicalName] varchar(128), 
	[Type] varchar, 
	[FileGroupName] varchar(128), 
	[Size] varchar(128), 
	[MaxSize] varchar(128), 
	[FileId]varchar(128), 
	[CreateLSN]varchar(128), 
	[DropLSN]varchar(128), 
	[UniqueId]varchar(128), 
	[ReadOnlyLSN]varchar(128), 
	[ReadWriteLSN]varchar(128), 
	[BackupSizeInBytes]varchar(128), 
	[SourceBlockSize]varchar(128), 
	[FileGroupId]varchar(128), 
	[LogGroupGUID]varchar(128), 
	[DifferentialBaseLSN]varchar(128), 
	[DifferentialBaseGUID]varchar(128), 
	[IsReadOnly]varchar(128), 
	[IsPresent]varchar(128), 
	[TDEThumbprint]varchar(128)
)
DECLARE @Path varchar(1000)='$(BackupPath)'
DECLARE @LogicalNameData varchar(128),@LogicalNameLog varchar(128)
INSERT INTO @FileList
EXEC('
	RESTORE FILELISTONLY 
	FROM DISK=''' +@Path+ '''
   ')

SELECT @LogicalNameData =  LogicalName FROM @FileList WHERE Type = 'D'
SELECT @LogicalNameLog = LogicalName FROM @FileList WHERE Type = 'L'

EXEC('
	RESTORE DATABASE [PLMLanguagePack] 
	FROM DISK = N''$(BackupPath)''
	WITH FILE = 1, 
	MOVE N''' + @LogicalNameData + ''' TO N''$(FinalDest)\LanguagePack.mdf'', 
	MOVE N''' + @LogicalNameLog + ''' TO N''$(FinalDest)\LanguagePack.ldf'', 
	NOUNLOAD, STATS = 10
')
GO

USE $(TargetDB)
GO

-- ------------------------------------------------------------------------------------------------
-- System Strings
-- ------------------------------------------------------------------------------------------------
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'utx_Lang_SystemString_UPDATE')
   DROP PROCEDURE utx_Lang_SystemString_UPDATE
GO                                
CREATE PROCEDURE utx_Lang_SystemString_UPDATE
  (
     @Source_Database_Name nVarchar(255),
     @Destination_Database_Name nVarchar(255),
     @Column_Name   nvarchar(255)
   )
   AS
   BEGIN  
      --DECLARE @Source_Database_Name nVarchar(255)
      --DECLARE @Destination_Database_Name nVarchar(255)
      --DECLARE @Column_Name   nvarchar(255)
      DECLARE @mysql         nvarchar(4000)

      --SET  @Source_Database_Name      = 'German31Translations'
      --SET  @Destination_Database_Name = 'plmOnOOTB401'
      --SET  @Column_Name               = 'de_DE'
      SET  @mysql                       = Null
    
      SET  @mysql = 'UPDATE ' + @Destination_Database_Name + '.dbo.sSystemStrings'
      SET  @mysql = @mysql + ' SET ' + @Column_Name + ' = (SELECT G31.' + @Column_Name
      SET  @mysql = @mysql + ' FROM ' + @Source_Database_Name + '.dbo.sSystemStrings G31'
      SET  @mysql = @mysql + ' WHERE G31.DesignString = ' + @Destination_Database_Name + '.dbo.sSystemStrings.DesignString'
      SET  @mysql = @mysql + ' AND G31.' + @Column_Name + ' is not null)'
      SET  @mysql = @mysql + ' WHERE (' + @Column_Name +  ' is null' 
      SET  @mysql = @mysql + ' or ' + @Column_Name + ' = ' + char(39) + char(39)
      SET  @mysql = @mysql + ' or len(ltrim(RTRIM(' + @Column_Name + + '))) < 1)'
      SET  @mysql = @mysql + ' AND DesignString in (SELECT G31.DesignString '
      SET  @mysql = @mysql + ' FROM ' + @Source_Database_Name + '.dbo.sSystemStrings G31'
      SET  @mysql = @mysql + ' WHERE G31.' + @Column_Name + ' is not null)'
   
      --PRINT @mysql
   
      EXECUTE sp_executesql @mysql
   END
GO


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'utx_Lang_SystemString_INSERT')
   DROP PROCEDURE utx_Lang_SystemString_INSERT
GO                                
CREATE PROCEDURE utx_Lang_SystemString_INSERT
  (
     @Source_Database_Name nVarchar(255),
     @Destination_Database_Name nVarchar(255),
     @Column_List   nvarchar(512)
   )
   AS
   BEGIN  

      DECLARE @mysql         nvarchar(4000)       
      SET  @mysql                       = Null

      SET @mysql = 'INSERT INTO ' + @Destination_Database_Name + '.dbo.sSystemStrings('
      SET @mysql = @mysql + ' [DesignString]'
      SET @mysql = @mysql + @Column_List
      SET @mysql = @mysql + ' ,[CDate]'
      SET @mysql = @mysql + ' ,[CUser]'
      SET @mysql = @mysql + ' ,[MDate]'
      SET @mysql = @mysql + ' ,[MUser])'
      SET @mysql = @mysql + ' SELECT [DesignString]'
      SET @mysql = @mysql + @Column_List
      SET @mysql = @mysql + ' ,[CDate]'
      SET @mysql = @mysql + ' ,[CUser]'
      SET @mysql = @mysql + ' ,[MDate]'
      SET @mysql = @mysql + ' ,[MUser]'
      SET @mysql = @mysql + ' FROM ' + @Source_Database_Name + '.dbo.sSystemStrings'
      SET @mysql = @mysql + ' WHERE DesignString not in (select DesignString from ' + @Destination_Database_Name + '.dbo.sSystemStrings)'

      EXEC sp_executesql @mysql

   END
GO

-- ------------------------------------------------------------------------------------------------
-- User Strings
-- ------------------------------------------------------------------------------------------------
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'utx_Lang_UserString_UPDATE')
   DROP PROCEDURE utx_Lang_UserString_UPDATE
GO                                
CREATE PROCEDURE utx_Lang_UserString_UPDATE
  (
     @Source_Database_Name nVarchar(255),
     @Destination_Database_Name nVarchar(255),
     @Column_Name   nvarchar(255)
   )
   AS
   BEGIN 

         DECLARE @mysql         nvarchar(4000)
             SET  @mysql                     = Null

      SET  @mysql = 'UPDATE ' + @Destination_Database_Name + '.dbo.sUserStrings'
      SET  @mysql = @mysql + ' SET ' + @Column_Name + ' = (SELECT G31.' + @Column_Name
      SET  @mysql = @mysql + ' FROM ' + @Source_Database_Name + '.dbo.sUserStrings G31'
      SET  @mysql = @mysql + ' WHERE G31.DesignString = ' + @Destination_Database_Name + '.dbo.sUserStrings.DesignString'
      SET  @mysql = @mysql + ' AND G31.' + @Column_Name + ' is not null)'
      SET  @mysql = @mysql + ' WHERE (' + @Column_Name +  ' is null' 
      SET  @mysql = @mysql + ' or ' + @Column_Name + ' = ' + char(39) + char(39)
      SET  @mysql = @mysql + ' or len(ltrim(RTRIM(' + @Column_Name + + '))) < 1)'
      SET  @mysql = @mysql + ' AND DesignString in (SELECT G31.DesignString '
      SET  @mysql = @mysql + ' FROM ' + @Source_Database_Name + '.dbo.sUserStrings G31'
      SET  @mysql = @mysql + ' WHERE G31.' + @Column_Name + ' is not null)'


      --PRINT @mysql
   
      EXECUTE sp_executesql @mysql
 
   END
GO


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'utx_Lang_UserString_INSERT')
   DROP PROCEDURE utx_Lang_UserString_INSERT
GO                                
CREATE PROCEDURE utx_Lang_UserString_INSERT
  (
     @Source_Database_Name nVarchar(255),
     @Destination_Database_Name nVarchar(255),
     @Column_List   nvarchar(512)
   )
   AS
   BEGIN  

      DECLARE @mysql         nvarchar(4000)       
      SET  @mysql                       = Null

      SET @mysql = 'INSERT INTO ' + @Destination_Database_Name + '.dbo.sUserStrings('
      SET @mysql = @mysql + ' [DesignString]'
      SET @mysql = @mysql + @Column_List
      SET @mysql = @mysql + ' ,[CDate]'
      SET @mysql = @mysql + ' ,[CUser]'
      SET @mysql = @mysql + ' ,[MDate]'
      SET @mysql = @mysql + ' ,[MUser])'
      SET @mysql = @mysql + ' SELECT [DesignString]'
      SET @mysql = @mysql + @Column_List
      SET @mysql = @mysql + ' ,[CDate]'
      SET @mysql = @mysql + ' ,[CUser]'
      SET @mysql = @mysql + ' ,[MDate]'
      SET @mysql = @mysql + ' ,[MUser]'
      SET @mysql = @mysql + ' FROM ' + @Source_Database_Name + '.dbo.sUserStrings'
      SET @mysql = @mysql + ' WHERE DesignString not in (select DesignString from ' + @Destination_Database_Name + '.dbo.sUserStrings)'

      EXEC sp_executesql @mysql

   END
GO


-- ------------------------------------------------------------------------------------------------
-- Button Strings
-- ------------------------------------------------------------------------------------------------
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'utx_Lang_ButtonString_UPDATE')
   DROP PROCEDURE utx_Lang_ButtonString_UPDATE
GO                                
CREATE PROCEDURE utx_Lang_ButtonString_UPDATE
  (
     @Source_Database_Name nVarchar(255),
     @Destination_Database_Name nVarchar(255),
     @Column_Name   nvarchar(255)
   )
   AS
   BEGIN 
         DECLARE @mysql         nvarchar(4000)
             SET @mysql                     = Null
 
      SET  @mysql = 'UPDATE ' + @Destination_Database_Name + '.dbo.sSystemButtons'
      SET  @mysql = @mysql + ' SET ' + @Column_Name + ' = (SELECT G31.' + @Column_Name
      SET  @mysql = @mysql + ' FROM ' + @Source_Database_Name + '.dbo.sSystemButtons G31'
      SET  @mysql = @mysql + ' WHERE G31.DesignString = ' + @Destination_Database_Name + '.dbo.sSystemButtons.DesignString'
      SET  @mysql = @mysql + ' AND G31.' + @Column_Name + ' is not null)'
      SET  @mysql = @mysql + ' WHERE (' + @Column_Name +  ' is null' 
      SET  @mysql = @mysql + ' or ' + @Column_Name + ' = ' + char(39) + char(39)
      SET  @mysql = @mysql + ' or len(ltrim(RTRIM(' + @Column_Name + + '))) < 1)'
      SET  @mysql = @mysql + ' AND DesignString in (SELECT G31.DesignString '
      SET  @mysql = @mysql + ' FROM ' + @Source_Database_Name + '.dbo.sSystemButtons G31'
      SET  @mysql = @mysql + ' WHERE G31.' + @Column_Name + ' is not null)'


      --PRINT @mysql
   
      EXECUTE sp_executesql @mysql
   END
GO

IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'utx_Lang_ButtonString_INSERT')
   DROP PROCEDURE utx_Lang_ButtonString_INSERT
GO                                
CREATE PROCEDURE utx_Lang_ButtonString_INSERT
  (
     @Source_Database_Name nVarchar(255),
     @Destination_Database_Name nVarchar(255),
     @Column_List   nvarchar(512)
   )
   AS
   BEGIN  

      DECLARE @mysql         nvarchar(4000)       
      SET  @mysql                       = Null

      SET @mysql = 'INSERT INTO ' + @Destination_Database_Name + '.dbo.sSystemButtons('
      SET @mysql = @mysql + ' [DesignString]'
      SET @mysql = @mysql + ' ,[ButtonIcon]'
      SET @mysql = @mysql + @Column_List
      SET @mysql = @mysql + ' ,[CDate]'
      SET @mysql = @mysql + ' ,[CUser]'
      SET @mysql = @mysql + ' ,[MDate]'
      SET @mysql = @mysql + ' ,[MUser])'
      SET @mysql = @mysql + ' SELECT [DesignString]'
      SET @mysql = @mysql + ' ,[ButtonIcon]'
      SET @mysql = @mysql + @Column_List
      SET @mysql = @mysql + ' ,[CDate]'
      SET @mysql = @mysql + ' ,[CUser]'
      SET @mysql = @mysql + ' ,[MDate]'
      SET @mysql = @mysql + ' ,[MUser]'
      SET @mysql = @mysql + ' FROM ' + @Source_Database_Name + '.dbo.sSystemButtons'
      SET @mysql = @mysql + ' WHERE DesignString not in (select DesignString from ' + @Destination_Database_Name + '.dbo.sSystemButtons)'

      EXEC sp_executesql @mysql

   END
GO

-- ------------------------------------------------------------------------------------------------
-- Strings
-- ------------------------------------------------------------------------------------------------
IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'utx_Lang_LocaleString_UPDATE')
   DROP PROCEDURE utx_Lang_LocaleString_UPDATE
GO                                
CREATE PROCEDURE utx_Lang_LocaleString_UPDATE
  (
     @Source_Database_Name nVarchar(255),
     @Destination_Database_Name nVarchar(255),
     @Column_Name   nvarchar(255)
   )
   AS
   BEGIN  

	exec utx_Lang_SystemString_UPDATE
		@Source_Database_Name ,
		@Destination_Database_Name ,
		@Column_Name

	 exec utx_Lang_UserString_UPDATE
		@Source_Database_Name ,
		@Destination_Database_Name ,
		@Column_Name

	 exec utx_Lang_ButtonString_UPDATE
		@Source_Database_Name,
		@Destination_Database_Name ,
		@Column_Name


   END
GO


IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'utx_Lang_LocaleString_INSERT')
   DROP PROCEDURE utx_Lang_LocaleString_INSERT
GO                                
CREATE PROCEDURE utx_Lang_LocaleString_INSERT
  (
     @Source_Database_Name nVarchar(255),
     @Destination_Database_Name nVarchar(255)
   )
   AS
   BEGIN  
        DECLARE @ColumnList nvarchar(2000)

        SET @ColumnList = ',[da_DK], [de_DE], [en_US], [en_GB], [en_CA], [fr_FR], [fr_CA], [es_ES], [es_MX], [hi_IN], [it_IT], [ja_JA], [ko_KR], [nl_NL], [pl_PL], [pt_PT], [pt_BR], [ru_RU], [sv_FI], [sv_SE], [tr_TR], [zh_CHS], [zh_CHT]'           
	exec utx_Lang_SystemString_INSERT
		@Source_Database_Name ,
		@Destination_Database_Name ,
		@ColumnList

        SET @ColumnList = ',[da_DK], [de_DE], [en_US], [en_GB], [en_CA], [fr_FR], [fr_CA], [es_ES], [es_MX], [hi_IN], [it_IT], [ja_JA], [ko_KR], [nl_NL], [pl_PL], [pt_PT], [pt_BR], [ru_RU], [sv_FI], [sv_SE], [tr_TR], [zh_CHS], [zh_CHT]'           
	 exec utx_Lang_UserString_INSERT
		@Source_Database_Name ,
		@Destination_Database_Name ,
		@ColumnList

        SET @ColumnList = ',[da_DK], [de_DE], [en_US], [en_GB], [en_CA], [fr_FR], [fr_CA], [es_ES], [es_MX], [hi_IN], [it_IT], [ja_JA], [ko_KR], [nl_NL], [pl_PL], [pt_PT], [pt_BR], [ru_RU], [sv_FI], [sv_SE], [tr_TR], [zh_CHS], [zh_CHT]'           
	 exec utx_Lang_ButtonString_INSERT
		@Source_Database_Name,
		@Destination_Database_Name ,
		@ColumnList


   END
GO



IF EXISTS(SELECT * FROM INFORMATION_SCHEMA.ROUTINES WHERE SPECIFIC_NAME = N'utx_Lang_LanguagePack_UPDATE')
   DROP PROCEDURE utx_Lang_LanguagePack_UPDATE
GO
CREATE PROCEDURE utx_Lang_LanguagePack_UPDATE
  (
     @SrcDB nVarchar(255),
     @DestDB nVarchar(255)
   )
   AS
   BEGIN  

        --
        -- Take values in existing rows/columns in the LangPack
        -- and move them into the target DB without overwriting
        -- any data
        --
	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "da_DK"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "de_DE"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "en_US"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "en_GB"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "en_CA"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "fr_FR"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "fr_CA"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "es_ES"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "es_MX"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "hi_IN"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "it_IT"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "ja_JA"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "ko_KR"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "nl_NL"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "pl_PL"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "pt_PT"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "pt_BR"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "ru_RU"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "sv_FI"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "sv_SE"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "tr_TR"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "zh_CHS"

	exec utx_Lang_LocaleString_UPDATE
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB,
		@Column_Name = "zh_CHT"     


	--
	-- Find all rows that exist in the LangPack and move
        -- them into the target DB.
	-- 
	exec utx_Lang_LocaleString_INSERT
		@Source_Database_Name = @SrcDB,
		@Destination_Database_Name = @DestDB

   END
GO

exec utx_Lang_LanguagePack_UPDATE
	@SrcDB = N'[PLMLanguagePack]',
	@DestDB = N'$(TargetDB)'
GO

-- Clean up
DROP PROCEDURE utx_Lang_SystemString_UPDATE
DROP PROCEDURE utx_Lang_UserString_UPDATE
DROP PROCEDURE utx_Lang_ButtonString_UPDATE
DROP PROCEDURE utx_Lang_LocaleString_UPDATE
DROP PROCEDURE utx_Lang_LanguagePack_UPDATE

DROP PROCEDURE utx_Lang_SystemString_INSERT
DROP PROCEDURE utx_Lang_LocaleString_INSERT

GO

USE [master]
GO

DROP DATABASE [PLMLanguagePack]
GO

-- Done and Done :)

