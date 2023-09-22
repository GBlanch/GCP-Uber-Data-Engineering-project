# Uber Data Engineering 

## Table of Contents

- [Introduction](#introduction)
- [Architecture of the Data Pipeline](#architecture-of-the-data-pipeline)
- [Technologies utilized](#technologies-utilized)
- [Data Cleaning and Transformation](#data-cleaning-and-transformation)
- [Data Storage](#data-storage)
- [ETL Orchestration](#etl-orchestration)
- [Data Analysis](#data-analysis)
- [Dashboarding](#dashboarding)


## Introduction

The main purpose of this project is to detail the core stages of an end-to-end pipeline Data Engineering project on GCP. Therefore, many of the aspects regarding Business Intelligence, Analytics and Dashboarding will be out of the scope of this project.
The structure of the architecture of this end-to-end data pipeline is detailed in the following section. 

## Architecture of the Data Pipeline

![image](https://github.com/GBlanch/Data-Engineering/assets/136500426/9133fc2a-a684-4d97-9260-8792304b2838)

The diagram above primarily shows the required stages once the raw data is gathered.

The csv file can be obtained under request from [NYC Taxi & Limousine Commission website](https://www.nyc.gov/site/tlc/about/request-data.page). We could upload at the same time this flat file into Google Cloud Storage, but we rather do it once we have all our code ready to be deployed (we will be needing to configure our GCP settings further on)

Using the data catalogue provided in the website above - and prior to doing anything else -  we need to understand and design the data model structure to be adhered to within this project.
Once the data modeling is done, we will perform the cleaning and transformation coding required to attain the desired data model. This stage will be performed using Python within Jupyter Notebooks, and it will all run in our LM.

After this, we can store our data flat file in our Cloud Storage and also start setting up all the Cloud services to be used. 

Next, we will be ready to deploy this code into our open-source data pipeline tool Mage. After we’ve created the main ETL bash pipeline in Mage, we will orchestrate it using our IaaS Computer Engine (VM) so that it can be exported into our data warehouse BigQuery.

Once the data is exported, we can start querying the parameters and variables we want to display into our reports/dashboards further on.

Finally, Looker Studio will allow us to create some dashboards according to the queries we have prepared before.

[Back to Table of Contents](#table-of-contents)

## Technologies utilized

## Data Cleaning and Transformation

Once we’ve downloaded the csv file as mentioned above, we will need to convert our flat file into some fact and dimensional tables. The former ones will contain items with high cardinality or transaction values, whereas the latter ones will be assigned to merely descriptive values. More info on some concepts of dimensional data modeling can be found [here.]( https://www.ibm.com/docs/en/informix-servers/14.10?topic=model-concepts-dimensional-data-modeling
)
NB: Tables such as `passenger count ` or  `trip distance` would suit better to be created as fact tables - their values they keep varying- , but for the purpose on focusing on the ETL pipeline process we will create them as dimensional ones. The final diagram of the data model is

![Uber DE model](https://github.com/GBlanch/Data-Engineering/assets/136500426/fa3120af-3d6e-4b44-ac04-8f130a9cd8e8)


## Data Storage

## ETL Orchestration

## Data Analysis

## Dashboarding




