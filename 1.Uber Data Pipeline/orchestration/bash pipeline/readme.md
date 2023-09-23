![mage collaped blocks and tree](https://github.com/GBlanch/Data-Engineering/assets/136500426/25b8bbce-5d0a-4349-8309-d304ebff7b1e)


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
