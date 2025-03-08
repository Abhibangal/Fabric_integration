[StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "STORE_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared STORE = let
  Source = Snowflake.Databases("dgdftzu-ag28036.snowflakecomputing.com", "COMPUTE_WH", [Role = null, CreateNavigationProperties = null, ConnectionTimeout = null, CommandTimeout = null]),
  #"Navigation 1" = Source{[Name = "SNOWFLAKE_SAMPLE_DATA", Kind = "Database"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Name = "TPCDS_SF100TCL", Kind = "Schema"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Name = "STORE", Kind = "Table"]}[Data]
in
  #"Navigation 3";
shared STORE_DataDestination = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false]),
  Navigation_1 = Pattern{[workspaceId = "ac1162e1-9d82-4552-a211-3728b4f843e0"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "ada73a3a-36ae-4ac5-bd80-205dd4f796c7"]}[Data],
  TableNavigation = Navigation_2{[Id = "store_dim", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
