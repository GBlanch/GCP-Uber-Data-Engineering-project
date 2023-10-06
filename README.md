# GCP Uber Data Engineering 

## Table of Contents

- [Introduction](#introduction)
- [Architecture of the Data Pipeline](#architecture-of-the-data-pipeline)
- [Code and Services utilized](#code-and-services-utilized)
- [Data Transformation and Modeling](#data-transformation-and-modeling)
- [Data Storage and VM configuration](#data-storage-and-vm-configuration)
- [ETL Orchestration](#etl-orchestration)
- [Data Analysis](#data-analysis)
- [Dashboarding](#dashboarding)
&nbsp;    
&nbsp;  

## Introduction

The main purpose of this project is to detail the core stages of an end-to-end pipeline Data Engineering project. Therefore, many of the aspects regarding Business Intelligence, Analytics and Dashboarding will be out of the scope for this project.

The structure of the architecture of this end-to-end data pipeline is detailed in the following section. 
&nbsp;    
&nbsp;  

## Architecture of the Data Pipeline


![image](https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/assets/136500426/f2e66f07-4ea1-4f77-83e0-2dde5056d9bc)


The diagram above primarily shows the required stages once the raw data is gathered.

The csv file can be obtained under request from [NYC Taxi & Limousine Commission website](https://www.nyc.gov/site/tlc/about/request-data.page). We could upload at the same time this flat file into Google Cloud Storage, but we rather do it once we have all our code ready to be deployed (we will be needing to configure our Google Cloud Platform settings further on)

Using the data catalogue provided in the website above - and prior to doing anything else -  we need to understand and design the data model structure to be adhered to within this project.
Once the data modeling is done, we will perform the cleaning and transformation coding required to attain the desired data model. This stage will be performed using Python within Jupyter Notebooks, and it will all run be in our LM.

After this, we can store our data flat file in our Cloud Storage and also start setting up all the Cloud services to be used. 

Next, we will be ready to deploy this code into our open-source data pipeline tool Mage. After we’ve created the main ETL batch pipeline in Mage, we will orchestrate it using a Virtual Machine within GCE. This will also allow us to export our dataframes into our data warehouse in BigQuery further on.

Once the data is exported, we can start querying the parameters and variables we want to display into our reports/dashboards further on.

Finally, Looker Studio will allow us to create some dashboards according to the queries we have prepared before.

[Back to Table of Contents](#table-of-contents)
&nbsp;    
&nbsp;  

## Code and Services utilized

### Coding:

We will use `Python` within `Jupyer Notebook` as computing platform to arrange our fact and dimensional tables according to our data model.
`Python` also will be used to modify the `ETL blocks/instances` in the orchestration stage.

Once the dataframes are deployed into our data warehouse, we are going to code in `SQL` to fetch the tables we requiere. Likewise, we will elaborate the queries to select the information we want to display in the final dashboards. 

We will also employ some `bash` code mostly to install some depencencies in our `Virtual Machine` and to run some commands from within.

### Services

`Google Cloud Platform` will be the main source of cloud computing services for this project. These being:

+ Storage: `Cloud Storage`
+ Virtual Machine : `Computer Engine`
+ Analytics : `BigQuery`
+ Dashboarding :  `Looker Studio`  

For orchestrating the `ETL process` in our Virtual Machine, we will use `Mage` as an open-source, hybrid framework for transforming and integrating our dataframes.

[Back to Table of Contents](#table-of-contents)
&nbsp;    
&nbsp;  

## Data Transformation and Modeling

Once we’ve downloaded the csv file as mentioned above, we will need to convert our `flat file` into some `fact` and `dimensional tables`. The former ones will contain items with high cardinality or transaction values, whereas the latter ones will be assigned to merely descriptive values. More info on some concepts of dimensional data modeling can be found [here.](https://www.ibm.com/docs/en/informix-servers/14.10?topic=model-concepts-dimensional-data-modeling)


NB: Tables such as `passenger count ` or  `trip distance` would suit better to be created as fact tables - their values they keep varying- , but for the purpose on focusing on the ETL pipeline process we will create them as dimensional ones. 

The final diagram of the data model then results:

<p align="center">
<img src="https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/assets/136500426/1a920215-a8c6-48f5-b1e3-38c36b0ad6fb"  width="70%" height="70%">


So now we’re ready to perform all the `cleaning and transformation` work before we deploy this code into Mage. The script with its explanation to the development of this code can be read [`here.`](https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/blob/main/Uber%20DE%20Transform%20and%20Model%20(LM).ipynb)

[Back to Table of Contents](#table-of-contents)
&nbsp;    
&nbsp;  

## Data Storage and VM configuration

Before we store our object / data flat file into our Cloud Storage, we have to create our `Project` and `Bucket` in GCS.
Then we can store our object in this new bucket:

<p align="center">
<img src="https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/assets/136500426/e685b676-20df-47a2-935b-37959bf3d8e1"  width="75%" height="75%">

<p align="center">
<img src="https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/assets/136500426/42f5fe80-59a0-4edc-8eb9-5bd2590bbd91"  width="75%" height="75%">

Once the object is uploaded, in the `Permissions tab`, we edit access control from `Uniform` to `Fine-grained`. 

<p align="center">
<img src="https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/assets/136500426/01d87bac-a777-4c73-a235-04c87f48bbc7"  width="40%" height="40%">


Then we go to the object and we add an entry within the `Edit Access` option so that we generate a pubic URL for this object. The next step is to set up the `Computer Engine`. To do that, we have to `create an instance` from within our `Cloud console`. We need to select the nearest region again, the series and type of our VM as well:

![image](https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/assets/136500426/fd808491-d4dd-41c5-808d-574824eb8fc3)


<p align="center">
<img src="https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/assets/136500426/102b3c44-ce1b-497c-8ca0-8aa2ee8df190" width="70%" height="70%">

On the `Firewall section`, we must `allow HTTP` and `HTTPS traffic` so that we can access it once we deploy our code.
Once the instance is created, to connect to it we just need to directly run the `SSH-in-browser` without the requisite of downloading any SSH keys.

Once we’re connected to the virtual machine, we run some `bash commands` to set up the proper environment. These are:

    # Update os version and install latest files
    
    	sudo apt-get install update
    
    
    # Install required Python dependencies
    
    	sudo apt-get install python3-distutils
    
    	sudo apt-get install python3-apt
    
    	sudo apt-get install wget
    
    	wget https://bootstrap.pypa.io/get-pip.py
    
    	sudo python3 get-pip.py
    
    # Install Pandas
    
    	sudo pip3 install pandas

Then we set up Mage in our virtual machine and start our project:

    #  Mage installation
    
    	sudo pip3 install mage-ai
    
    # Mage start
    	
    	mage start ude_project	

<p align="center">
<img src="https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/assets/136500426/6bc7d16f-6bd7-46ea-a140-7587914c1703" >

We can see at the last line that it is running on the indicated local host 6789. To allow our instance to accept requests from this mentioned port, we need to create a new `Firewall Rule`:

<p align="center">
<img src="https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/assets/136500426/190b752a-40bb-420a-a47d-eab7492d2929"  width="90%" height="90%">


<p align="center">
<img src="https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/assets/136500426/f96304b4-7104-4833-a4ff-e9533b576308">


And so we have already established the connection within mage from our VM.

[Back to Table of Contents](#table-of-contents)
&nbsp;    
&nbsp;  

## ETL Orchestration

<p align="center">
<img src="https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/assets/136500426/ee2c157a-234b-4179-8752-6250f6b9255f" >


+ Extract: [`uber_de_extract.py`](https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/blob/main/orchestration/batch%20pipeline/uber_de_extract.py)

```python
import io
import pandas as pd
import requests
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Template for loading data from API
    """
    url = 'https://storage.googleapis.com/uber_data_eng_bucket/uber_data.csv'
    response = requests.get(url)

    return pd.read_csv(io.StringIO(response.text), sep=',')


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
 ```
  We `pass the URL` stored in our bucket so that it directly extracts data from there.  That will allow the Pandas 
  dataframes to be pulled from the bucket into this mage instance.

+ Transform: [`uber_de_transform.py`](https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/blob/main/orchestration/batch%20pipeline/uber_de_transform.py)

  We first import pandas in this instance as well. Next, we insert the [`cleaning and transformation code`](https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/blob/main/Uber%20DE%20Transform%20and%20Model%20(LM).ipynb) we developed in our LM previously using `Jupyer Notebooks`.

+ Load:[`uber_de_load.py`](https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/blob/main/orchestration/batch%20pipeline/uber_de_load.py)
  
  First off, we need to install the Google Cloud Service packages into our VM:

      # Install Google Cloud Library
    
    	sudo pip3 install google-cloud
    
    	sudo pip3 install google-cloud-bigquery
 
    Then we will need to create an access key so that we can pass the credentials into the default yaml file in the Load block. This key can be 
    downloaded to our LM in json format from the `API & Services` section in our Google console.
  
  Once the credentials are passed into our Load block in Mage, we create a `Dataset location` within `BigQuery`. Besides allowing BigQuery to locate the dataframes to be received, this will also allow Mage to acknowledge the destination  of these.

```python
from mage_ai.settings.repo import get_repo_path
from mage_ai.io.bigquery import BigQuery
from mage_ai.io.config import ConfigFileLoader
from pandas import DataFrame
from os import path

if 'data_exporter' not in globals():
    from mage_ai.data_preparation.decorators import data_exporter


@data_exporter
def export_data_to_big_query(data, **kwargs) -> None:
    """
    Template for exporting data to a BigQuery warehouse.
    Specify your configuration settings in 'io_config.yaml'.

    Docs: https://docs.mage.ai/design/data-loading#bigquery

    """

    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'default'

    for key, value in data.items():
        table_id = 'uber-data-eng-19sep2023.uber_de_dataset.{}'.format(key)
        BigQuery.with_config(ConfigFileLoader(config_path, 
                                              config_profile)).export(
        DataFrame(value),
        table_id,
        if_exists = 'replace',  # Specify resolution policy if table name already exists
    )
```

Once the pipeline is successfully executed, we can check the location of these dataframes into the `Data Warehouse` in BigQuery:

![image](https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/assets/136500426/1e5dc6a6-66c6-4dcf-a0f9-93b3978f9d8a)


[Back to Table of Contents](#table-of-contents)
&nbsp;    
&nbsp;  

## Data Analysis

Despite the Data Eng. work has been mostly finalized, we proceed to perform some `Data Analysis`. 
For doing this, we will only pull the columns we want to include in our dashboards by creating specific queries. 

Hence, our new table or `analytical layer` from which we will build our dashboard is the following:

```SQL 
CREATE OR REPLACE TABLE `uber-data-eng-19sep2023.uber_de_dataset.analytics_table` AS (
  SELECT 
    f.trip_id,
    f.VendorID,
    dt.tpep_pickup_datetime,
    dt.tpep_dropoff_datetime,
    pc.passenger_count,
    t.trip_distance,
    r.rate_code_name,
    p.pickup_latitude,
    p.pickup_longitude,
    d.dropoff_latitude,
    d.dropoff_longitude,
    pay.payment_type_name,
    f.fare_amount,
    f.extra,
    f.tip_amount,
    f.tolls_amount,
    f.total_amount
  FROM `uber-data-eng-19sep2023.uber_de_dataset.fact_table` f
  JOIN `uber-data-eng-19sep2023.uber_de_dataset.datetime_dim` dt  
    ON f.datetime_id = dt.datetime_id
  JOIN `uber-data-eng-19sep2023.uber_de_dataset.passenger_count_dim` pc  
    ON pc.passenger_count_id = f.passenger_count_id  
  JOIN `uber-data-eng-19sep2023.uber_de_dataset.trip_distance_dim` t  
    ON t.trip_distance_id = f.trip_distance_id  
  JOIN `uber-data-eng-19sep2023.uber_de_dataset.rate_code_dim` r 
    ON r.rate_code_id = f.rate_code_id  
  JOIN `uber-data-eng-19sep2023.uber_de_dataset.pickup_location_dim` p 
    ON p.pickup_location_id = f.pickup_location_id
  JOIN `uber-data-eng-19sep2023.uber_de_dataset.dropoff_location_dim` d 
    ON d.dropoff_location_id = f.dropoff_location_id
  JOIN `uber-data-eng-19sep2023.uber_de_dataset.payment_type_dim` pay 
    ON pay.payment_type_id = f.payment_type_id
    )
  ;
```

We notice that we mainly have joined innerly the fact table to the rest of the dimensional tables as the [`data model`](https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/blob/main/data%20model/Uber%20DE%20model.png) states.

Again, the purpose of this project wasn't to construct many series of queries but to showcase the main stages of a data pipeline using GCP. 
You can see more `query developement` in other repos, i.e. any of the other [`SQL-weekly-challenges`](https://github.com/GBlanch/SQL-weekly-challenges/blob/main/4.Data%20bank/query_develop/dev_query_4_31AUG23.sql) I elaborated.

[Back to Table of Contents](#table-of-contents)
&nbsp;    
&nbsp;  

## Dashboarding

After performing some quick work with `Looker Studio`, these are the dashboards I came up with:

![image](https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/assets/136500426/23ec5683-1393-463f-989f-be3d9e043506)


![image](https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/assets/136500426/334edc21-e955-490a-a995-70afd5201ca2)


![image](https://github.com/GBlanch/GCP-Uber-Data-Engineering-project/assets/136500426/72df3de0-721c-4b5c-994b-633f750f322d)


We can see in the bubble chart that some observations - pick up geolocations in water spots - needed to be removed as part of data cleaning. To detect these prior to see them visualized was tought to execute. The [`scope of this project`](#introduction) nonetheless was to showcase the End-to-End pipeline main phases of a Data Engineering project.


[Back to Table of Contents](#table-of-contents)



