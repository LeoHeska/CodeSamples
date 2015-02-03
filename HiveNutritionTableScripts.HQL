-- Hive Table Creation Scripts

CREATE EXTERNAL TABLE DerivDesc
  (
  deriv_code STRING,
  deriv_desc STRING
  )
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION 's3n://HOH/DataDerivationDescription';

CREATE EXTERNAL TABLE FoodDesc
  (
   NDB_No STRING,
   FdGrp_Cd STRING,
   Long_Desc STRING,
   Shrt_Desc STRING,
   ComName STRING,
   ManufacName STRING,
   Survey STRING,
   Ref_desc STRING,
   Refuse FLOAT,
   SciName STRING,
   N_Factor FLOAT,
   Pro_Factor FLOAT,
   Fat_Factor FLOAT,
   CHO_Factor FLOAT
   )
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION 's3n://HOH/FoodDescription';

CREATE EXTERNAL TABLE FoodGroupDesc
  (
  food_group_code STRING,
  food_group_desc STRING
  )
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION 's3n://HOH/FoodGroupDescription';

CREATE EXTERNAL TABLE Footnote
  (
  NDB_No STRING,
  Footnt_No STRING,
  Footnt_Typ STRING,
  Nutr_No STRING,
  Footnt_Txt STring
  )
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION 's3n://HOH/Footnote';

CREATE EXTERNAL TABLE LanguaLFactor
  (
  NDB_No STRING,
  Factor_Code STRING
  )
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION 's3n://HOH/LanguaLFactor';

CREATE EXTERNAL TABLE LanguaLFactorsDesc
  (
  Factor_Code STRING,
  description STRING
  )
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION 's3n://HOH/LanguaLFactorsDescription';

CREATE EXTERNAL TABLE NutrientData
   (
   NDB_No STRING,
   Nutr_No STRING,
   Nutr_Val FLOAT,
   Num_Data_Pts FLOAT,
   Std_Error FLOAT,
   Src_Cd STRING,
   Deriv_Cd STRING,
   Ref_NDB_No STRING,
   Add_Nutr_Mark STRING,
   Num_Studies FLOAT,
   Min FLOAT,
   Max FLOAT,
   DegreesFreedom FLOAT,
   Low_EB FLOAT,
   Up_EB FLOAT,
   Stat_comment STRING,
   AddMod_Date STRING,
   ConfCode STRING
   )
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION 's3n://HOH/NutrientData';

CREATE EXTERNAL TABLE NutrientDefinition
   (
   Nutr_No STRING,
   Units STRING,
   Tagname STRING,
   NutrDesc STRING,
   Num_Dec STRING,
   SR_Order FLOAT
   )
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION 's3n://HOH/NutrientDefinition';

CREATE EXTERNAL TABLE SourceCode
  (
  Src_Cd STRING,
  SrcDc_Desc STRING
  )
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION 's3n://HOH/SourceCode';

CREATE EXTERNAL TABLE SourcesOfData
  (
  DataSrc_ID STRING,
  Authors STRING,
  Title STRING,
  Year STRING,
  Journal STRING,
  Vol_City STRING,
  Issue_State STRING,
  Start_Page STRING,
  End_Page STRING
  )
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION 's3n://HOH/SourcesOfData';

CREATE EXTERNAL TABLE SourcesOfDataLink
  (
  NDB_No STRING,
  Nutr_No STRING,
  DataSrc_ID STRING
  )
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION 's3n://HOH/SourcesOfDataLink';

CREATE EXTERNAL TABLE Weight
  (
  NDB_No STRING,
  Seq STRING,
  Amount FLOAT,
  Msre_Desc STRING,
  Gm_Wgt FLOAT,
  Num_Data_Pts FLOAT,
  Std_Dev FLOAT
  )
ROW FORMAT DELIMITED FIELDS TERMINATED BY '|'
LOCATION 's3n://HOH/Weight';
