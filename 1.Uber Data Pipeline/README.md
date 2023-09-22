# Uber Data Engineering 

## Table of Contents

- [Introduction](#introduction)
- [Architecture of the Data Pipeline](#architecture-of-the-data-pipeline)
- [Technologies utilized](#technologies-utilized)
- [Data Cleaning and Transformation](#data-cleaning-and-transformation)
- [Data Storage and VM configuration](#data-storage-and-vm-configuration)
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

[Back to Table of Contents](#table-of-contents)

## Data Cleaning and Transformation

Once we’ve downloaded the csv file as mentioned above, we will need to convert our flat file into some fact and dimensional tables. The former ones will contain items with high cardinality or transaction values, whereas the latter ones will be assigned to merely descriptive values. More info on some concepts of dimensional data modeling can be found [here.]( https://www.ibm.com/docs/en/informix-servers/14.10?topic=model-concepts-dimensional-data-modeling
)


NB: Tables such as `passenger count ` or  `trip distance` would suit better to be created as fact tables - their values they keep varying- , but for the purpose on focusing on the ETL pipeline process we will create them as dimensional ones. The final diagram of the data model then is:

![Uber DE model](https://github.com/GBlanch/Data-Engineering/assets/136500426/fa3120af-3d6e-4b44-ac04-8f130a9cd8e8)



So now we’re ready to perform all the `cleaning and transformation` work before we deploy this code into Mage. The script with its explanation to the development of this code can be read [`here.`](https://github.com/GBlanch/Data-Engineering/blob/main/1.Uber%20Data%20Pipeline/Uber%20DE%20Transform%20and%20Model%20(LM).ipynb)

[Back to Table of Contents](#table-of-contents)

## Data Storage and VM configuration

Before we store our data flat file into our Cloud Storage, we have to create our Project and Bucket in GCS.

![image](https://github.com/GBlanch/Data-Engineering/assets/136500426/a3802e5c-29ab-49e6-a1b9-76b2032c100d)

![image](https://github.com/GBlanch/Data-Engineering/assets/136500426/1967e5d9-6c86-4c0b-9c61-2908d776c0e5)

Once the object is uploaded, in the Permissions tab, we edit access control from `Uniform` to `Fine-grained`. 

![image](https://github.com/GBlanch/Data-Engineering/assets/136500426/fb50cce6-381d-4735-a074-b424e8a8582b)

Then we go to the object and we add an entry within the `Edit Access` option so that we generate a pubic URL for this object. The next step is to set up the Computer Engine. To do that, we have to create an instance from within it. We need to select the nearest region again, the series and type of our VM as well:

![image](https://github.com/GBlanch/Data-Engineering/assets/136500426/f1ba30ed-382b-4961-a591-aea442f408e4)

On the firewall section, we must allow HTTP and HTTPS traffic so that we can access it once we deploy our code.
Once the instance is created, to connect to it we just need to directly run the SSH-in-browser without the requisite to download any SSH keys.

Once we’re connected to the virtual machine, we run some commands to set up the proper environment within it. These are:

![image](https://github.com/GBlanch/Data-Engineering/assets/136500426/530f6cd1-1678-407b-9136-a01aa97cf04d)

Then we set up Mage in our virtual machine and start our project:

![image](https://github.com/GBlanch/Data-Engineering/assets/136500426/e999c1cc-9428-48d3-97b9-7aa581faea7d)

![image](https://github.com/GBlanch/Data-Engineering/assets/136500426/7473b1e4-c5de-4c3f-bfa4-94bf5e69e042)


We can see at the last line that it is running on the indicated local host 6789. To allow our instance to accept requests from this mentioned port, we need to create a new Firewall Rule :

![image](https://github.com/GBlanch/Data-Engineering/assets/136500426/7e53f9ba-96ad-41db-afc4-ffbc468c5348)

![image](https://github.com/GBlanch/Data-Engineering/assets/136500426/e1cb880c-1fd8-49a4-a609-3f566af24904)

And so we have established the connection within mage from our VM.

[Back to Table of Contents](#table-of-contents)

## ETL Orchestration

[Back to Table of Contents](#table-of-contents)

## Data Analysis

[Back to Table of Contents](#table-of-contents)

## Dashboarding

[Back to Table of Contents](#table-of-contents)



