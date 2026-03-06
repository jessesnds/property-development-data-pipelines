# property-development-data-pipelines
Analytics pipelines analysing 250 Sydney property development projects. The dataset I am working from contains land acquisition costs, DA approval timelines, constructions delays, defect costs and project financial performance.

Project overview:
This project builds a data transformation pipeline using dbt and Snowflake to analyse construction defect costs.
The pipeline transforms raw property development defect data into a Pareto-style mart highlighting which defect categories drive the highest remediation costs.

Tech stack:
- SQL
- dbt
- Snowflake
- GitHub

Data model structure:
  models/
  
    staging/
      stg_property_development.sql
      stg_property_development.yml

  intermediate/
    int_defect_costs_by_type.sql
    int_defect_costs_by_type.yml

  marts/
    mart_defect_pareto.sql
    mart_defect_pareto.yml


Pipeline architecture:
(This project follows a layered dbt architecture)

Raw Source
    ↓
stg_property_development
    ↓
int_defect_costs_by_type
    ↓
mart_defect_pareto

Source: 
- Defined in a dbt source.yml file
- Enables consistent referencing of raw data across models

Staging:
-	Cleans raw source data
-	Standardises column names
-	Performs light transformations 

Intermediate:
-	Aggregates defect cost by defect type
-	Calculates total and average costs
  
Mart:
-	Builds a Pareto analysis table
-	Calculates cumulative cost contribution
-	Provides metrics for analysis 

YAML files:
- Document models and columns
- Define data tests such as not_null and unique
- Provide metadata used by dbt documentation

Final output:

The final mart produces a Pareto table showing the percentage
contribution of each defect type to total remediation cost.

Key insights include:

- defect type
- defect count
- total remediation cost
- average cost
- percentage contribution to total cost
- cumulative cost contribution

Key learnings:

This project demonstrates:

Layered modelling using dbt to keep transformations modular and maintainable.
This separates concerns and allows for reusable design. Each specifically contributing to the overall data transformation. 

-	stg_property_development
    Standardises source data
    Renames fields
    Prepares dataset for downstream models 

-	int_defect_costs_by_type
    aggregates defect records by category
    calculates total and average costs

-	mart_defect_pareto
    produces Pareto style analysis of defect costs 
    calculates cumulative cost contribution 

-	Why the metrics exist?

    Cumulative cost
    Percentage of total cost
    Defect count 

All allow for identification of defect types driving the majority of remediation costs. 
