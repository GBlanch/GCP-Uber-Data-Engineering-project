# Uber Data Engineering 

## Table of Contents

- [Introduction](#introduction)
- [Architecture of the Data Pipeline](#architecture-of-the-data-pipeline)
- [Technologies utilized]()
- [Data Cleaning and Transformation()
- [Data Storage]()
- [ETL Orchestration]()
- [Data Analysis]()
- [Dashboarding]()


## Introduction

The main purpose of this project is to detail the core stages of an end-to-end pipeline Data Engineering project on GCP. Therefore, many of the aspects regarding Business Intelligence, Analytics and Dashboarding will be out of the scope of this project.
The structure of the architecture of this end-to-end data pipeline is detailed in the following section. 

## Architecture of the Data Pipeline

![image](https://github.com/GBlanch/Data-Engineering/assets/136500426/9133fc2a-a684-4d97-9260-8792304b2838)

The diagram above primarily shows the required stages once the raw data is gathered.  The csv file can be obtained under request from NYC Taxi & Limousine Commission website. We could upload at the same time this flat file into Google Cloud Storage, but we rather do it once we have all our code ready to be deployed (we will be needing to configure our GCP settings further on)
Using the data catalogue provided in the website above - and prior to doing anything else -  we need to understand and design the data model structure to be adhered to within this project.
Once the data modeling is done, we will perform the cleaning and transformation coding required to attain the desired data model. This stage will be performed using Python within Jupyter Notebooks, and it will all run in our LM.
After this, we can store our data flat file in our Cloud Storage and also start setting up all the Google Cloud services to be used. 
Next, we will be ready to deploy this code into our open-source data pipeline tool Mage. After we’ve created the main ETL bash pipeline in Mage, we will orchestrate it using our IaaS Computer Engine (VM) so that it can be exported into our data warehouse BigQuery.
Once the data is exported, we can start querying the data we want to display into our reports/dashboards further on.
Finally, Looker Studio will allow us to create some dashboards according to the queries we have prepared before.




